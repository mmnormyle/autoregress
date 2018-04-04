declare @database_name varchar(MAX) = 'RevoTestDB'
declare @table_name varchar(MAX) = 'TheBestTable'
declare @dependent_name varchar(MAX) = 'y'
declare @model_table_name varchar(MAX) = 'ArrDelayRegressionModels'
declare @model_name varchar(MAX) = 'model3'

exec AutoRegress @database_name, @table_name, @dependent_name, @model_table_name, @model_name;

declare @view_models varchar(MAX) = 'select * from ' + @model_table_name
exec(@view_models)

declare @test_data_table_name varchar(MAX) = 'TheBestTable'
declare @predictions_table_name varchar(MAX) = 'AirlinePredictions'

exec AutoRegressPredict @database_name, @model_table_name, @model_name, @test_data_table_name, @predictions_table_name

declare @view_predictions varchar(MAX) = 'select * from ' + @predictions_table_name

exec(@view_predictions)
GO