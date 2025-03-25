
/*
Overview
This SQL script processes raw CRM sales data from the bronze layer and loads it into the silver layer (silver.crm_sales_details).
It performs essential data cleaning, validation, and transformation before inserting records.

Key Features
 1.Handles Invalid Dates → Converts incorrectly formatted dates or sets them to NULL
 2.Fixes Sales Price Calculation → Ensures sls_sales = sls_quantity * abs(sls_price)
 3.Prevents Division by Zero → Uses NULLIF(sls_quantity, 0) to avoid errors
 4.Ensures Data Consistency → Drops & recreates the target table before insertion

*/


IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;
GO
CREATE TABLE silver.crm_sales_details
(
    sls_ord_num Nvarchar(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id int,
    sls_order_dt date,
    sls_ship_dt date,
    sls_due_dt date,
    sls_sales int,
    sls_quantity int,
	sls_price int,
    dwh_create_time DATETIME2 DEFAULT GETDATE()
);

INSERT INTO silver.crm_sales_details
(
	sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
)
select 
sls_ord_num,
sls_prd_key,
sls_cust_id,
case when sls_order_dt <= 0 or len(sls_order_dt) !=8 THEN Null
	ELSE cast(cast (sls_order_dt AS varchar) AS DATE)
END AS sls_order_dt,
case when sls_ship_dt <= 0 or len(sls_ship_dt) !=8 THEN Null
	ELSE cast(cast (sls_ship_dt AS varchar) AS DATE)
END AS sls_ship_dt,
case when sls_due_dt <= 0 or len(sls_due_dt) !=8 THEN Null
	ELSE cast(cast (sls_due_dt AS varchar) AS DATE)
END AS sls_due_dt,
case when sls_sales is null or sls_sales <=0 or sls_sales != sls_quantity*abs(sls_price)
		then sls_quantity*abs(sls_price)
	else sls_sales
end as sls_sales,
sls_quantity,
case when sls_price is null or sls_price <=0
		then sls_sales/nullif(sls_quantity,0)
	else sls_price
end as sls_price
from bronze.crm_sales_details
