-- TODO: remove character data
-- TODO: examples, dataset and documentation
-- TODO: store model information in table

drop procedure IF Exists AutoRegress
GO

create procedure AutoRegress @database_name varchar(MAX), @table_name varchar(MAX), @dependent_name varchar(MAX), @model_table_name varchar(MAX), @model_name varchar(MAX)
AS

exec sp_execute_external_script
@language = N'Python',
@script = N'
import revoscalepy as rp
import pandas as pd
import time
import sqlalchemy
from urllib import parse

connection_string = "Driver=SQL Server;Server=localhost;Database=" + database_name + ";Trusted_Connection=Yes;"

data_source = rp.RxSqlServerData(connection_string=connection_string, table=table_name, string_as_factors=True)

var_info = rp.rx_get_var_info(data_source)

feature_names = []
for var in var_info:
    if var != dependent_name and var_info[var]["varType"] != "character":
        feature_names.append(var)

formula = dependent_name + " ~ " + " + ".join(feature_names)

lin_mod = rp.rx_lin_mod(formula, data=data_source)

model_data = rp.rx_serialize_model(lin_mod, realtime_scoring_only=False)

print(type(model_data))

model_data_table = rp.RxSqlServerData(connection_string=connection_string, table = model_table_name)

model_info = pd.DataFrame()
model_info["model_name"] = [model_name]
model_info["model_data"] = [model_data]
model_info["timestamp"] = [time.time()]

engine = sqlalchemy.create_engine("mssql+pyodbc:///?odbc_connect={}".format(parse.quote_plus(connection_string)))
model_info.to_sql(model_table_name, engine, if_exists="append", dtype={"model_data": sqlalchemy.types.LargeBinary})
'
  , @params = N'
@database_name varchar(max),
@table_name varchar(max),
@dependent_name varchar(max),
@model_table_name varchar(max),
@model_name varchar(max)
'
  , @database_name = @database_name
  , @table_name = @table_name
  , @dependent_name = @dependent_name
  , @model_table_name = @model_table_name
  , @model_name = @model_name
GO