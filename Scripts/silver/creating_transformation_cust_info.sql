/*
Overview
This SQL script extracts, transforms, and loads (ETL) customer data from bronze.crm_cust_info into silver.crm_cust_info. 
It ensures data quality, standardization, and deduplication, keeping only the latest customer records.

Key Features
1 Trims Whitespace → Cleans cst_firstname and cst_lastname
2 Standardizes Marital Status → Converts S → Single, M → Married, others → N/A
3 Fixes Gender Values → Converts M → Male, F → Female, others → N/A
4 Deduplicates Customers → Uses ROW_NUMBER() to keep only the latest cst_create_date

SQL Operations in This Script
1️ Extracts & Cleans Data → Removes extra spaces and ensures correct formatting
2️ Transforms Key Fields → Fixes cst_marital_status and cst_gndr
3️ Handles Duplicates → Keeps only the latest record per customer using ROW_NUMBER()
4️ Loads Clean Data into silver.crm_cust_info

*/

INSERT INTO silver.crm_cust_info
(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
)


SELECT
    cst_id,
    cst_key,
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname,
	case 
		when upper(trim(cst_material_status)) = 'S' then 'Single'
		when upper(trim(cst_material_status)) = 'M' then 'Married'
		else 'N/A'
	end cst_material_status,
    CASE 
        WHEN UPPER(TRIM(cst_gender)) = 'F' THEN 'Female' 
        WHEN UPPER(TRIM(cst_gender)) = 'M' THEN 'Male'
        ELSE 'N/A'
    END cst_gender,  
    cst_create_date
FROM
(
    SELECT *, 
        ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS Flag_last
    FROM bronze.crm_cust_info
    WHERE cst_id IS NOT NULL
) t 
WHERE Flag_last = 1; 


