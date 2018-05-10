exec sp_execute_external_script
@language = N'Python',
@script = N'
print("hello world!")
'




exec sp_execute_external_script
@language = N'Python',
@script = N'
print(input_df)
',
@input_data_1 = N'select * from StudentGradesTrainingData',
@input_data_1_name = N'input_df'




insert into TestTable 
exec sp_execute_external_script
@language = N'Python',
@script = N'
import numpy as np
import pandas as pd

output_df = pd.DataFrame()
output_df["Height"] = [70, 60, 50, 40, 30]
output_df["Weight"] = [140, 160, 180, 90, 140]
output_df["Age"] = [26, 27, 29, 30, 31]
',
@output_data_1_name = N'output_df'


