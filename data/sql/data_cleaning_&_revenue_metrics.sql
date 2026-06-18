CREATE TABLE saas_sales (
    row_id INTEGER Primary key,
    order_id VARCHAR(50),
    order_date DATE,
    date_key INTEGER,
    contact_name VARCHAR(100),
    country VARCHAR(100),
    city VARCHAR(100),
    region VARCHAR(20),
    subregion VARCHAR(20),
    customer VARCHAR(100),
    customer_id INTEGER,
    industry VARCHAR(100),
    segment VARCHAR(50),
    product VARCHAR(100),
    license VARCHAR(50),
    sales NUMERIC(10,2),
    quantity INTEGER,
    discount NUMERIC(5,2),
    profit NUMERIC(10,2)
);


/*Search columns in table*/
SELECT column_name 
FROM information_schema.columns
WHERE table_name = 'saas_sales'
ORDER BY ordinal_position;


/*Search for duplicate values*/
SELECT COUNT(*) AS duplicate_rows
FROM (
    SELECT ROW_NUMBER() OVER (
        PARTITION BY row_id, order_id, order_date, date_key, contact_name, country, city, region, subregion, customer, customer_id, industry, segment, product, license, sales, quantity, discount, profit
        ORDER BY (SELECT NULL)
    ) AS row_num
    FROM saas_sales
) AS dupes
WHERE row_num > 1;

/*Search for NULL values in table*/
SELECT
    COUNT(*) FILTER (WHERE row_id IS NULL) AS row_id_nulls,
    COUNT(*) FILTER (WHERE order_id IS NULL) AS order_id_nulls,
    COUNT(*) FILTER (WHERE order_date IS NULL) AS order_date_nulls,
    COUNT(*) FILTER (WHERE date_key IS NULL) AS date_key_nulls,
    COUNT(*) FILTER (WHERE contact_name IS NULL) AS contact_name_nulls,
    COUNT(*) FILTER (WHERE country IS NULL) AS country_nulls,
    COUNT(*) FILTER (WHERE city IS NULL) AS city_nulls,
    COUNT(*) FILTER (WHERE region IS NULL) AS region_nulls,
    COUNT(*) FILTER (WHERE subregion IS NULL) AS subregion_nulls,
    COUNT(*) FILTER (WHERE customer IS NULL) AS customer_nulls,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS customer_id_nulls,
    COUNT(*) FILTER (WHERE industry IS NULL) AS industry_nulls,
    COUNT(*) FILTER (WHERE segment IS NULL) AS segment_nulls,
    COUNT(*) FILTER (WHERE product IS NULL) AS product_nulls,
    COUNT(*) FILTER (WHERE license IS NULL) AS license_nulls,
    COUNT(*) FILTER (WHERE sales IS NULL) AS sales_nulls,
    COUNT(*) FILTER (WHERE quantity IS NULL) AS quantity_nulls,
    COUNT(*) FILTER (WHERE discount IS NULL) AS discount_nulls,
    COUNT(*) FILTER (WHERE profit IS NULL) AS profit_nulls
FROM saas_sales;


/*View FULL table*/
SELECT *
FROM saas_sales
LIMIT 100;

/*Total Revenue by customer*/
SELECT customer, SUM(sales) AS total_revenue
FROM saas_sales
GROUP BY customer
ORDER BY total_revenue DESC;

/*Total Revenue*/
SELECT SUM(sales) AS total_revenue
FROM saas_sales;



/*Total Profit & Profit Margin (profit/sales × 100)*/
SELECT customer, ROUND(profit/sales * 100, 2) AS profit_margin
FROM saas_sales
ORDER BY profit_margin DESC;


/*Revenue by Industry*/
SELECT industry, SUM(sales) AS total_revenue
FROM saas_sales
GROUP BY industry
ORDER BY total_revenue DESC;


/*Revenue by Product*/
SELECT product, SUM(sales) AS total_revenue
FROM saas_sales
GROUP BY product
ORDER BY total_revenue DESC;


/*Revenue by Segment*/
SELECT segment, SUM(sales) AS total_revenue
FROM saas_sales
GROUP BY segment
ORDER BY total_revenue DESC;


/*Monthly revenue trend ordered by month*/
SELECT 
  TO_CHAR(order_date, 'YYYY-MM') AS month,
  COUNT(order_id)                  AS total_orders,
  SUM(sales)                       AS total_revenue,
  SUM(profit)                      AS total_profit,
  ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin_pct
FROM saas_sales
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;


/*Monthly revenue trend ordered by total revenue with filter for the year*/
SELECT 
  TO_CHAR(order_date, 'YYYY-MM') AS month,
  COUNT(order_id) AS total_orders,
  SUM(sales) AS total_revenue,
  SUM(profit) AS total_profit,
  ROUND((SUM(profit) / SUM(sales) * 100)::numeric, 2) AS profit_margin_pct
FROM saas_sales
WHERE EXTRACT(YEAR FROM order_date) = 2020
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY total_orders desc;


/*Quaterly trend on amount of order and revenue*/
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(QUARTER FROM order_date) AS quarter,
    CONCAT(
        'Q',
        EXTRACT(QUARTER FROM order_date),
        ' ',
        EXTRACT(YEAR FROM order_date)
    ) AS quarter_label,
    COUNT(order_id) AS total_orders,
    SUM(sales) AS total_revenue,
    SUM(profit) AS total_profit,
    ROUND((SUM(profit) / SUM(sales) * 100)::numeric, 2) AS profit_margin_pct
FROM saas_sales
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(QUARTER FROM order_date)
ORDER BY year, quarter;



/*Average Order Value*/
SELECT
TO_CHAR(order_date, 'YYYY-MM') AS month,
ROUND(SUM(sales)/COUNT(DISTINCT order_id):: numeric, 2) AS avg_order_value,
ROUND(SUM(sales)/SUM(quantity):: numeric, 2) AS avg_revenue_per_unit,
ROUND(SUM(profit)/COUNT(DISTINCT order_id):: numeric, 2) AS avg_profit_per_order
FROM saas_sales
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;


/*Discount brackets and their effect on profit*/
SELECT
CASE
	WHEN discount = 0 THEN '0% - No Discount'
	WHEN discount <=0.10 THEN '1 - 10% Discount'
	WHEN discount <=0.20 Then '11-20% Discount'
	WHEN discount <=0.30 THEN '21-30% Discount'
	ELSE '30+ Discount'
END AS discount_bracket,
COUNT(order_id) AS total_orders,
ROUND(AVG(discount)*100 ::numeric, 2) AS avg_discount_percentage,
ROUND(SUM(sales)::numeric, 2) AS total_revenue,
ROUND(SUM(profit)::numeric, 2) AS total_profit,
ROUND(SUM(profit)/SUM(sales) * 100 ::numeric, 2) AS profit_margin_percentage, 
ROUND(AVG(profit)::numeric, 2) AS avg_profit_per_order
FROM saas_sales
GROUP BY discount_bracket
ORDER BY avg_discount_percentage;


/*Discount impact on product*/
SELECT product,
ROUND(AVG(discount)*100 :: numeric, 2) AS avg_discount_percentage,
ROUND(SUM(profit):: numeric, 2) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100 ::numeric, 2) AS profit_margin_percentage
FROM saas_sales
GROUP BY product
ORDER BY avg_discount_percentage DESC;


SELECT
TO_CHAR(order_date, 'YYYY-MM') AS month,
SUM(sales) AS total_sales
FROM saas_sales
WHERE EXTRACT(YEAR FROM order_date) = 2022
GROUP BY TO_CHAR(order_date, 'YYYY-MM');

SELECT
TO_CHAR(order_date, 'YYYY') AS month,
SUM(sales) AS total_sales
FROM saas_sales
WHERE EXTRACT(YEAR FROM order_date) = 2022
GROUP BY TO_CHAR(order_date, 'YYYY');
