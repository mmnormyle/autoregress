drop procedure IF Exists AutoRegress
GO

create procedure AutoRegress @table_name varchar(MAX), @dependent_name varchar(MAX), @model_table_name varchar(MAX), @model_name varchar(MAX)
AS

DECLARE @model varbinary(MAX);
exec sp_execute_external_script
@language = N'Python',
@script = N'
import revoscalepy as rp

def get_formula(dependent_name: str, column_names: list):
    column_names.remove(dependent_name)
    ind_formula = ""
    for i, name in enumerate(column_names):
        if i > 0: ind_formula += " + "
        ind_formula += name
    return dependent_name + " ~ " + ind_formula

connection_string = "Driver=SQL Server;Server=localhost;Database=RevoTestDB;Trusted_Connection=Yes;"

data_source = rp.RxSqlServerData(connection_string=connection_string, table=table_name, string_as_factors=True)

var_info = rp.rx_get_var_info(data_source)

column_names = list(var_info.keys())

formula = get_formula(dependent_name, column_names)
print(formula)

lin_mod = rp.rx_lin_mod(formula, data=data_source)
print(lin_mod)

model_data = rp.rx_serialize_model(lin_mod, realtime_scoring_only=False)

model_data_table = rp.RxSqlServerData(connection_string=connection_string, table = model_table_name)
rp.rx_write_object(dest=model_data_table, key=model_name, value=model_data, key_name="model_name", value_name="model_data")
'
  , @params = N'
@model varbinary(max) OUTPUT,
@table_name varchar(max),
@dependent_name varchar(max),
@model_table_name varchar(max),
@model_name varchar(max)
'
  , @model = @model OUTPUT
  , @table_name = @table_name
  , @dependent_name = @dependent_name
  , @model_table_name = @model_table_name
  , @model_name = @model_name
GO