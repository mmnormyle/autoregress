# autoregress

autoregress is a SQL Server tool to create linear regression models.
The data will not leave the SQL Machine and the models can be trained in a single line of code!

# installation

First, install SQL Server Machine Learning Services: https://docs.microsoft.com/en-us/sql/advanced-analytics/install/sql-machine-learning-services-windows-install 
Then run the AutoRegress.sql and AutoRegressPredict.sql T-SQL queries. These queries create the AutoRegress and AutoRegressPredict stored procedures on your machine.

The AutoRegress stored procedure is for easy training of linear regression models on data.
The AutoRegressPredict stored procedures allows you to easily make predictions based on your train models.

# usage

Once you've installed the stored procedures, you'll need some data to work with.

