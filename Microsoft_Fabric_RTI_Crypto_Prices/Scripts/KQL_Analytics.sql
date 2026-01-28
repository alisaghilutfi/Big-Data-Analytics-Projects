-- 1. Calculate 1-minute rolling windows for the last 15 minutes
CryptoTransformed
| where event_time_utc > ago(15m)
| summarize 
    avg_price = avg(price), 
    min_price = min(price), 
    max_price = max(price), 
    stdev_price = stdev(price) 
  by bin(event_time_utc, 1m), symbol
| sort by symbol asc, event_time_utc asc // This "serializes" the data
| extend price_change = avg_price - prev(avg_price)
| order by event_time_utc desc


-- 2. Detect Spikes (Streaming Anomaly Detection)
let baseline = 
    CryptoTransformed
    | where event_time_utc > ago(2h) and event_time_utc < ago(10m)
    | summarize baseline_avg = avg(price) by symbol;

CryptoTransformed
| where event_time_utc > ago(10m) 
| join kind=inner baseline on symbol 
| extend pct_change = (price - baseline_avg) / baseline_avg * 100
| where abs(pct_change) > 0.1 
| project event_time_utc, symbol, current_price=price, baseline_price=baseline_avg, pct_change
| order by event_time_utc desc


-- 3. Comparing the current price to the average of the last hour. If the deviation exceeds 2%, it triggers.
let threshold = 2.0;
let baseline = 
    CryptoTransformed
    | where event_time_utc between (ago(1h) .. ago(3m))
    | summarize avg_price = avg(price) by symbol;
CryptoTransformed
| where event_time_utc > ago(3m)
| summarize current_price = any(price) by symbol
| join kind=inner baseline on symbol
| extend pct_change = round((current_price - avg_price) / avg_price * 100, 2)
| where abs(pct_change) >= threshold
| project symbol, current_price, avg_price, pct_change, message = strcat("🚀 Price Spike Alert for ", symbol)


-- 4. Detecting when a coin becomes "choppy." It compares the standard deviation of the last 5 minutes to the hour prior. 
-- If volatility doubles ($2\times$), it alerts.
let recent_vol = 
    CryptoTransformed | where event_time_utc > ago(10m)
    | summarize vol5m = stdev(price) by symbol;
let historical_vol = 
    CryptoTransformed | where event_time_utc between (ago(1h) .. ago(10m))
    | summarize vol_hist = stdev(price) by symbol;
recent_vol
| join kind=inner historical_vol on symbol
| where vol5m > (vol_hist * 2) // Alert if volatility is 2x higher than normal
| project symbol, vol5m, vol_hist, status = "⚠️ High Volatility Detected"