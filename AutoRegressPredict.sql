drop procedure IF Exists AutoRegressPredict
GO

create procedure AutoRegressPredict @model_table_name varchar(MAX), @input_table_name varchar(MAX), @output_table_name varchar(MAX)
AS

drop table dbo.ml_models;
create table ml_models(model_name varchar(MAX), model_version varchar(MAX), native_model_object varbinary(MAX));

DECLARE @model varbinary(MAX);
exec sp_execute_external_script
@language = N'Python',
@script = N'
import revoscalepy as rp
'
  , @params = N'
@model varbinary(max) OUTPUT,
@table_name varchar(max),
@dependent_name varchar(max)
'
  , @model = @model OUTPUT
  , @table_name = @table_name
  , @dependent_name = @dependent_name
  INSERT [ml_models]([model_name], [model_version], [native_model_object])
  VALUES('linmod','v1', @model) ;

GO