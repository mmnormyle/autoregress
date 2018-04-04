declare @database_name varchar(MAX) = 'RevoTestDB'
declare @input_table_name varchar(MAX) = 'TheBestTable'
declare @output_table_name varchar(MAX) = 'NewPredictResults'
declare @model_table_name varchar(MAX) = 'New2RegressionModels'
declare @model_name varchar(MAX) = 'nummodel2'

exec AutoRegressPredict @database_name, @model_table_name, @model_name, @input_table_name, @output_table_name

declare @sql varchar(MAX) = 'select * from ' + @output_table_name

exec(@sql)
GO