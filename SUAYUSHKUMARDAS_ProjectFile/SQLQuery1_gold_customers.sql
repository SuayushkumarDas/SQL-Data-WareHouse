CREATE view gold.dim_customers AS
select 
	ROW_NUMBER() OVER (ORDER BY cst_id) as customer_key,
	ci.cst_id as customer_id,
	ci.cst_key as customer_number,
	ci.cst_firstname first_name,
	ci.cst_lastname last_name,
	la.cntry as country,
	ci.cst_marital_status as martial_status,
	case 
	when ci.cst_gndr != 'n/a' then ci.cst_gndr
	else coalesce(ca.gen,'n/a')
end as gender,
	ca.bdate as birthdate,
	ci.cst_create_date as create_date
from silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
on ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
on ci.cst_key = la.cid
