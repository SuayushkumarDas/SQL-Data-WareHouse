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