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




