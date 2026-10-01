-- 1. Total Sales and Orders by Employee?
SELECT 
    Employee_ID,
    Employee_Name,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Sales_Amount) AS Total_Sales
FROM Employee_Sales
GROUP BY Employee_ID, Employee_Name
ORDER BY Total_Sales DESC;

-- 2. Target vs Actual Sales Achievement (%) ?
SELECT 
    Employee_ID,
    Employee_Name,
    Target_Amount,
    SUM(Sales_Amount) AS Actual_Sales,
    ROUND((SUM(Sales_Amount) / Target_Amount) * 100, 2) AS Achievement_Percentage
FROM Employee_Sales
GROUP BY Employee_ID, Employee_Name, Target_Amount;

-- 3. Top 5 Performing Employees?
SELECT TOP 5
    Employee_Name,
    Region,
    SUM(Sales_Amount) AS Total_Sales
FROM Employee_Sales
GROUP BY Employee_Name, Region
ORDER BY Total_Sales DESC;

-- 4. Region-wise Sales Distribution?
SELECT 
    Region,
    COUNT(DISTINCT Employee_ID) AS Total_Employees,
    SUM(Sales_Amount) AS Regional_Sales
FROM Employee_Sales
GROUP BY Region
ORDER BY Regional_Sales DESC;

-- 5. Monthly Sales Trend Analysis?
SELECT 
    YEAR(Order_Date) AS Sales_Year,
    MONTH(Order_Date) AS Sales_Month,
    SUM(Sales_Amount) AS Monthly_Sales
FROM Employee_Sales
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Sales_Year, Sales_Month;

-- 6. Category-wise Performance per Employee?
SELECT 
    Employee_Name,
    Product_Category,
    SUM(Sales_Amount) AS Category_Sales
FROM Employee_Sales
GROUP BY Employee_Name, Product_Category
ORDER BY Employee_Name, Category_Sales DESC;

-- 7. Identify Underperforming Employees (Less than 80% Target)?
SELECT 
    Employee_Name,
    Target_Amount,
    SUM(Sales_Amount) AS Actual_Sales,
    ROUND((SUM(Sales_Amount) / Target_Amount) * 100, 2) AS Achievement_Percentage
FROM Employee_Sales
GROUP BY Employee_Name, Target_Amount
HAVING (SUM(Sales_Amount) / Target_Amount) * 100 < 80;

-- 8. Average Order Value (AOV) per Employee?
SELECT 
    Employee_Name,
    AVG(Sales_Amount) AS Avg_Order_Value
FROM Employee_Sales
GROUP BY Employee_Name
ORDER BY Avg_Order_Value DESC;

-- 9. Contribution % of Each Employee to Total Sales?
SELECT 
    Employee_Name,
    SUM(Sales_Amount) AS Individual_Sales,
    ROUND((SUM(Sales_Amount) / (SELECT SUM(Sales_Amount) FROM Employee_Sales)) * 100, 2) AS Contribution_Percentage
FROM Employee_Sales
GROUP BY Employee_Name
ORDER BY Contribution_Percentage DESC;

-- 10. Year-over-Year (YoY) Employee Performance Comparison?
SELECT 
    Employee_Name,
    SUM(CASE WHEN YEAR(Order_Date) = 2025 THEN Sales_Amount ELSE 0 END) AS Sales_2025,
    SUM(CASE WHEN YEAR(Order_Date) = 2026 THEN Sales_Amount ELSE 0 END) AS Sales_2026
FROM Employee_Sales
GROUP BY Employee_Name;
