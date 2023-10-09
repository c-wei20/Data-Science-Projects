# Time Series Forecasting of Global Renewable Energy Production: A Comparative Analysis and Implementation
This is a Data Analytics final-year project for the study Bachelor's Degree in Computer Science with a specialism in Data Analytics.

This project mainly focuses on the development of time series forecasting models and their comparative analysis， followed by the implementation of a forecasting dashboard.

This project contributed to resolve the following problems with its aim and objectives:
## Problem Statements
1. Lack of an accurate and consistent decarbonization tracking system.
2. Current sources of information are time-consuming and not user-friendly for the stakeholders to understand the analysis.
3. Current existing methods for predicting renewable energy production are time-consuming and complex.
4. Lack of comprehensive studies comparing the effectiveness of different time series forecasting models to forecast different renewable energy source production.

## Aim
To evaluate different time series forecasting models and techniques to determine the most accurate and efficient approach to forecast renewable energy production and develop a web-based global renewable energy dashboard.

## Objectives
1. To evaluate the performance of various time series forecasting models and techniques.
2. To evaluate whether the weather-related time series data can improve the performance of the time series forecasting model.
3. To evaluate whether the correlation between the features and target variable can affect the performance of the multivariate time series model.
4. To determine the most efficient time series forecasting approach for renewable energy production forecasting.
5. To develop a web-based dashboard for visualizing and exploring renewable energy production data of different technologies and countries in a single platform.
6. To track the decarbonization progress of different countries and regions in the upcoming years.
7. To determine the most promising renewable energy technology in transforming the global or regional energy mix.

## Dataset
The datasets used in this project include 8 different free datasets from the International Energy Agency (IEA) official website. Among those datasets, one dataset is the main dataset, the **Monthly Electricity Statistics dataset** and another **7 datasets are monthly weather-related datasets for renewable energy**.

**Main Dataset:**

Monthly Electricity Statistics (Updated July 2023)
- A collection of data related to the monthly statistical electricity production which also includes renewable energy production such as hydropower, wind, solar, and geothermal energy from the member countries of the Organisation for Economic Co-operation and Development (OECD) and their key partner countries since the latest year of 2010 to March 2023. 
- A total of 131200 records and 6 variables, of which 5 are qualitative variables and only one quantitative variable
- Source: https://www.iea.org/data-and-statistics/data-product/monthlyelectricity-statistics

**Monthly Weather-Related Datasets:**

All the datasets have a total of 127971 records and 5 variables.
Including:
1. Monthly Precipitation
2. Monthly 10m Wind Speed
3. Monthly 100m Wind Speed
4. Monthly Daylight
5. Monthly Temperature
6. Monthly Global Horizontal Irradiance (GHI)
7. Monthly Direct Normal Radiation (DNI)

Source: http://weatherforenergydata.iea.org/National%20data/Monthly%20values/CSV/

Among those datasets, Precipitation is used for the forecasting of Hydroelectricity Production, Wind Speed datasets are used for the forecasting of Wind Energy Production, and other datasets are used for the forecasting of Solar Energy Production.


