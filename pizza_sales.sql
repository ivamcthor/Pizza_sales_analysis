--1. Total Revenue:
select sum(total_price) from pizza_sales;
--2. Average Order Value
select round((sum(total_price)/count(distinct(order_id))),2)as avg_order_value from pizza_sales;
--3. Total Pizzas Sold
select sum(ps.quantity)as pizzas_sold from pizza_sales ps;
--4. Total Orders
select count(distinct(order_id))as total_orders  from pizza_sales ps;
--5. Average Pizzas Per Order
select round(sum(ps.quantity)/count(distinct(order_id)),2) as avg_pizza_per_order from pizza_sales ps;
--B. Hourly Trend for Total Pizzas Sold
SELECT TO_CHAR(TO_DATE(order_time, 'HH24:MI:SS'), 'HH24') AS ORDER_IN_HOURS,
SUM(quantity) as total_pizzas_sold
FROM pizza_sales
GROUP BY TO_CHAR(TO_DATE(order_time, 'HH24:MI:SS'), 'HH24')
ORDER BY TO_CHAR(TO_DATE(order_time, 'HH24:MI:SS'), 'HH24');

-- Weekly Trend for Orders
SELECT 
    TO_CHAR(order_date, 'IW') AS WeekNumber, -- ISO week number
    TO_CHAR(order_date, 'YYYY') AS Year,    -- Year
    COUNT(DISTINCT order_id) AS Total_orders
FROM 
    pizza_sales
GROUP BY 
    TO_CHAR(order_date, 'IW'),             -- Group by ISO week number
    TO_CHAR(order_date, 'YYYY')            -- Group by year
ORDER BY 
    TO_CHAR(order_date, 'YYYY');  
    -- Order by year
    
--% of Sales by Pizza Category
SELECT pizza_category, ROUND(SUM(total_price),2) as total_revenue,
ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales),2) AS Per_cent
FROM pizza_sales
GROUP BY pizza_category;

-- % of Sales by Pizza Size
select pizza_size,sum(total_price)as total_sales,
round(sum(total_price)*100/(select sum(total_price)from pizza_sales),2)as per_cent_of_sales from pizza_sales
group by pizza_size
ORDER BY pizza_size;

--Total Pizzas Sold by Pizza Category
select pizza_category,sum(quantity)as total_pizzas_sold from pizza_sales
group by pizza_category
order by total_pizzas_sold desc;

--Top 5 Pizzas by Revenue
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
FETCH first 5 rows only;

--Bottom 5 Pizzas by Revenue
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
FETCH first 5 rows only;

--Top 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
FETCH first 5 rows only;

 
--Bottom 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
FETCH first 5 rows only;

--Top 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
FETCH first 5 rows only;

--Bottom 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders
FETCH first 5 rows only; 
































