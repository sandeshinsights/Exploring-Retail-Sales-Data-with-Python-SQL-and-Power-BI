-- 1. Which payment method is used the most?
SELECT payment_method, COUNT(*) AS total_transactions
FROM sales_data
GROUP BY payment_method
ORDER BY total_transactions DESC
LIMIT 1;

-- 2. How many transactions are done using each payment method?
SELECT payment_method, COUNT(*) AS total_transactions
FROM sales_data
GROUP BY payment_method
ORDER BY total_transactions DESC;

-- 3. Which branch and city have the highest total sales?
SELECT Branch, City, SUM(total) AS total_sales
FROM sales_data
GROUP BY Branch, City
ORDER BY total_sales DESC
LIMIT 1;


-- 4. Which branch has the highest average customer rating?
SELECT Branch, AVG(rating) AS avg_rating
FROM sales_data
GROUP BY Branch
ORDER BY avg_rating DESC
LIMIT 1;

-- 5. Which product category has the highest total revenue?
SELECT category, SUM(total) AS total_revenue
FROM sales_data
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 1;

-- 6. Which category has the highest average profit margin?
SELECT category, AVG(profit_margin) AS avg_profit_margin
FROM sales_data
GROUP BY category
ORDER BY avg_profit_margin DESC
LIMIT 1;

-- 7. At what time of day are most sales made?
SELECT 
  CASE 
    WHEN EXTRACT(HOUR FROM time::time) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM time::time) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN EXTRACT(HOUR FROM time::time) BETWEEN 18 AND 23 THEN 'Evening'
    ELSE 'Night'
  END AS time_of_day,
  COUNT(*) AS total_sales
FROM sales_data
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- 8. Which day of the week has the highest sales?
SELECT 
  TO_CHAR(date, 'Day') AS day_of_week,
  SUM(total) AS total_sales
FROM sales_data
GROUP BY day_of_week
ORDER BY total_sales DESC
LIMIT 1;

-- 9. What is the average rating for each product category?
SELECT category, AVG(rating) AS avg_rating
FROM sales_data
GROUP BY category
ORDER BY avg_rating DESC;

-- 10. Does buying a higher quantity affect customer ratings?
SELECT 
  CASE 
    WHEN quantity <= 5 THEN 'Low Quantity'
    ELSE 'High Quantity'
  END AS purchase_type,
  AVG(rating) AS avg_rating
FROM sales_data
GROUP BY purchase_type;

-- 11. Which branches have total sales greater than the average sales of all branches?
SELECT Branch, SUM(total) AS branch_sales
FROM sales_data
GROUP BY Branch
HAVING SUM(total) > (
  SELECT AVG(branch_total)
  FROM (
    SELECT SUM(total) AS branch_total
    FROM sales_data
    GROUP BY Branch
  )
);

-- 12. Which categories have an average unit price higher than the overall average unit price?
SELECT category, AVG(unit_price) AS avg_unit_price
FROM sales_data
GROUP BY category
HAVING AVG(unit_price) > (
  SELECT AVG(unit_price) FROM sales_data
);
-- 13. Which branches (with city) have an average customer rating higher than the overall average rating?
SELECT Branch, City, AVG(rating) AS avg_rating
FROM sales_data
GROUP BY Branch, City
HAVING AVG(rating) > (
    SELECT AVG(rating) FROM sales_data
);



-- 14. Which branch has the highest revenue? (Subquery version)
SELECT Branch, total_sales
FROM (
  SELECT Branch, SUM(total) AS total_sales
  FROM sales_data
  GROUP BY Branch
) 
ORDER BY total_sales DESC
LIMIT 1;

-- 15. Which product categories have a profit margin higher than the average profit margin across all products?
SELECT category, AVG(profit_margin) AS avg_profit_margin
FROM sales_data
GROUP BY category
HAVING AVG(profit_margin) > (
  SELECT AVG(profit_margin) FROM sales_data
);
