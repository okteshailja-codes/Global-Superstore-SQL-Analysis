-- ======================================
-- GLOBAL SUPERSTORE SQL ANALYSIS
-- ======================================
-- Project : Sales & Business Analysis
-- Tool : MySQL
-- Dataset : Global Superstore
-- Records : 48,361
-- ======================================
-- DATABASE SETUP
-- ======================================
create database superstore_db;
use superstore_db;
select * from superstoreorders;
-- =======================================
-- 1.DATA OVERVIEW
-- =======================================
-- Task 1.1 check the total no of record in the datasets;
select count(*) as total_records
 from superstoreorders;

-- Task 1.2 View a sample of the dataset to understand the data
select * from superstoreorders
limit 10;

-- Task 1.3 find the data range of orders in the dataset
select min(order_date) as first_date,
max(order_date) as last_date from superstoreorders;

-- Task 1.4 calculate total sales and total profit
select sum(sales) as total_sales,
sum(profit) as total_profit from superstoreorders;

-- Task 1.5 count unique customers and unique products
select count(distinct customer_name) as Unique_customer,
count(distinct product_id) as unique_produucts
 from superstoreorders;
-- ================================================
-- 2.DATA QUALITY CHECK
-- ================================================
-- Task 2.1 check for aa null values in important columns
select count(*) as total_records,
sum(order_id is null) as null_order_id,
sum(order_date is null) as null_order_date,
sum(customer_name is null) as null_customer_name,
sum(sales is null) as null_sales,
sum(profit is null) as null_profit
 from superstoreorders;
 
 -- Task 2.2 duplicate orders check 
 select order_id,count(*) from superstoreorders
 group by order_id
 having count(*) > 1;
 
 -- Task 2.3 check for complete duplicates records
 select order_id ,product_id,
 count(*) as duplicate_count
 from superstoreorders
 group by order_id,product_id
 having count(*) > 1;
 
 -- Task 2.4 inspect repeated order id and product id combinations
 -- repeated combinations were identified for further review.
 -- no records are deleted without vallidation.
 
 -- Task 2.5 check for negative sales values
 select count(*) as 
 negative_sales_records 
 from superstoreorders
 where sales < 0;
 
 -- Task 2.6 check negative profit
 select count(*) as negative_profit_records
 from superstoreorders
 where profit < 0;
 
 -- Task 2.7 check the different discount values in the dataset
 select distinct discount from superstoreorders
 order by discount ;
 
 -- Task 2.8 analyze records with high discount
 select discount,
 count(*) as total_records,
 sum(sales) as total_sales,
 sum(profit) as total_profit
 from superstoreorders where discount >= 0.75
 group by discount order by discount desc;
 
 -- Task 2.9 inspect records with very high discounts
 select * from superstoreorders 
 where discount >= 0.85;
 
 -- Task 2.10  check for invalid quantity values
select  count(*) as invalid_quantity_records
from superstoreorders
where quantity <= 0;
-- =========================================
-- 3.SALES & PRODUCT ANALYSIS
-- =========================================
-- Task 3.1  Identify the product categories
select distinct category from superstoreorders;

-- Task 3.2  list of all product categories
select distinct category
from superstoreorders
order by category;

-- Task 3.3 calculate total sales for each product category
select category, sum(sales) as toatal_sales
from superstoreorders 
group by category 
order by sum(sales) desc;

-- Task 3.4 calculate total profit for each product category
select category,sum(profit) as total_profit
from superstoreorders group by category
order by sum(profit) desc;

-- Task 3.5 compare toatal sales and total profit by category
select category, sum(sales) as toatl_sales,
sum(profit) as total_profit from superstoreorders
group by category order by sum(sales) desc;

-- Task 3.6 calculate profit margin for each product category
select category, sum(sales) as total_sales,
sum(profit) as total_profit ,
round(sum(profit) / sum(sales) * 100,2)
as category_profit_margin 
from superstoreorders
group by category order by sum(sales) desc;

-- Task 3.7 Analyzing sales and profit by sub-category
select sub_category,sum(sales) as total_sales, 
sum(profit) as total_profit 
from superstoreorders 
group by sub_category 
order by sum(sales) desc;

-- Task 3.8 identify the top 10 product by total sales
select product_name ,sum(sales) as toatl_sales
from superstoreorders
group by product_name order by sum(sales)
desc limit 10;

-- Task 3.9 identify top 10 products by profit
select product_name,sum(profit) as total_sales
from superstoreorders
group by product_name 
order by sum(profit) desc limit 10;

-- Task 3.10 loss making products 
select product_name ,sum(profit) as toatl_loss
from superstoreorders 
group by product_name
having sum(profit) < 0
order by sum(profit) asc;

-- Task 3.11 identify the most profitable sub-category
select sub_category,sum(profit) as total_profit
from superstoreorders 
group by sub_category
order by sum(profit) desc limit 1;

-- Task 3.12 anaylyzing sales performance by year
select sum(sales) as total_sales,
year 
from superstoreorders 
group by year 
order by year desc;

-- Task 3.13 Analyzing year peofit performance
select year , sum(profit) as total_sales
from superstoreorders 
group by year order by year desc;

-- Task 3.14 compare yearly sales and profit performance
select year, sum(sales) as total_sales,
sum(profit) as total_profit
from superstoreorders 
group by year
order by year desc;

-- Task 3.15 identify the top 10 products by profit margin
select product_name , sum(profit) as total_profit
from superstoreorders 
group by product_name 
order by sum(profit) desc limit 10;

-- Task 3.16 Analyzing sales and profit by category and sub_category 
select category ,sub_category,
sum(sales) as total_sales,
sum(profit) as toatl_profit
from superstoreorders 
group by category,sub_category
order by sum(sales) desc;
-- ========================================
-- 4.CUSTOMER ANALYSIS
-- =========================================
-- Task 4.1 identify the top 10 customer by totaL sales
select customer_name, sum(sales) as total_sales
from superstoreorders 
group by customer_name 
order by sum(sales) desc limit 10;

-- Task 4.2 identify the top 10 customer by total profit 
select customer_name , sum(profit) as toatal_profit
from superstoreorders
group by customer_name 
order by sum(profit) desc limit 10;

-- Task 4.3 Identify customers with the highest number of order 
select customer_name, count( distinct order_id) as highest_order
from superstoreorders
group by customer_name
order by  count(distinct order_id) desc limit 10;

-- Task 4.4 calculate the average sales generated per customer
select customer_name , avg(sales) as avg_sales
from superstoreorders
group by customer_name
order by avg(sales) desc ;

-- Task 4.5 Analyze sales and profit by customer segment
select segment, sum(sales) as total_sales,
sum(profit) as toatl_profit 
from superstoreorders 
group by segment
order by sum(sales) desc;
-- =========================================
-- 5. REGIONAL & MERKET ANALYSIS
-- ==========================================
-- Task 5.1 analyze sales and profit by market
select market, sum(sales) as total_sales,
sum(profit) as total_profit 
 from superstoreorders 
 group by market order by sum(sales) desc;
 
 -- Task 5.2 analyze sales and profit by region 
 select region , sum(sales) as total_sales,
 sum(profit) as total_profit 
 from superstoreorders 
 group by region order by sum(sales) desc;
 
 -- Task 5.3 Analyze state wise sales and profit 
 select state , sum(sales) as total_sales,
 sum(profit) as total_profit
 from superstoreorders
 group by state order by sum(sales) desc
 limit 10;

-- Task 5.4 identify the most profitable region 
select region,
sum(profit) as total_profit 
from superstoreorders 
group by region order by sum(profit) desc;

-- Task 5.5 Identify the top 10 most profitable state
select state , sum(profit) as total_profit
from superstoreorders
group by state order by sum(profit) desc
limit 10;
-- ===================================================
-- 6.DISCOUNT & SHIPPING ANALYSIS
-- ===================================================
-- Task 6.1 analyze sales and profit by discount level
select discount , sum(sales) as total_sales,
sum(profit) as total_profit 
from superstoreorders
group by discount 
order by discount;

-- Task 6.2 Analyze the impact of discount on profit
select discount,
count(*) as total_records,
sum(sales) as total_sales,
sum(profit) as total_profit,
round(sum(profit) / sum(sales) *100,2) 
as profit_margin_percentage
from superstoreorders 
group by discount
order by discount;

-- Task 6..3 Analyze sales and profit by shipping mode
select ship_mode,count(distinct order_id)
as total_orders,
sum(sales) as total_sales,
sum(profit) as total_profit
from superstoreorders
group by ship_mode
order by sum(sales) desc;
-- ===============================================
-- 7. ADVANCE SQL ANALYSIS
-- ===============================================
-- Task 7.1 Find the top 10 product by sales 
select category ,product_name,
sum(sales) as total_sales
from superstoreorders
group by category ,product_name
order by sum(sales)
desc limit 10;

-- Task 7.2 Analyze yearly sales growth
with yearly_sales as 
(select year, sum(sales) as total_sales
from superstoreorders
group by year)
select year, total_sales,
round((total_sales - lag(total_sales)
over (order by year))
/ lag(total_sales) over (order by year) * 100,2) as growth_percentage
from yearly_sales
order by year;

-- Task 7.3 identify the top 5 most profitable products
select product_name , sum(profit) as total_profit
from superstoreorders
 group by product_name
 order by total_profit desc
 limit 5;
 
 -- Task 7.4 Identify the top 5 loss-making products
 select product_name ,
 sum(profit) as toatal_profit
 from superstoreorders
 group by product_name
 having sum(profit) < 0
 order by sum(profit)
 asc limit 5;
 
 -- Task 7.5 calculate average order value 
 select round(sum(sales) /
 count(distinct order_id),2 )
 as average_order_value
 from superstoreorders;
 
 
 