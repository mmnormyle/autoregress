# AutoRegress

AutoRegress is a SQL Server tool to create linear regression models.
The data will not leave the SQL Machine and the models can be trained in a single line of code!

# Getting started

Let's work through a simple example first. We're going to train a linear regression model on some (fake) student test score data. <br>

1. First, restore the AutoRegressTestDB from the .bak file in this repo. You can do this in SSMS by right clicking Databases and clicking restore database.
2. Next, install the stored procedures in the AutoRegressTestDB database. Simply run the above AutoRegress.sql and AutoRegressPredict.sql queries against the AutoRegressTestDB database.
3. To perform the linear regression, just run the below query:

```
-- Trains a linear regression model on the data in the StudentGradesTrainingData table inside AutoRegressTestDB.
-- The dependent variable is specified as FinalExamGrade.

declare @database_name varchar(MAX) = 'AutoRegressTestDB'
declare @table_name varchar(MAX) = 'StudentGradesTrainingData'
declare @dependent_name varchar(MAX) = 'FinalExamGrade'
declare @model_table_name varchar(MAX) = 'StudentGradesModels'
declare @model_name varchar(MAX) = 'linear_model_1'
```

exec AutoRegress @database_name, @table_name, @dependent_name, @model_table_name, @model_name

4. The model you just trained in stored in StudentGradesModels, you can some information about it with the query:

select * from StudentGradesModels where model_name = 'linear_model_1'

5. Now, let's use the model we just trained to predict on our test set. Simply run the following query:

```
declare @database_name varchar(MAX) = 'AutoRegressTestDB'
declare @test_data_table varchar(MAX) = 'StudentGradesTestData'
declare @model_table_name varchar(MAX) = 'StudentGradesModels'
declare @model_name varchar(MAX) = 'linear_model_1'
declare @prediction_table_name varchar(MAX) = 'PredictionsTable'

exec AutoRegressPredict @database_name, @model_table_name, @model_name, @test_data_table, @prediction_table_name
```

6. You can view your prediction results against the actual results with the following query:

select StudentGradesTestData.HoursStudying, StudentGradesTestData.PreviousTestScore, StudentGradesTestData.HomeworkAverage, StudentGradesTestData.FinalExamGrade, PredictionsTable.FinalExamGrade_Pred
from StudentGradesTestData 
INNER JOIN PredictionsTable ON StudentGradesTestData.HomeworkAverage=PredictionsTable.HomeworkAverage;
