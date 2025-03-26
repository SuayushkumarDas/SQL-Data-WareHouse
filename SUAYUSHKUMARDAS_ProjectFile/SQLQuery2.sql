EXEC bronze.load_bronze

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN 
DECLARE @START_TIME DATETIME, @END_TIME DATETIME ,@BATCH_TIME_START DATETIME,@BATCH_TIME_END DATETIME
BEGIN TRY

SET @BATCH_TIME_START = GETDATE();
print '=================================================';
print 'LOADING BRONZE LAYER';
PRINT '=================================================';

PRINT '-----------------------------------------------------';
PRINT 'LOADING CMR TABLES';
print '------------------------------------------------------';

SET @START_TIME = GETDATE();
PRINT '>> TRUCATING TABLE: bronze.crm_cust_info';
TRUNCATE TABLE bronze.crm_cust_info; 
PRINT '>> INSERTING DATA INTO:bronze.crm_cust_info';
BULK INSERT bronze.crm_cust_info
from 'C:\Users\Abhil\OneDrive\Desktop\project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with
(
	FIRSTROW = 2,
	fieldTERMINATOR = ',',
	TABLOCK
);
SET @END_TIME = GETDATE();
PRINT '>>LOAD DURATION: '+ CAST(DATEDIFF(second,@START_TIME,@END_TIME) AS NVARCHAR) + 'seconds'; 
PRINT '--------------------'

SET @START_TIME = GETDATE();
PRINT '>> TRUCATING TABLE: bronze.crm_prd_info';
TRUNCATE TABLE bronze.crm_prd_info; 
PRINT '>> INSERTING DATA INTO:bronze.crm_prd_info';
BULK INSERT bronze.crm_prd_info
from 'C:\Users\Abhil\OneDrive\Desktop\project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with
(
	FIRSTROW = 2,
	fieldTERMINATOR = ',',
	TABLOCK
);
SET @END_TIME = GETDATE();
PRINT '>>LOAD DURATION: '+ CAST(DATEDIFF(second,@START_TIME,@END_TIME) AS NVARCHAR) + 'seconds'; 
PRINT '--------------------'


SET @START_TIME = GETDATE();
PRINT '>> TRUCATING TABLE:bronze.crm_sales_details';
TRUNCATE TABLE bronze.crm_sales_details; 
PRINT '>> INSERTING DATA INTO:bronze.crm_sales_details';
BULK INSERT bronze.crm_sales_details
from 'C:\Users\Abhil\OneDrive\Desktop\project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with
(
	FIRSTROW = 2,
	fieldTERMINATOR = ',',
	TABLOCK
);
SET @END_TIME = GETDATE();
PRINT '>>LOAD DURATION: '+ CAST(DATEDIFF(second,@START_TIME,@END_TIME) AS NVARCHAR) + 'seconds'; 
PRINT '--------------------'

PRINT '-----------------------------------------------------';
PRINT 'LOADING CMR TABLES';
print '------------------------------------------------------';

SET @START_TIME = GETDATE();
PRINT '>> TRUCATING TABLE:bronze.erp_loc_a101';
TRUNCATE TABLE bronze.erp_loc_a101; 
PRINT '>> INSERTING DATA INTO:bronze.erp_loc_a101';
BULK INSERT bronze.erp_loc_a101
from 'C:\Users\Abhil\OneDrive\Desktop\project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
with
(
	FIRSTROW = 2,
	fieldTERMINATOR = ',',
	TABLOCK
);
SET @END_TIME = GETDATE();
PRINT '>>LOAD DURATION: '+ CAST(DATEDIFF(second,@START_TIME,@END_TIME) AS NVARCHAR) + 'seconds'; 
PRINT '--------------------'

SET @START_TIME = GETDATE();
PRINT '>> TRUCATING TABLE: bronze.erp_cust_az12';
TRUNCATE TABLE bronze.erp_cust_az12; 
PRINT '>> INSERTING DATA INTO:bronze.erp_cust_az12';
BULK INSERT bronze.erp_cust_az12
from 'C:\Users\Abhil\OneDrive\Desktop\project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with
(
	FIRSTROW = 2,
	fieldTERMINATOR = ',',
	TABLOCK
);
SET @END_TIME = GETDATE();
PRINT '>>LOAD DURATION: '+ CAST(DATEDIFF(second,@START_TIME,@END_TIME) AS NVARCHAR) + 'seconds'; 
PRINT '--------------------'

SET @START_TIME = GETDATE();
PRINT '>> TRUCATING TABLE: bronze.erp_px_cat_g1v2';
TRUNCATE TABLE bronze.erp_px_cat_g1v2; 
PRINT '>> INSERTING DATA INTO:bronze.erp_px_cat_g1v2';
BULK INSERT bronze.erp_px_cat_g1v2
from 'C:\Users\Abhil\OneDrive\Desktop\project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
with
(
	FIRSTROW = 2,
	fieldTERMINATOR = ',',
	TABLOCK
);
SET @END_TIME = GETDATE();
PRINT '>>LOAD DURATION: '+ CAST(DATEDIFF(second,@START_TIME,@END_TIME) AS NVARCHAR) + 'seconds'; 
PRINT '--------------------'

SET @BATCH_TIME_END = GETDATE();
PRINT'>> LOAD DURATION OF THE BATCH: '+ cast(DATEDIFF(second,@BATCH_TIME_START,@BATCH_TIME_END) AS NVARCHAR) + 'seconds';
END TRY
BEGIN CATCH
print '======================================';
PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
print 'ERROR MESSAGE' + ERROR_MESSAGE();
print 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
print 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
print '=======================================';
END CATCH
END
