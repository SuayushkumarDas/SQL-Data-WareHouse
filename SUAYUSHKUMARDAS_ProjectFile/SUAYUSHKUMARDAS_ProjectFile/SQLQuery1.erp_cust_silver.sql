-- Quality check



-- Identifying out-range dates
select distinct bdate
from silver.erp_cust_az12
where bdate < '1924-01-01' or bdate > getdate()

-- Data Standardization and consistency
select distinct 
gen, 
case 
when upper(trim(gen)) in ('F','FEMALE') THEN 'Female'
when upper(trim(gen)) in ('M','MALE') THEN 'Male'
	else 'n/a'
end as gen
from silver.erp_cust_az12
