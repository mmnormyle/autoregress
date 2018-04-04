drop procedure IF Exists AutoRegressPredict
GO

create procedure AutoRegressPredict @database_name varchar(MAX), @model_table_name varchar(MAX), @model_name varchar(MAX), @input_table_name varchar(MAX), @output_table_name varchar(MAX)
AS

DECLARE @model varbinary(MAX);
exec sp_execute_external_script
@language = N'Python',
@script = N'
import sqlalchemy
from urllib import parse
import revoscalepy as rp
import pandas as pd
connection_string = "Driver=SQL Server;Server=localhost;Database=" + database_name + ";Trusted_Connection=Yes;"

query = "select top 1 * from " + model_table_name + " where model_name = ''{}'' order by timestamp DESC".format(model_name)
engine = sqlalchemy.create_engine("mssql+pyodbc:///?odbc_connect={}".format(parse.quote_plus(connection_string)))
model_df = pd.read_sql(query, engine)
model_data = model_df["model_data"][0]

model = rp.rx_unserialize_model(model_data)

prediction_data = rp.RxSqlServerData(table = input_table_name, connection_string=connection_string, strings_as_factors=True)
columns = rp.rx_get_var_info(prediction_data)
column_names = list(columns.keys())
output_data = rp.RxSqlServerData(table = output_table_name, connection_string=connection_string)

rp.rx_predict(model_object=model, data=prediction_data, output_data=output_data, extra_vars_to_write=column_names, overwrite=True)
'
  , @params = N'
@database_name varchar(MAX),
@model_table_name varchar(max),
@model_name varchar(max),
@input_table_name varchar(max),
@output_table_name varchar(max)
'
  , @database_name = @database_name
  , @model_table_name = @model_table_name
  , @model_name = @model_name
  , @input_table_name = @input_table_name
  , @output_table_name = @output_table_name

GO