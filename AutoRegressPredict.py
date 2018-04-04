model_table_name = ""
model_name = ""
input_table_name = ""
output_table_name = ""

import revoscalepy as rp
connection_string = "Driver=SQL Server;Server=localhost;Database=RevoTestDB;Trusted_Connection=Yes;"

model_table = rp.RxSqlServerData(table = model_table_name, connection_string=connection_string)
model_data = rp.rx_read_object(model_table, key = model_name, key_name = "model_name", value_name = "model_data")

model = rp.rx_unserialize_model(model_data)

prediction_data = rp.RxSqlServerData(table = input_table_name, connection_string=connection_string, strings_as_factors=True)
columns = rp.rx_get_var_info(prediction_data)
column_names = list(columns.keys())
output_data = rp.RxSqlServerData(table = output_table_name, connection_string=connection_string)

rp.rx_predict(model_object=model, data=prediction_data, output_data=output_data, extra_vars_to_write=column_names, overwrite=True)
