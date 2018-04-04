declare @input_table_name varchar(MAX) = 'AirlineDemoSmall'
declare @output_table_name varchar(MAX) = 'PredictResults'
declare @model_table_name varchar(MAX) = 'MyCharRegressionModels'
declare @model_name varchar(MAX) = 'MyLinModModel4'

exec AutoRegressPredict @model_table_name, @model_name, @input_table_name, @output_table_name

declare @sql varchar(MAX) = 'select * from ' + @output_table_name

exec(@sql)
GO