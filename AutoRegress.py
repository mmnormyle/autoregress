# TODO: database parameter
# TODO: save model timestamp
# TODO: remove character data
# TODO: examples, dataset and documentation
############################
# TODO: store model information in table

table_name = "AirlineDemoSmall"
dependent_name = "ArrDelay"
model_name = "MyModel"
model_table_name = ""

import revoscalepy as rp

def get_formula(dependent_name: str, feature_names: list):
    ind_formula = ""
    for i, name in enumerate(feature_names):
        if i > 0: ind_formula += " + "
        ind_formula += name
    return dependent_name + " ~ " + ind_formula

connection_string = "Driver=SQL Server;Server=localhost;Database=RevoTestDB;Trusted_Connection=Yes;"

data_source = rp.RxSqlServerData(connection_string=connection_string, table=table_name, string_as_factors=True)

var_info = rp.rx_get_var_info(data_source)

column_names = []
for var in var_info:
    if var != dependent_name and var_info[var]["varType"] != "character":
        column_names.append(var)

formula = get_formula(dependent_name, column_names)
print(formula)

lin_mod = rp.rx_lin_mod(formula, data=data_source)
print(lin_mod)

model_data = rp.rx_serialize_model(lin_mod, realtime_scoring_only=False)

model_data_table = rp.RxSqlServerData(connection_string=connection_string, table = model_table_name)
rp.rx_write_object(dest=model_data_table, key=model_name, value=model_data, key_name="model_name", value_name="model_data")
