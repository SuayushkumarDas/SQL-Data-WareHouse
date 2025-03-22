/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/
IF OBJECT_ID(' bronze.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE  bronze.crm_cust_info;
GO
CREATE TABLE bronze.crm_cust_info
(
	cst_id int,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname Nvarchar(50),
	cst_material_status Nvarchar(50),
	cst_gender Nvarchar(50),
	cst_create_date DATE
);

GO
  
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE  bronze.crm_sales_details;
GO
  
CREATE TABLE bronze.crm_sales_details
(
	sls_ord_num Nvarchar(50),
	sls_prd_key Nvarchar(50),
	sls_cust_id int,
	sls_order_dt int,
	sls_ship_dt int,
	sls_due_dt int,
	sls_sales int,
	sls_quantity int,
	sls_price int
);

GO
  
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE  bronze.crm_prd_info;

GO
  
CREATE TABLE bronze.crm_prd_info
(
	prd_id int,
	prd_key Nvarchar(50),
	prd_nm Nvarchar(50),
	prd_cost int,
	prd_line Nvarchar(50),
	prd_start_dt DATETIME,
	prd_end_dt DATETIME
);

GO

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
	DROP TABLE  bronze.erp_loc_a101;

GO
  
create table bronze.erp_loc_a101
(
	cid Nvarchar(50),
	cntry NVARCHAR(50),
);

GO
  
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
	DROP TABLE  bronze.erp_cust_az12;

GO
  
create table bronze.erp_cust_az12
(
	cid Nvarchar(50),
	bdate DATE,
	gen Nvarchar(50)
);

GO
  
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
	DROP TABLE  bronze.erp_px_cat_g1v2;
GO
create table bronze.erp_px_cat_g1v2
(
	id Nvarchar(50),
	cat NVARCHAR(50),
	subcat Nvarchar(50),
	maintenance NVARCHAR(50)
);

GO
