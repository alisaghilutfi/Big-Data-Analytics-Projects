# Airbnb Data Analysis in Databricks
A comprehensive data analysis project using SQL in Databricks to analyze Airbnb listings data, providing actionable insights for hosts and business stakeholders through advanced analytics, feature engineering, and interactive dashboards.


## 🎯 Project Overview
This project demonstrates end-to-end data analysis capabilities using Databricks SQL to:
- Analyze Airbnb listing performance across New York City neighborhoods
- Identify top-performing areas and room types
- Create data-driven recommendations for hosts
- Build interactive dashboards for business insights


## 📊 Dataset
The project uses the Airbnb Open Dataset containing:
- `48,000+` listings across NYC boroughs
- `Property details:` Location, room type, pricing, host information
- `Performance metrics:` Reviews, availability, booking patterns
- `Temporal data:` Construction year, review dates, availability calendar

## Key Data Fields
- `Listing Information:` listing_id, list_name, room_type, construction_year
- `Location Data:` neighborhood_group, neighborhood, lat, long, country
- `Host Details:` host_id, host_name, host_identity_verified, calculated_host_listings_count
- `Pricing:` price, service_fee, minimum_nights
- `Performance:` number_of_reviews, review_rate_number, reviews_per_month, availability_365


## 🛠️ Technical Stack
- `Platform:` Databricks Lakehouse
- `Language:` SQL
- `Visualization:` Databricks native visualization tools
- `Data Processing:` Advanced SQL with window functions, CTEs, and aggregations


## 🔍 Analysis Phases
**Phase 1: Data Exploration & Cleaning**
- `Schema Analysis:` Explored data structure and quality
- `Data Standardization:` Normalized neighborhood names and data types
- `Quality Control:` Removed duplicates and null values
- `Data Validation:` Ensured data integrity across joined tables

**Phase 2: Advanced Analytics**
- `Descriptive Statistics:` Min, max, average, median calculations
- `Window Functions:` Ranking and comparative analysis
- `Aggregation Patterns:` Group-by operations for neighborhood and room type insights

**Phase 3: Feature Engineering**
- `Price-to-Review Ratio:` Value assessment metric
- `Host Density:` Listings per host analysis
- `Availability Score:` Proportion-based availability metric
- `Revenue Calculations:` Earnings potential modeling

**Phase 4: Business Intelligence**
- `Revenue Analysis:` Total earnings by neighborhood
- `Market Segmentation:` Room type popularity analysis
- `Host Performance:` Multi-listing host analysis
- `Trend Identification:` Seasonal and geographical patterns


## 🎨 Dashboard Components
**Executive Summary**
- Total listings, average price, Total earnings
- Revenue distribution across boroughs(neighborhoods)
- Host performance metrics

**Trend Analysis**
- Average price trends by neighborhood and room type
- Service fee trends by neighborhood
- Listing counts by neighborhood and room type
- Average review rate by neighborhood

![Dashboard Visualization](https://github.com/alisaghilutfi/Big-Data-Analytics-Projects/blob/master/Airbnb-data-analytics-in-Databricks/images/05_dashboard.PNG)

## 🤝 Contributing
Contributions are welcome! Please feel free to submit issues, fork the repository, and create pull requests for improvements in the following areas: 
- Additional visualization types (maps, time series)
- Machine learning integration for price prediction
- Real-time data streaming capabilities
- Extended geographical analysis


## 🔗 Connect
- LinkedIn: https://www.linkedin.com/in/ali-saghi-588427117/
- Email: ali.saghi.2015@gmail.com
