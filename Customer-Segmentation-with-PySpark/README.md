
# Customer Segmentation with PySpark
This project addresses a key challenge for e-commerce companies: uncertainty in supply chain planning. By analyzing customer purchasing behavior, this project helps the `Sales & Operations Planning (S&OP)` team at a multinational e-commerce company prepare for end-of-year sales. The insights gained from customer segmentation can be used to plan promotional opportunities, manage inventory, and ensure customer satisfaction.

# Methodology
This solution uses `RFM (Recency, Frequency, Monetary)` analysis to transform raw transactional data into meaningful features. These features are then used to segment customers into distinct groups using the `K-Means clustering` algorithm. The entire process is built using `PySpark`, which is optimized for large-scale data processing.

The steps are as follows:

- `Data Preparation:` Clean and preprocess the transactional data.

- `RFM Feature Engineering:` Calculate Recency, Frequency, and Monetary values for each customer.

- `Data Standardization:` Use VectorAssembler and StandardScaler to prepare the RFM features for the clustering model.

- `K-Means Clustering:` Apply the K-Means algorithm to group customers based on their RFM scores.

- `Segment Interpretation:` Analyze the characteristics of each cluster to understand the customer segments.

# Data
The analysis is based on the `Online Retail.csv` dataset. The key columns used for the analysis are summarized below:

![Features](https://github.com/alisaghilutfi/Big-Data-Analytics-Projects/blob/master/Customer-Segmentation-with-PySpark/Features.PNG)

# Key Findings: Customer Segments
The analysis identified `five distinct customer segments` with the following characteristics and business implications:

- `Cluster 0 (At-Risk):` Customers with high recency, but low frequency and low monetary value. These customers may be new but haven't engaged much, or they are at risk of churning.

- `Cluster 1 (Potential Loyalists):` Customers with high recency, medium frequency, and medium monetary value. These customers have the potential to become loyal and valuable with the right engagement strategy.

- `Cluster 2 (Churned):` Customers with low recency, low frequency, and low monetary value. This group may have stopped purchasing and could be considered `lost`.

- `Cluster 3 (New Customers):` Customers with medium recency, but low frequency and low monetary value. This is a segment of new users who have made a purchase but have not yet returned.

- `Cluster 4 (Champions):` Customers with high recency, high frequency, and high monetary value. These are your most valuable customers, and should be the focus of loyalty programs and special offers.

