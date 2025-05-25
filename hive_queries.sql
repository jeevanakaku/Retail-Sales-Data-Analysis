-- Create the external Hive table
CREATE EXTERNAL TABLE IF NOT EXISTS retail_sales (
    Transaction_ID INT,
    Date STRING,
    Customer_ID STRING,
    Gender STRING,
    Age INT,
    Product_Category STRING,
    Quantity INT,
    Price_per_Unit FLOAT,
    Total_Amount FLOAT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/retail/retail_sales_dataset.csv';

-- Query 1: Total sales per product category
SELECT Product_Category, SUM(Total_Amount) AS Total_Sales
FROM retail_sales
GROUP BY Product_Category;

-- Query 2: Average spending by age group
SELECT Age, AVG(Total_Amount) AS Average_Spending
FROM retail_sales
GROUP BY Age;

-- Query 3: Gender-based purchasing patterns
SELECT Gender, SUM(Total_Amount) AS Total_Sales
FROM retail_sales
GROUP BY Gender;
