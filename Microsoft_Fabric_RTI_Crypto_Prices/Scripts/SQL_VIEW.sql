-- Create a Gold View for daily/hourly trends
CREATE VIEW Gold_Crypto_Daily AS
SELECT 
    symbol,
    -- This strips minutes and seconds to create an 'hour bucket'
    DATEADD(hour, DATEDIFF(hour, 0, event_time_utc), 0) as hour_bucket,
    AVG(CAST(price AS FLOAT)) as avg_hourly_price,
    STDEV(CAST(price AS FLOAT)) as volatility
FROM Crypto_Price
GROUP BY symbol, DATEADD(hour, DATEDIFF(hour, 0, event_time_utc), 0);