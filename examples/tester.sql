declare @database_name varchar(MAX) = 'RevoTestDB'
declare @table_name varchar(MAX) = 'AirlineDemoSmall'
declare @dependent_name varchar(MAX) = 'ArrDelay'
declare @model_table_name varchar(MAX) = 'aSdasdmymodels'
declare @model_name varchar(MAX) = 'model1'

exec AutoRegress @database_name, @table_name, @dependent_name, @model_table_name, @model_name;

declare @view_models varchar(MAX) = 'select * from ' + @model_table_name
exec(@view_models)

declare @test_data_table_name varchar(MAX) = 'AirlineDemoSmall'
declare @predictions_table_name varchar(MAX) = 'AirlinePredictions'

exec AutoRegressPredict @database_name, @model_table_name, @model_name, @test_data_table_name, @predictions_table_name

declare @view_predictions varchar(MAX) = 'select * from ' + @predictions_table_name

exec(@view_predictions)
GO