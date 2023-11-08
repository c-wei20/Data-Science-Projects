# Time Series Forecasting of Global Renewable Energy Production: A Comparative Analysis and Implementation
This is a Data Analytics project for the final-year study of a Bachelor's Degree in Computer Science with a specialism in Data Analytics.

This project mainly focuses on the development of time series forecasting models and their comparative analysis, followed by the implementation of a forecasting dashboard.

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

**Main Dataset - Monthly Electricity Statistics (Version Updated Until July 2023):**

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

Source: http://weatherforenergydata.iea.org/National%20data/Monthly%20values/CSV

Among those datasets, Precipitation is used for the forecasting of Hydroelectricity Production, Wind Speed datasets are used for the forecasting of Wind Energy Production, and other datasets are used for the forecasting of Solar Energy Production.

## Data Selection
Due to time and workload constraints, this project has selected 3 renewable energy sources and 6 countries to fulfil the project's aim and objectives.

**Renewable Energy Selection:**

This project selected 3 main renewable energy sources that generate electricity, which are **hydro**, **wind**, and **solar** renewable energy. These selected renewable resources generated 91% of renewable electricity in 2021.

**Countries Selection:**

This project selected the following countries as the representation of the "Global" renewable energy trend:
1. The United States
2. Canada
3. Germany
4. Brazil
5. People's Republic of China
6. Australia

The above countries are selected to represent the global based on the following reasons:
- The selected countries accounted for about 60% (58.9%) of the global renewable energy capacity in 2022.
- The selected countries accounted for more than 55% (57.5%) of the global total renewable energy production in 2021.
- These countries are the leading countries in installed renewable energy capacity amongst the countries in their respective region as well as worldwide in 2022.
- Brazil is also one of the top 10 developing countries for international investment in renewable energy from 2015 to 2022.
- The United States, China and Germany are the top 5 countries in renewable energy investment.

**Resources:**
1. IRENA Renewable Energy Statistics 2023: https://mc-cd8320d4-36a1-40ac-83cc-3389-cdn-endpoint.azureedge.net/-/media/Files/IRENA/Agency/Publication/2023/Jul/IRENA_Renewable_energy_statistics_2023.pdf?rev=7b2f44c294b84cad9a27fc24949d2134
2. Statista: https://www.statista.com/statistics/267233/renewable-energy-capacity-worldwide-by-country/
3. World Investment Report 2023: https://unctad.org/publication/world-investment-report-2023
4. Website Resource: https://www.nsenergybusiness.com/features/top-countries-renewable-energy-investment/

## Implementation


## Result & Discussion
Time Series Models Evaluation of Hydro Energy Production:
| Countries         | Model             | MAE    | MSE      | RMSE   |
|-------------------|-------------------|------- |--------- |------- |
| The United States | ARIMA / SARIMA    | 125.85 | 20092.77| 141.74 |
|                   | SVR               | **2.920**  | **13.29**   | **3.64**   |
|                   | ANN               | 6.702  | 70.34   | 8.38   |
|                   | Univariate LSTM   | 4.04   | 27.36   | 5.23   |
|                   | Multivariable LSTM| 3.36   | 40.90   | 6.39   |
| Canada            | ARIMA / SARIMA    | 102.24 | 12317.84| 110.98 |
|                   | SVR               | 2.15   | 7.62    | 2.76   |
|                   | ANN               | 4.45   | 34.47   | 5.87   |
|                   | Univariate LSTM   | **1.80**   | **7.43**    | **2.72**   |
|                   | Multivariable LSTM| 4.16   | 28.27   | 5.31   |
| Germany           | ARIMA / SARIMA    | 7.41   | 85.50   | 9.24   |
|                   | SVR               | 6.32   | 0.04    | 0.22   |
|                   | ANN               | 0.66   | 0.62    | 0.78   |
|                   | Univariate LSTM   | **0.1233** | **0.0478**  | **0.21**   |
|                   | Multivariable LSTM| 0.337  | 0.182   | 0.42   |
| Brazil            | ARIMA / SARIMA    | 312.47 | 132661.41| 364.22 |
|                   | SVR               | **3.67**   | **21.16**   | **4.60**   |
|                   | ANN               | 14.44  | 340.81  | 18.46  |
|                   | Univariate LSTM   | 4.81   | 32.55   | 5.70   |
|                   | Multivariable LSTM| 7.077  | 104.28  | 10.21  |
| China             | ARIMA / SARIMA    | 958.99 | 1280083.76| 1131.40|
|                   | SVR               | 713.65 | 1206.17 | 34.730 |
|                   | ANN               | 115.07 | 16882.53| 129.93 |
|                   | Univariate LSTM   | **23.79**  | **932.43**  | **30.53**  |
|                   | Multivariable LSTM| 38.89  | 2276.14 | 47.70  |
| Australia         | ARIMA / SARIMA    | 6.04   | 53.46   | 7.31   |
|                   | SVR               | 0.15   | **0.04**    | **0.20**   |
|                   | ANN               | 1.5    | 2.66    | 1.6    |
|                   | Univariate LSTM   | **0.13**   | **0.04**    | 0.21   |
|                   | Multivariable LSTM| 0.29   | 0.138   | 0.372  |

Time Series Models Evaluation of Wind Energy Production:
| Countries         | Model             | MAE    | MSE      | RMSE   |
|-------------------|-------------------|------- |--------- |------- |
| The United States | ARIMA / SARIMA    | 217.74 | 67218.49 | 259.26 |
|                   | XGBoost           | 225.58 | 71582.84 | 267.54 |
|                   | SVR               | **6.91**   | 70.99   | 8.42   |
|                   | GRU               | 7.005  | **51.93**   | **7.20**   |
|                   | Univariate LSTM   | 54.28  | 4081.45 | 63.88  |
|                   | Multivariable LSTM| 125.33 | 41920.38| 204.74 |
| Canada            | ARIMA / SARIMA    | 13.95  | 306.62  | 17.51  |
|                   | XGBoost           | 8.94   | 117.19  | 10.82  |
|                   | SVR               | 0.67   | 0.66   | 0.81   |
|                   | GRU               | **0.33**   | **0.15**   | **0.38**   |
|                   | Univariate LSTM   | 1.37   | 2.48   | 1.57   |
|                   | Multivariable LSTM| 0.96   | 2.00   | 1.41   |
| Germany           | ARIMA / SARIMA    | 78.60  | 11826.82| 108.75 |
|                   | XGBoost           | 60.84  | 6144.86 | 78.38  |
|                   | SVR               | 4.01   | 27.30   | 5.22   |
|                   | GRU               | **3.04**   | **10.7**   | **3.27**   |
|                   | Univariate LSTM   | 4.04   | 31.92   | 5.65   |
|                   | Multivariable LSTM| 4.47   | 47.77   | 6.91   |
| Brazil            | ARIMA / SARIMA    | 156.67 | 28600.81| 169.11 |
|                   | XGBoost           | 58.34  | 4436.00 | 66.60  |
|                   | SVR               | 1.96   | 5.36   | 2.31   |
|                   | GRU               | **1.17**   | **1.67**   | **1.29**   |
|                   | Univariate LSTM   | 1.92   | 6.71   | 2.59   |
|                   | Multivariable LSTM| 10.34  | 320.44  | 17.90  |
| China             | ARIMA / SARIMA    | 331.73 | 161638.67| 402.04 |
|                   | XGBoost           | 665.66 | 558968.31| 747.64 |
|                   | SVR               | 19.40  | 599.75  | 24.48  |
|                   | GRU               | **4.18**   | **46.55**   | **6.82**   |
|                   | Univariate LSTM   | 64.67  | 8907.43 | 94.37  |
|                   | Multivariable LSTM| 213.75 | 83769.36| 289.42 |
| Australia         | ARIMA / SARIMA    | 11.08  | 177.69  | 13.33  |
|                   | XGBoost           | 18.16  | 475.81  | 21.81  |
|                   | SVR               | 0.47   | 0.31   | 0.55   |
|                   | GRU               | **0.108**  | **0.022**  | **0.149**  |
|                   | Univariate LSTM   | 1.20   | 2.542  | 1.594  |
|                   | Multivariable LSTM| 5.01   | 82.53  | 9.08   |

Time Series Models Evaluation of Solar Energy Production:
| Countries       | Model             | MAE   | MSE      | RMSE  |
|-----------------|-------------------|-------|--------- |-------|
| The United States | ARIMA / SARIMA  | 57.780| 6215.18  | 78.83 |
|                  | SVR               | 5.81  | 41.06    | 6.40  |
|                  | GRU               | **1.793** | **7.88**    | **2.807** |
|                  | Univariate LSTM  | 141.12| 34267.08 | 185.11|
|                  | Multivariable LSTM| 154.74| 42796.84 | 206.87|
| Canada          | ARIMA / SARIMA  | 2.80  | 10.761  | 3.28  |
|                  | SVR               | 0.19  | 0.077   | 0.279 |
|                  | GRU               | **0.077** | **0.008**   | **0.093** |
|                  | Univariate LSTM  | 2.130 | 13.764  | 3.70  |
|                  | Multivariable LSTM| 1.834 | 6.21   | 2.49  |
| Germany         | ARIMA / SARIMA  | 48.32 | 3236.15 | 56.88 |
|                  | SVR               | 1.34  | 2.79   | 1.67  |
|                  | GRU               | **0.61**  | **0.497**  | **0.705** |
|                  | Univariate LSTM  | 3.183 | 26.94  | 5.19  |
|                  | Multivariable LSTM| 8.285 | 221.23 | 14.87 |
| Brazil          | ARIMA / SARIMA  | 78.37 | 7818.59 | 88.42 |
|                  | SVR               | **0.90**  | **1.321**  | **1.149** |
|                  | ANN               | 1.99  | 9.06   | 3.01  |
|                  | Univariate LSTM  | 14.95 | 462.7  | 21.51 |
|                  | Multivariable LSTM| 28.26 | 1392.884| 37.32 |
| China           | ARIMA / SARIMA  | 163.25| 37118.28| 192.66|
|                  | SVR               | 8.084 | 85.89  | 9.268 |
|                  | GRU               | **4.23**  | **20.15**  | **4.48**  |
|                  | Univariate LSTM  | 19.65 | 509.04 | 22.56 |
|                  | Multivariable LSTM| 180.924| 52261.90| 228.60|
| Australia       | ARIMA / SARIMA  | 45.54 | 2727.24 | 52.223|
|                  | SVR               | 1.98  | 6.08   | 2.46  |
|                  | GRU               | **0.31**  | **0.25**   | **0.501** |
|                  | Univariate LSTM  | 3.43  | 37.17  | 6.09  |
|                  | Multivariable LSTM| 10.40 | 287.17 | 16.94 |

## Deployment - Time Series Dashboard
Sample:

![image](https://github.com/c-wei20/Data-Science-Projects/assets/80091094/427935a7-a30c-4cf3-96d9-f9186bb2fa7d)
![image](https://github.com/c-wei20/Data-Science-Projects/assets/80091094/18fcc06d-4564-4787-a565-918c48c2bbe0)
![image](https://github.com/c-wei20/Data-Science-Projects/assets/80091094/6352b7e1-5cfb-4cd8-8530-c5a34e247d4d)
![image](https://github.com/c-wei20/Data-Science-Projects/assets/80091094/26789d89-913a-41c3-a850-7affcc8add92)
