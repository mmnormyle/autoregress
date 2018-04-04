declare @table_name varchar(MAX) = 'TheBestTable'
declare @dependent_name varchar(MAX) = 'y'
declare @model_table_name varchar(MAX) = 'MyRegressionModels'
declare @model_name varchar(MAX) = 'MyLinModModel'

exec AutoRegress @table_name, @dependent_name, @model_table_name, @model_name;