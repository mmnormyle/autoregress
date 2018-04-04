# AutoRegress

AutoRegress is a SQL Server tool to create linear regression models.
The data will not leave the SQL Machine and the models can be trained in a single line of code!

# installation

First, install SQL Server Machine Learning Services: https://docs.microsoft.com/en-us/sql/advanced-analytics/install/sql-machine-learning-services-windows-install <br>
Then run the AutoRegress.sql and AutoRegressPredict.sql T-SQL queries. These queries create the AutoRegress and AutoRegressPredict stored procedures on your machine. <br>

The AutoRegress stored procedure is for easy training of linear regression models on data. <br>
The AutoRegressPredict stored procedures allows you to easily make predictions based on your train models. <br>

# usage

Once you've installed the stored procedures, you'll need some data to work with.

