-- Train a model that predicts FinalExamGrade column in StudentGradesTrainingData (based on values in other columns)
-- Serialize that model and save it in StudnetGradesModels table

declare @database_name varchar(MAX) = 'AutoRegressTestDB'
declare @table_name varchar(MAX) = 'StudentGradesTrainingData'
declare @dependent_name varchar(MAX) = 'FinalExamGrade'
declare @model_table_name varchar(MAX) = 'StudentGradesModels'
declare @model_name varchar(MAX) = 'linear_model_1'

exec AutoRegress @database_name, @table_name, @dependent_name, @model_table_name, @model_name



-- Predict FinalExamGrade on test data stored in StudentGradesTestData using the model we just trained

declare @database_name varchar(MAX) = 'AutoRegressTestDB'
declare @test_data_table varchar(MAX) = 'StudentGradesTestData'
declare @model_table_name varchar(MAX) = 'StudentGradesModels'
declare @model_name varchar(MAX) = 'linear_model_1'
declare @prediction_table_name varchar(MAX) = 'PredictionsTable'

exec AutoRegressPredict @database_name, @model_table_name, @model_name, @test_data_table, @prediction_table_name


-- View predictions versus actual values
-- (the predictions are quite good because this data is fake :) 

select StudentGradesTestData.HoursStudying, StudentGradesTestData.PreviousTestScore, StudentGradesTestData.HomeworkAverage, StudentGradesTestData.FinalExamGrade, PredictionsTable.FinalExamGrade_Pred
from StudentGradesTestData 
INNER JOIN PredictionsTable ON StudentGradesTestData.HomeworkAverage=PredictionsTable.HomeworkAverage;