declare @table_name varchar(MAX) = 'AirlineDemoSmall'
declare @dependent_name varchar(MAX) = 'ArrDelay'
declare @model_table_name varchar(MAX) = 'MyCharRegressionModels'
declare @model_name varchar(MAX) = 'MyLinModModel4'

exec AutoRegress @table_name, @dependent_name, @model_table_name, @model_name;