/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/



create or alter procedure bronze.load_bronze as
begin 
    declare @start_time datetime, @end_time datetime,@bstart_time datetime, @bend_time datetime;
	begin try
	    set @bstart_time=getdate();
		print '======================='
		print 'Loading crm tables'
		print '======================='
		set @start_time=getdate();
		truncate table bronze.crm_cust_info
		bulk insert bronze.crm_cust_info
		from 'C:\Users\navan\oneDrive\Documents\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
			);

		truncate table bronze.crm_prd_info
		bulk insert bronze.crm_prd_info
		from 'C:\Users\navan\OneDrive\Documents\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
			);

		truncate table bronze.crm_sales_details
		bulk insert bronze.crm_sales_details
		from 'C:\Users\navan\OneDrive\Documents\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
			);
		set @end_time=getdate();
		print'>> Load duration : ' +cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds';
		print '---------------------------------------------------------------------------------------------'     
		print '======================='
		print ' Loading erp tables'
		print '======================='



		set @start_time=getdate();
		truncate table bronze.erp_cust_az12
		bulk insert bronze.erp_cust_az12
		from 'C:\Users\navan\OneDrive\Documents\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
			);

		truncate table bronze.erp_loc_a101
		bulk insert bronze.erp_loc_a101
		from 'C:\Users\navan\OneDrive\Documents\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
			);

		truncate table bronze.erp_px_cat_g1v2
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\navan\OneDrive\Documents\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
			);
		set @end_time=getdate();
		print'>> Load duration : ' +cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds';
		print '---------------------------------------------------------------------------------------------'

		set @bend_time=getdate();
		print'>>Total Load duration of Bronze layer : ' +cast(datediff(second,@bstart_time,@bend_time) as nvarchar) + ' seconds';
		print '---------------------------------------------------------------------------------------------'

	end try
	begin catch 
		print '======================='
		print 'eror occured during loading'
		print '======================='
	end catch
end
