-- 1. Live Price Ticker
CryptoTransformed
| summarize arg_max(event_time_local, price) by symbol
| project symbol, price


-- 2. Price Over Time - Last 15 Min (Timechart)
-- 2.1 Filter by your Whitelist
let top_assets = dynamic(["BTCUSDT", "ETHUSDT", "SOLUSDT", "TRXUSDT", "BNBUSDT"]);
CryptoTransformed
| where event_time_local > ago(70m)
| where symbol in (top_assets)
| summarize avg(price) by bin(event_time_local, 1m), symbol
| render timechart

-- 2.2 The "Top N" by Volume or Volatility
let top10_movers = 
    CryptoTransformed
    | where event_time_local > ago(100m)
    | summarize volatility = stdev(price) by symbol
    | top 10 by volatility
    | project symbol;
CryptoTransformed
| where event_time_local > ago(100m)
| where symbol in (top10_movers)
| summarize avg(price) by bin(event_time_local, 1m), symbol
| render timechart