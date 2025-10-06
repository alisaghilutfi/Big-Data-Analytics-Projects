
# NYC Taxi Data Analytics in Microsoft Fabric
## End-to-End Transportation Intelligence Platform for 2024 Yellow Taxi Operations


## 📊 Project Overview
This Microsoft Fabric project delivers a comprehensive end-to-end data analytics solution for New York City's yellow taxi operations using 2024 trip record data. The platform demonstrates modern lakehouse architecture, implementing data ingestion, transformation, warehousing, and interactive reporting capabilities to provide actionable insights into taxi service patterns, revenue trends, and operational efficiency.


## 🎯 Business Objectives
`Primary Goal:` Build scalable analytics infrastructure for NYC taxi operational intelligence

`Target Audience:` Transportation analysts, city planners, taxi operators, and regulatory authorities

`Key Questions Addressed:`
- What are the revenue patterns across different payment methods and time periods?
- Which pickup and dropoff zones generate the highest trip volumes?
- How do different vendors (Creative Mobile Technologies, Curb Mobility, Myle Technologies) perform?
- What are the peak travel periods and route patterns across NYC boroughs?
- How do various rate codes (Standard, JFK, Newark) impact revenue distribution?


## 📈 Key Data Attributes

![Features](https://github.com/alisaghilutfi/Big-Data-Analytics-Projects/blob/master/NYC_Taxi-End-to-End-Data-Analytics-in-Microsoft-Fabric/Images/Features.PNG)


## 🏗️ Architecture Components
The Microsoft Fabric solution implements a complete medallion architecture:

![Main Root Project](https://github.com/alisaghilutfi/Big-Data-Analytics-Projects/blob/master/NYC_Taxi-End-to-End-Data-Analytics-in-Microsoft-Fabric/Images/01.PNG)

### Data Ingestion Layer (Bronze)
- **Lakehouse Storage:** Project_Lakehouse with structured file organization
- **Raw Data Files:** 12 monthly parquet files (yellow_tripdata_2024-01 through 2024-12)
- **Reference Data:** taxi_zone_lookup.csv with 265 location records
- **File Format:** Optimized parquet format for efficient querying (47-61 MB per month)

### Data Transformation Layer (Silver)
- **Data Pipeline:** pl_stg_tripdata for orchestrated data processing
- **Data Flow:** dfG2_pres_taxi_tripdata with 20-step transformation logic
- **Staging Views:** Cleaned and validated trip data
- **Stored Procedures:** 
  - sp_removing_outlier_tripdata (data quality checks)
  - sp_loading_staging_metadata (metadata management)
- **Variables:** Parameterized date ranges (v_date, v_end_date) for flexible processing

### Data Warehouse Layer (Gold)
- **SQL Analytics Endpoint:** Project_Warehouse for optimized querying
- **Schema:** Dimensional model with fact and dimension tables
- **Table:** taxi_tripdata with 11 columns including geography and payment dimensions
- **Views:** Pre-aggregated views for common query patterns
- **Performance:** Indexed for fast query response times

### Orchestration & Automation
- **Data Pipelines:**
  - pl_stg_tripdata: Staging data ingestion
  - pl_stg_lookup: Reference data processing  
  - pl_pres_merged_data: Dimension merging
  - pl_orchestrate_nyctaxi: Master orchestration pipeline
- **Invoke Patterns:** Cascading pipeline execution for reliable processing
- **Scheduling:** Automated refresh capabilities

### Semantic Layer
- **Semantic Model:** semantic_model_nyctaxi with relationships and measures
- **Data Model:** Star schema with optimized relationships
- **DAX Measures:** Revenue calculations, trip aggregations, passenger counts
- **Refresh Strategy:** Incremental refresh for performance optimization


## 📊 Power BI Dashboard
The interactive reporting solution provides comprehensive analytics:

![PowerBI dashboard](https://github.com/alisaghilutfi/Big-Data-Analytics-Projects/blob/master/NYC_Taxi-End-to-End-Data-Analytics-in-Microsoft-Fabric/Images/05_2.PNG)

### Executive Overview
- **KPI Cards:**
  - Number of Passengers: 6.57M
  - Number of Trips: 6.89M
  - Total Revenue: $180.41M
- **Date Range Slicer:** Interactive filtering (1/18/2024 - 2/3/2024 shown)
- **Payment Method Filter:** Cash, Credit Card, Dispute, Flex Fare Trip, No Charge
- **Vendor Selection:** Creative Mobile Technologies, Curb Mobility, Myle Technologies

### Revenue Analytics
- **Daily Revenue by Date and Payment Method:** Stacked bar chart showing cash vs credit card trends
- **Temporal Analysis:** Daily granularity from Jan 18 to Feb 3
- **Payment Mix Visualization:** Color-coded by payment type for easy pattern identification
- **Trend Identification:** Clear visibility of daily fluctuations and patterns

### Geographic Analysis
- **Pickup/Dropoff Matrix:** Detailed table showing borough and zone combinations
- **Trip Volume Breakdown:** Number of trips by pickup zone and dropoff zone pairs
- **Top Routes:** Manhattan to Manhattan routes dominate (Upper East Side, Midtown)
- **Borough Distribution:** Clear visibility of inter-borough travel patterns


## 🛠️ Technical Implementation
### Tools & Technologies
- **Primary Platform:** Microsoft Fabric (Unified Analytics Platform)
- **Data Storage:** OneLake with Lakehouse architecture
- **Data Processing:** Data Factory Gen2 pipelines and dataflows
- **Transformation Engine:** Power Query with 20+ transformation steps
- **Data Warehouse:** SQL Analytics Endpoint
- **Orchestration:** Fabric pipelines with stored procedures
- **Visualization:** Power BI integrated reporting
- **Data Format:** Parquet (compressed columnar storage)

### Fabric Workloads Used
**Lakehouse:**
- Scalable data lake storage
- ACID transaction support
- Direct SQL query capabilities

**Data Pipeline:**
- Visual ETL/ELT orchestration
- Parameterized execution
- Activity monitoring and logging

**Dataflow Gen2:**
- Power Query transformation at scale
- Data quality and cleansing operations
- Column removal and renaming logic

**SQL Analytics Endpoint:**
- T-SQL query interface
- Automatic table generation
- Integration with semantic models

**Power BI:**
- Native Fabric integration
- Direct Lake mode for performance
- Interactive filtering and drill-through

### Data Quality Measures
**Outlier Removal:**
- Stored procedure sp_removing_outlier_tripdata
- Statistical validation of trip metrics
- Automated data cleansing workflows

**Metadata Management:**
- sp_loading_staging_metadata for lineage tracking
- Processing timestamps and row counts
- Data quality monitoring

**Transformation Steps:**
- 20 applied steps in main dataflow
- 5 steps in lookup processing
- Renamed columns for clarity (payment_method, passenger_count)
- Removed unnecessary columns (do_location_id)


## 📈 Data Processing Flow
1. **Ingestion:** Monthly parquet files loaded into Lakehouse
2. **Staging:** pl_stg_tripdata copies raw data to staging tables
3. **Lookup Processing:** pl_stg_lookup processes zone reference data
4. **Transformation:** dfG2_pres_taxi_tripdata applies business logic
5. **Quality Checks:** Outlier removal and validation procedures execute
6. **Merging:** pl_pres_merged_data joins trip data with geographic dimensions
7. **Loading:** Cleaned data loaded to Warehouse taxi_tripdata table
8. **Semantic Layer:** Power BI semantic model refreshed automatically
9. **Reporting:** Interactive dashboards update with latest data


## 💡 Business Impact
This solution enables NYC taxi stakeholders to:
- **Optimize Fleet Management** - Identify high-demand zones and time periods
- **Revenue Forecasting** - Predict revenue patterns based on historical trends
- **Route Planning** - Understand popular routes and travel patterns
- **Vendor Performance** - Compare technology provider metrics
- **Regulatory Compliance** - Track congestion fees and surcharges
- **Strategic Planning** - Make data-driven decisions on service expansion


## 🔄 Scalability & Performance
- **Incremental Processing** - Date-parameterized pipelines for efficient updates
- **Parquet Optimization** - Compressed columnar format reduces storage by 60%
- **Direct Lake Mode** - Power BI queries data directly from OneLake
- **Partitioning Strategy** - Monthly file organization for query optimization
- **Medallion Architecture** - Clear separation of raw, curated, and presentation layers


## 🎓 Key Learnings
This project demonstrates:
- End-to-end Fabric implementation from ingestion to visualization
- Medallion architecture best practices (Bronze/Silver/Gold)
- Pipeline orchestration with multiple interdependent workflows
- Integration of multiple Fabric experiences (Lakehouse, Warehouse, Power BI)
- Real-world big data processing (6.8M+ records)
- Geographic dimension modeling with TLC zones
- Time-series analysis with temporal patterns

