CREATE VIEW gold.dim_products as 
select 
	ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt,pn.prd_key) as products_key,
	pn.prd_id as product_id,
	pn.prd_key as product_key,
	pn.prd_nm as product_name,
	pn.cat_id as category_id,
	pc.cat as category,
	pc.subcat as subcategory,
	pc.maintenance,
	pn.prd_cost as cost,
	pn.prd_line as product_line,
	pn.prd_start_dt as start_date
from silver.crm_prd_info pn 
LEFT JOIN silver.erp_px_cat_g1v2 PC
ON PN.cat_id = PC.id