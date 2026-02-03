-- Create a Gold Schema in the Warehouse
CREATE SCHEMA Gold;
GO


-- Create the Fact_Sales table
DROP TABLE IF EXISTS Gold.Fact_Sales;

CREATE TABLE Gold.Fact_Sales AS
SELECT
    oi.order_id,
    oi.product_id,
    p.product_category_name,
    o.customer_id,
    oi.seller_id,
    o.order_purchase_timestamp,
    CAST(o.order_purchase_timestamp AS DATE) AS order_date,
    oi.price,
    oi.freight_value,
    (oi.price + oi.freight_value) AS total_order_value
FROM [lh_Ecommerce_Olist].[Silver].[silver_olist_order_items_dataset] oi
JOIN [lh_Ecommerce_Olist].[Silver].[silver_olist_orders_dataset] o 
    ON oi.order_id = o.order_id
JOIN [lh_Ecommerce_Olist].[Silver].[silver_olist_products_dataset] p 
    ON oi.product_id = p.product_id
WHERE o.order_status = 'delivered';


-- Create the Dim_Customers table
CREATE TABLE Gold.Dim_Customers AS 
SELECT 
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM [lh_Ecommerce_Olist].[Silver].[silver_olist_customers_dataset];


-- Create the Dim_Products table
CREATE TABLE Gold.Dim_Products AS
SELECT 
    p.product_id,
    COALESCE(t.product_category_name_english, p.product_category_name) AS product_category,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM [lh_Ecommerce_Olist].[Silver].[silver_olist_products_dataset] p
LEFT JOIN [lh_Ecommerce_Olist].[Silver].[silver_product_category_name_translation] t 
    ON p.product_category_name = t.product_category_name;


-- Create the Dim_Sellers table
CREATE TABLE Gold.Dim_Sellers AS
SELECT 
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM [lh_Ecommerce_Olist].[Silver].[silver_olist_sellers_dataset];


-- Create the Dim_Date table i
DROP TABLE IF EXISTS Gold.Dim_Date;

CREATE TABLE Gold.Dim_Date (
    date_key INT NOT NULL,
    full_date DATE NOT NULL,
    year INT,
    quarter INT,
    month INT,
    month_name VARCHAR(15),
    day INT,
    day_of_week INT,
    day_name VARCHAR(15),
    is_weekend BIT
);

DECLARE @StartDate DATE = '2016-01-01';
DECLARE @EndDate DATE = '2019-12-31';

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO Gold.Dim_Date (
        date_key, full_date, year, quarter, month, month_name, day, day_of_week, day_name, is_weekend
    )
    SELECT 
        CAST(FORMAT(@StartDate, 'yyyyMMdd') AS INT),
        @StartDate,
        YEAR(@StartDate),
        DATEPART(QUARTER, @StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DAY(@StartDate),
        DATEPART(WEEKDAY, @StartDate),
        DATENAME(WEEKDAY, @StartDate),
        CASE WHEN DATEPART(WEEKDAY, @StartDate) IN (1, 7) THEN 1 ELSE 0 END;

    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END;

-- Create Customer Lifetime Value (CLV)
DROP TABLE IF EXISTS Gold.Agg_Customer_Intelligence;

CREATE TABLE Gold.Agg_Customer_Intelligence AS
WITH CTE_CustomerOrders AS (
    SELECT 
        c.customer_unique_id,
        o.order_id,
        o.order_purchase_timestamp,
        p.payment_value
    FROM [lh_Ecommerce_Olist].[Silver].[silver_olist_customers_dataset] c
    JOIN [lh_Ecommerce_Olist].[Silver].[silver_olist_orders_dataset] o 
        ON c.customer_id = o.customer_id
    JOIN [lh_Ecommerce_Olist].[Silver].[silver_olist_order_payments_dataset] p 
        ON o.order_id = p.order_id
    WHERE o.order_status = 'delivered'
)
SELECT 
    customer_unique_id,
    -- Monetary: Total Spend
    SUM(payment_value) AS lifetime_value,
    -- Frequency: Total Orders
    COUNT(DISTINCT order_id) AS total_orders,
    -- Average Order Value
    SUM(payment_value) / COUNT(DISTINCT order_id) AS avg_order_value,
    -- Recency: Last Purchase Date
    MAX(order_purchase_timestamp) AS last_purchase_date,
    -- Customer Tenure: First Purchase Date
    MIN(order_purchase_timestamp) AS first_purchase_date,
    DATEDIFF(DAY, MIN(order_purchase_timestamp), MAX(order_purchase_timestamp)) AS customer_tenure_days
FROM CTE_CustomerOrders
GROUP BY customer_unique_id;










































