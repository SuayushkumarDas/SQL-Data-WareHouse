IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;
GO
CREATE TABLE silver.crm_prd_info
(
    prd_id INT,
    cat_id NVARCHAR(50),
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

INSERT INTO silver.crm_prd_info
(
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
)
SELECT 
prd_id,
REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
prd_nm,
ISNULL(prd_cost,0) AS prd_cost,
case 
	WHEN upper(trim(prd_line)) = 'M' THEN 'Mountain'
	when upper(trim(prd_line)) = 'S' then 'Other sales'
	when upper(trim(prd_line)) = 'R' then 'Road'
	when upper(trim(prd_line)) = 'T' then 'Touring'
	else 'N/A'
end as prd_line,
cast(prd_start_dt AS DATE) AS prd_start_dt,
cast(lead(prd_start_dt) over (partition by prd_key order by prd_start_dt)-1 AS DATE) AS prd_end_dt
from bronze.crm_prd_info