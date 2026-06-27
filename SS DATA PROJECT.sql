SELECT * FROM suneja_sons;

Select count(*) from suneja_sons;

SELECT PLANT, SUM(QTY_MT) FROM suneja_sons group by PLANT ORDER BY SUM(QTY_MT) DESC;


ALTER TABLE suneja_sons 
CHANGE COLUMN `QTY-MT` QTY_MT DECIMAL(10,2);

select SO_No,
row_number() OVER(ORDER BY SO_No) AS "ROW_NO",
RANK() OVER(ORDER BY SO_No) AS "RANK",
dense_rank() OVER(ORDER BY SO_No) AS "dense_rank"
FROM suneja_sons;

# ✅ Question 1: Customer Loyalty Analysis (ROW_NUMBER, CTE, HAVING)

WITH customer_analysis AS (
  SELECT 
    Customer, 
    QTY_MT,
    SUM(QTY_MT) OVER (PARTITION BY Customer ORDER BY QTY_MT) AS "TOTAL",
    AVG(QTY_MT) OVER (PARTITION BY Customer ORDER BY QTY_MT) AS "AVG",
    COUNT(QTY_MT) OVER (PARTITION BY Customer ORDER BY QTY_MT) AS "COUNT"
  FROM suneja_sons
)
SELECT * FROM customer_analysis;

select Customer, SUM('QTY_MT') from suneja_sons where STATUS = "Pending" GROUP BY CUSTOMER ORDER BY CUSTOMER;

SELECT 
  Customer,
  SUM(QTY_MT) AS Total_Quantity,
  dense_rank() OVER (PARTITION BY Customer ORDER BY SUM(QTY_MT)) AS ROW_NUM
FROM suneja_sons 
WHERE STATUS = "Pending" 
GROUP BY Customer 
ORDER BY Customer;

SELECT 
ROW_NUMBER() OVER (ORDER BY SUM(QTY_MT) DESC) AS ROW_NUM,
Customer,
SUM(QTY_MT) AS Total_Quantity
FROM suneja_sons 
WHERE STATUS = "Pending" 
GROUP BY Customer 
ORDER BY ROW_NUM;

SELECT * FROM suneja_sons where Customer = "suneja sons";

SELECT 
    Customer, 
    ROUND(SUM(`QTY-MT`)) as Total_Quantity
FROM suneja_sons 
GROUP BY Customer ORDER BY ROUND(SUM(`QTY-MT`)) desc limit 5;

SELECT 
    PLANT,
    COUNT(*) as Total_Orders,
    Round(SUM(`QTY-MT`)) as Total_Quantity,
    SUM(PO_No) as Total_PO_Amount
FROM suneja_sons
GROUP BY PLANT
ORDER BY Total_Orders DESC;



SELECT 
    DATE_FORMAT(`Po_Placing_Date`, '%Y-%m') as Month,
    COUNT(*) as Orders_Count,
    Round(SUM(`QTY_MT`)) as Total_Quantity,
    Round(AVG(`QTY_MT`))as Avg_Quantity
FROM suneja_sons
GROUP BY DATE_FORMAT(`Po_Placing_Date`, '%Y-%m')
ORDER BY Total_Quantity DESC;

SELECT 
    PLANT,
    COUNT(*) as Total_Orders,
    SUM(`QTY-MT`) as Total_Quantity,
    RANK() OVER (ORDER BY SUM(`QTY-MT`) DESC) as Rank_by_Quantity,
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) as Rank_by_Orders
FROM suneja_sons
GROUP BY PLANT
ORDER BY Total_Quantity DESC;

SET SQL_SAFE_UPDATES = 0;


UPDATE suneja_sons
SET PLANT = 'M'
WHERE PLANT = 'BCM';

UPDATE suneja_sons
SET PLANT = 'BCM'
WHERE PLANT = 'M';

UPDATE suneja_sons
SET PLANT = 'QSC'
WHERE PLANT = 'Q';

# Customer Loyalty Analysis
WITH customer_analyze AS (
  SELECT 
    Customer,
    COUNT(*) AS Total_Orders,
    SUM(QTY_MT) AS Total_Quantity,
    AVG(QTY_MT) AS Avg_Quantity_Per_Order,
    ROW_NUMBER() OVER (ORDER BY SUM(QTY_MT) DESC) AS ROW_NO
  FROM suneja_sons
  GROUP BY Customer
  HAVING COUNT(*) > 5
  ORDER BY Total_Quantity DESC
)
SELECT * FROM customer_analyze;

#Status Trend per Product
SELECT
  QUALITY,
  STATUS,
  COUNT(*) AS Order_Count,
  SUM(COUNT(*)) OVER (PARTITION BY QUALITY) AS Total_Per_Quality,
  ROUND((COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY QUALITY)) * 100, 2) AS Percentage
FROM suneja_sons
GROUP BY QUALITY, STATUS
ORDER BY Total_Per_Quality DESC, STATUS;

#Top Customers Quarter-over-Quarter (Bonus - Optional)

select
customer,
DATE_FORMAT(`Po_Placing_Date`, '%Y-%m') as month,
sum(qty_mt) as total_qty,
LAG(SUM(qty_mt)) OVER (PARTITION BY customer ORDER BY DATE_FORMAT(`Po_Placing_Date`, '%Y-%m'))
from suneja_sons
group by customer, DATE_FORMAT(`Po_Placing_Date`, '%Y-%m')
order by customer, month;

SELECT
  customer,
  DATE_FORMAT(`Po_Placing_Date`, '%Y-%m') as month,
  SUM(qty_mt) as total_qty,
  LAG(SUM(qty_mt)) OVER (PARTITION BY customer ORDER BY DATE_FORMAT(`Po_Placing_Date`, '%Y-%m')) AS previous_month_qty,
  SUM(qty_mt) - LAG(SUM(qty_mt)) OVER (PARTITION BY customer ORDER BY DATE_FORMAT(`Po_Placing_Date`, '%Y-%m')) AS Growth_Decline
FROM suneja_sons
GROUP BY customer, DATE_FORMAT(`Po_Placing_Date`, '%Y-%m')
ORDER BY customer, month;

#✅ Question 3: Quarter-over-Quarter Analysis (LAG, date functions)

WITH monthly_analysis AS (
  SELECT
    customer,
    DATE_FORMAT(`Po_Placing_Date`, '%Y-%m') as month,
    SUM(qty_mt) as total_qty,
    LAG(SUM(qty_mt)) OVER (PARTITION BY customer ORDER BY DATE_FORMAT(`Po_Placing_Date`, '%Y-%m')) AS previous_month_qty,
    SUM(qty_mt) - LAG(SUM(qty_mt)) OVER (PARTITION BY customer ORDER BY DATE_FORMAT(`Po_Placing_Date`, '%Y-%m')) AS Growth_Decline
  FROM suneja_sons
  GROUP BY customer, DATE_FORMAT(`Po_Placing_Date`, '%Y-%m')
)
SELECT * FROM monthly_analysis
WHERE customer IN (
  SELECT customer 
  FROM monthly_analysis 
  GROUP BY customer 
  HAVING COUNT(DISTINCT month) >= 2
)
ORDER BY customer, month;

#Product Quality Analysis

SELECT
  QUALITY,
  COUNT(*) AS Total_Orders,
  SUM(qty_mt) AS Total_Quantity,
  ROUND(SUM(qty_mt) / COUNT(*), 2) AS Avg_Qty_Per_Order,
  ROUND((SUM(qty_mt) / SUM(SUM(qty_mt)) OVER ()) * 100, 2) AS Percentage_Of_Business,
  ROW_NUMBER() OVER (ORDER BY SUM(qty_mt) DESC) AS Quality_Rank
FROM suneja_sons
GROUP BY QUALITY
HAVING COUNT(*) > 5;

#Ranking and Comparison

SELECT
  Customer,
  COUNT(*) AS Total_Orders,
  SUM(qty_mt) AS Total_Quantity,
  ROUND(SUM(qty_mt) / COUNT(*), 2) AS Avg_Qty_Per_Order,
  ROW_NUMBER() OVER (ORDER BY SUM(qty_mt) DESC) AS Customer_Rank,
  ROUND(AVG(SUM(qty_mt)) OVER (), 2) AS Avg_Customer_Total,
  ROUND(SUM(qty_mt) - AVG(SUM(qty_mt)) OVER (), 2) AS Difference_From_Avg
FROM suneja_sons
GROUP BY Customer
HAVING SUM(qty_mt) <= 10;

#WITH CTE 

WITH customer_ranking AS (
  SELECT
    Customer,
    COUNT(*) AS Total_Orders,
    SUM(qty_mt) AS Total_Quantity,
    ROUND(SUM(qty_mt) / COUNT(*), 2) AS Avg_Qty_Per_Order,
    ROW_NUMBER() OVER (ORDER BY SUM(qty_mt) DESC) AS Customer_Rank,
    ROUND(AVG(SUM(qty_mt)) OVER (), 2) AS Avg_Customer_Total,
    ROUND(SUM(qty_mt) - AVG(SUM(qty_mt)) OVER (), 2) AS Difference_From_Avg
  FROM suneja_sons
  GROUP BY Customer
)
SELECT * FROM customer_ranking
WHERE Customer_Rank <= 10
ORDER BY Customer_Rank;

#STATUS TRACKING

with STATUS_TRACKING AS
(
SELECT
  STATUS,
  COUNT(*) AS Order_Count,
  SUM(qty_mt) AS Total_Quantity,
  ROUND((COUNT(*) / SUM(COUNT(*)) OVER ()) * 100, 2) AS Percentage_Of_Orders,
  ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS Status_Rank,
  ROUND(AVG(DATEDIFF(CURDATE(), `Po_Placing_Date`)), 2) AS Avg_Days_In_Status,
  ROUND(COUNT(*) - AVG(COUNT(*)) OVER (), 2) AS Difference_From_Avg_Status,
  CASE
    WHEN STATUS = 'Pending' THEN 'Need_to_Progress'
    WHEN STATUS = 'complete' THEN 'Completed Phase'
    ELSE 'Other'
  END AS Status_Category
FROM suneja_sons
GROUP BY STATUS
)
SELECT * FROM STATUS_TRACKING;
