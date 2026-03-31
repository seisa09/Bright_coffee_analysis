# Bright_coffee_analysis
Coffee shop analysis for the CEO
select * from `workspace`.`default`.`bright_coffee_case_study`;

-----------------------------------------------------
--Counting number of stores
SELECT DISTINCT store_location 
FROM `workspace`.`default`.`bright_coffee_case_study`;

-----------------------------------------------------
--Counting number of products and their category
SELECT DISTINCT product_id, product_category
FROM `workspace`.`default`.`bright_coffee_case_study`;

-----------------------------------------------------
--Total revenue for each store
SELECT store_location, SUM(unit_price * transaction_qty) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_case_study`
GROUP BY store_location;

-----------------------------------------------------
--Counting number of transactions for each store
SELECT store_location, COUNT(transaction_id) AS total_transactions
FROM `workspace`.`default`.`bright_coffee_case_study`
GROUP BY store_location;

-----------------------------------------------------
--Counting number of customers
SELECT DISTINCT count (transaction_id) AS number_of_rows
FROM `workspace`.`default`.`bright_coffee_case_study`;

-----------------------------------------------------
--Checking timeline of data
SELECT MIN (transaction_date) AS start_date, MAX (transaction_date) AS end_date
FROM `workspace`.`default`.`bright_coffee_case_study`;

--Data is for period of six months
-----------------------------------------------------
--Tme of day
SELECT MIN (transaction_time) AS stat_of_day, MAX (transaction_time) AS end_of_day
FROM `workspace`.`default`.`bright_coffee_case_study`;

-----------------------------------------------------
--Budget-friendly products
SELECT product_category, product_detail, product_type, min (unit_price) AS affordable_product
FROM `workspace`.`default`.`bright_coffee_case_study`
GROUP BY ALL
ORDER BY affordable_product ASC;

-----------------------------------------------------
--High-priced products
SELECT product_category, product_detail, product_type, max (unit_price) AS expensive_product
FROM `workspace`.`default`.`bright_coffee_case_study`
GROUP BY ALL
ORDER BY expensive_product DESC;

-----------------------------------------------------
--Most popular product
SELECT product_category, product_detail, product_type, SUM (transaction_qty) AS total_sold
FROM `workspace`.`default`.`bright_coffee_case_study`
GROUP BY ALL
ORDER BY total_sold DESC
LIMIT 1;

-----------------------------------------------------
--Least popular product
SELECT product_category, product_detail, product_detail, product_type, SUM (transaction_qty) AS total_sold
FROM `workspace`.`default`.`bright_coffee_case_study`
GROUP BY ALL
ORDER BY total_sold ASC
LIMIT 1;

-----------------------------------------------------
--Tme case statement
SELECT sum (transaction_qty*unit_price),count (transaction_id),case 
when transaction_time between '06:00:00' and '11:59:59' then 'morning'
when transaction_time between '12:00:00' and '16:59:59' then 'afternoon'
when transaction_time between '17:00:00' and '19:59:59' then 'evening'
else 'night'
end as time_of_day
FROM `workspace`.`default`.`bright_coffee_case_study`
GROUP BY all;

-----------------------------------------------------
--Total revenue
SELECT store_location, sum (transaction_qty*unit_price) AS total_rev
FROM `workspace`.`default`.`bright_coffee_case_study`
GROUP BY store_location;

-----------------------------------------------------
--Final query
SELECT transaction_id, transaction_date, transaction_time, transaction_qty, store_id, store_location, product_id, unit_price, product_category, product_type,
dayname (transaction_date) as day_of_week, 
monthname (transaction_date) as month,
dayofmonth (transaction_date) as day_of_month,
case 
when dayname (transaction_date) IN ('Saturday', 'Sunday') then 'weekend'
else 'weekday'
end as weekday,
case 
when date_format(transaction_time,'hh:mm:ss') between '06:00:00' and '09:59:59' then 'early_bird'
when date_format(transaction_time,'hh:mm:ss') between '10:00:00' and '11:59:59' then 'morning'
when date_format(transaction_time,'hh:mm:ss') between '12:00:00' and '16:59:59' then 'afternoon'
when date_format(transaction_time,'hh:mm:ss') between '17:00:00' and '19:59:59' then 'evening'
else 'night'
end as time_of_day,
case 
when unit_price between 0 and 2 then 'budget'
when unit_price between 2 and 4 then 'mid-range'
when unit_price >= 4 then 'luxury'
else 'luxury-ultra'
end as price_category,
transaction_qty*unit_price as revenue
FROM `workspace`.`default`.`bright_coffee_case_study`
GROUP BY all;
