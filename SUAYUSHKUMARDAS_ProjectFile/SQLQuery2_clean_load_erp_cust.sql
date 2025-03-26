insert into silver.erp_cust_az12
(
	cid,
	bdate,
	gen
)
SELECT 
CASE WHEN cid like 'NAS%' THEN SUBSTRING(cid,4,len(cid))
	else cid
end as cid,
case 
when bdate > getdate() then null
	else bdate
end as bdate,
case 
when upper(trim(gen)) in ('F','FEMALE') THEN 'Female'
when upper(trim(gen)) in ('M','MALE') THEN 'Male'
	else 'n/a'
end as gen
from bronze.erp_cust_az12