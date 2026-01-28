-- 1. Move RawData table to the Bronze folder
.create-merge table CryptoRaw 
    (symbol:string, price:real, source:string, event_time_utc:string, event_time_local:string, ingestion_time:string) 
with (folder="Bronze")

-- 2. Create the CryptoTransformed table and move it to the Silver folder
.create-merge table CryptoTransformed 
    (symbol:string, price:real, source:string, event_time_utc:datetime, event_time_local:datetime, ingestion_time:datetime) 
with (folder="Silver")

-- 3. Transformation Logic (The "Cleaning" Step)
.set-or-append CryptoTransformed <|
CryptoRaw
| extend 
    price = toreal(price),
    event_time_utc = todatetime(event_time_utc),
    event_time_local = todatetime(event_time_local),
    ingestion_time = todatetime(ingestion_time)
| project symbol, price, source, event_time_utc, event_time_local, ingestion_time

-- 4. Create function with transformation logic
.create-or-alter function TransformCryptoRaw () {
    CryptoRaw
    | extend 
        price = toreal(price),
        event_time_utc = todatetime(event_time_utc),
        event_time_local = todatetime(event_time_local),
        ingestion_time = todatetime(ingestion_time)
    | project symbol, price, source, event_time_utc, event_time_local, ingestion_time
}

-- 5. Automatically update CryptoTransformed table
.alter table CryptoTransformed policy update 
```[{
    "IsEnabled": true,
    "Source": "CryptoRaw",
    "Query": "TransformCryptoRaw",
    "IsTransactional": true,
    "PropagateIngestionProperties": false
}]```