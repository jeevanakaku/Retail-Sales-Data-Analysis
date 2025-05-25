-- Load the retail sales data
sales_data = LOAD '/retail/retail_sales_dataset.csv' USING PigStorage(',') 
             AS (Transaction_ID:int, Date:chararray, Customer_ID:chararray, 
                 Gender:chararray, Age:int, Product_Category:chararray, 
                 Quantity:int, Price_per_Unit:float, Total_Amount:float);

-- Remove records with null values
clean_data = FILTER sales_data BY Transaction_ID IS NOT NULL AND 
                                     Date IS NOT NULL AND 
                                     Customer_ID IS NOT NULL AND 
                                     Gender IS NOT NULL AND 
                                     Age IS NOT NULL AND 
                                     Product_Category IS NOT NULL AND 
                                     Quantity IS NOT NULL AND 
                                     Price_per_Unit IS NOT NULL AND 
                                     Total_Amount IS NOT NULL;

-- Calculate total sales per product category
grouped_data = GROUP clean_data BY Product_Category;
category_sales = FOREACH grouped_data GENERATE group AS Product_Category, 
                 SUM(clean_data.Total_Amount) AS Total_Sales;

-- Store the result in HDFS
STORE category_sales INTO '/retail/output/category_sales' USING PigStorage(',');
