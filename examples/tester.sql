declare @database_name varchar(MAX) = 'AutoRegressTestDB'

declare @use_db_sql varchar(MAX) = 'use ' + @database_name + ';'
exec(@use_db_sql)

GO

use AutoRegressTestDB;

declare @database_name varchar(MAX) = 'AutoRegressTestDB'
declare @table_name varchar(MAX) = 'IrisData'
declare @dependent_name varchar(MAX) = 'y'
declare @model_table_name varchar(MAX) = 'RegressionModels'
declare @model_name varchar(MAX) = 'fake_data_model_1'

exec AutoRegress @database_name, @table_name, @dependent_name, @model_table_name, @model_name;

declare @view_models varchar(MAX) = 'select * from ' + @model_table_name
exec(@view_models)

declare @test_data_table_name varchar(MAX) = 'FakeData'
declare @predictions_table_name varchar(MAX) = 'FakeDataPredictions'

exec AutoRegressPredict @database_name, @model_table_name, @model_name, @test_data_table_name, @predictions_table_name

declare @view_predictions varchar(MAX) = 'select * from ' + @predictions_table_name

exec(@view_predictions)
GO
