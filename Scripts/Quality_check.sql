/*
Overview
This SQL script performs data validation, quality checks, and transformation for CRM sales and product information before moving records into the silver layer. It ensures data accuracy, consistency, and integrity by identifying and fixing common data issues.

Key Features
🔍 Quality Checks on Sales Data (silver.crm_sales_details)
✔ Detects Invalid Dates → Ensures sls_order_dt, sls_ship_dt, and sls_due_dt are properly formatted
✔ Finds Logical Date Errors → Flags records where sls_order_dt > sls_ship_dt or sls_order_dt > sls_due_dt
✔ Validates Sales Calculations → Ensures sls_sales = sls_quantity * abs(sls_price)
✔ Handles Missing & Negative Values → Corrects NULL and negative values for sls_sales, sls_price, and sls_quantity

📊 Data Quality Checks for Product Data (silver.crm_prd_info)
✔ Ensures Primary Key Integrity → Checks for duplicates & NULL values in prd_id
✔ Removes Unwanted Spaces → Trims extra spaces in prd_nm
✔ Detects Invalid Product Costs → Ensures prd_cost is not NULL or negative
✔ Verifies Data Consistency → Standardizes prd_line values
✔ Checks for Invalid Dates → Ensures prd_end_dt >= prd_start_dt

SQL Operations in This Script
1️⃣ Data Integrity Checks → Detects duplicates, missing values, and inconsistencies
2️⃣ Data Standardization → Ensures formatting consistency across key fields
3️⃣ Business Logic Validation → Enforces correct sales and pricing calculations
4️⃣ Ensures Readiness for gold Layer

*/

-- QUALITY CHECK FOR THE prouduct SILVER TABLE



-- CHECKING FOR NULLS OR DUPLICATES IN PRIMARY KEY
-- EXPECTATION: NO RESULT
SELECT prd_id,count(*)
from silver.crm_prd_info
group by prd_id
having count(*) > 1 or prd_id is null

-- CHECKING UNWANTED SPACES
-- EXPECATION :NO RESULT
SELECT prd_nm
from silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- CHECKING UNWANTED SPACES
-- EXPECATION :NO RESULT
SELECT prd_nm
from silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

--CHECKING NULLS OR NEGATIVE NUMBER
---- EXPECATION :NO RESULT
SELECT prd_cost
from silver.crm_prd_info 
where prd_cost is null or prd_cost < 0

-- DATA STANDARDIZATION AND CONSISTENCY
select DISTINCT prd_line
from silver.crm_prd_info

--CHECK FOR INVALID DATES ORDERS
SELECT* FROM silver.crm_prd_info
where prd_end_dt < prd_start_dt

select * from silver.crm_prd_info

-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- QUALITY CHECK FOR SALES TABLES

-- Check for Invalid Dates
select 
NULLIF(sls_order_dt,0)
sls_order_dt
from silver.crm_sales_details 
where sls_order_dt <= 0 or len(sls_order_dt) !=8

select 
NULLIF(sls_ship_dt,0)
sls_ship_dt
from silver.crm_sales_details 
where sls_ship_dt <= 0 or len(sls_ship_dt) !=8

select 
NULLIF(sls_due_dt,0)
sls_due_dt
from silver.crm_sales_details 
where sls_due_dt <= 0 or len(sls_due_dt) !=8

-- check for Invalid date
select * from silver.crm_sales_details
where sls_order_dt > sls_ship_dt or sls_order_dt > sls_due_dt

-- NULL,NEGATIVE OR WRONG VALUES CHECK
select distinct
sls_sales AS old_sls_sales,
sls_quantity,
sls_price as old_sls_price,
case when sls_sales is null or sls_sales <=0 or sls_sales != sls_quantity*abs(sls_price)
		then sls_quantity*abs(sls_price)
	else sls_sales
end as sls_sales,
case when sls_price is null or sls_price <=0
		then sls_sales/nullif(sls_quantity,0)
	else sls_price
end as sls_price
from silver.crm_sales_details
where sls_sales !=sls_quantity*sls_price
or sls_sales is null or sls_quantity is null or sls_price is null
or sls_sales <=0 or sls_quantity<=0 or sls_price <=0
order by sls_quantity,sls_price,sls_sales





