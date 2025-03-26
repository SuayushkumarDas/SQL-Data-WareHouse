CREATE VIEW gold.dim_sales AS
select 
sd.sls_ord_num,
pr.products_key,
cu.customer_key,
sd.sls_order_dt as order_date,
sd.sls_ship_dt as shipping_date,
sd.sls_due_dt as due_date,
sd.sls_sales as sales_amount,
sd.sls_quantity as quantity,
sd.sls_price
from silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
on sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
on sd.sls_cust_id = cu.customer_id
