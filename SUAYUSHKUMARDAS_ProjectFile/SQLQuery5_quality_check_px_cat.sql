-- QUALITY CHECK 

-- SELECTED UNWANTED SPACES
SELECT * FROM bronze.erp_px_cat_g1v2
where cat!= trim(cat) or subcat!= trim(subcat) or maintenance!= trim(maintenance)

-- Data standarization and consistency
select distinct 
maintenance 
from bronze.erp_px_cat_g1v2
