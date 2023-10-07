# import library
library(forecast)

# read dataset
data <- read.csv("F:\\APU\\FYP\\Dataset\\Cleaned_data\\hydro_production_dataset.csv")
data$Date <- as.Date(data$Date)

#-------------------US Monthly Data--------------------------
us_hydro_data <- data[data$Country == "United States", ]
us_hydro_data <- us_hydro_data[order(us_hydro_data$Date), ]

# Specify the split date
split_date <- as.Date("2021-01-01")

# Split the data into train and test sets based on the split date
train_data <- subset(us_hydro_data, Date < split_date)
test_data <- subset(us_hydro_data, Date >= split_date)

ts_train <- ts(train_data$Value, start = min(train_data$Date), frequency = 12)
ts_test <- ts(test_data$Value, start = min(test_data$Date), frequency = 12)

us_monthly_model <- auto.arima(ts_train)
print(summary(us_monthly_model))

forecast <- forecast(us_monthly_model, h = length(ts_test))
plot(forecast)

# Evaluate the accuracy of the forecasts
accuracy(forecast, test_data$Value)

#----------- read daily data ---------------
# read dataset
daily_data <- read.csv("F:\\APU\\FYP\\Dataset\\Cleaned_data\\hydro_daily_production_dataset.csv")
daily_data$Date <- as.Date(daily_data$Date)



#-------------------US Daily Data--------------------------
us_daily_hydro_data <- daily_data[daily_data$Country == "United States", ]
us_daily_hydro_data <- us_daily_hydro_data[order(us_daily_hydro_data$Date), ]

# Specify the split date
split_date <- as.Date("2021-01-01")

# Split the data into train and test sets based on the split date
train_data <- subset(us_daily_hydro_data, Date < split_date)
test_data <- subset(us_daily_hydro_data, Date >= split_date)

ts_train <- ts(train_data$Value, start = min(train_data$Date), frequency = 365)
ts_test <- ts(test_data$Value, start = min(test_data$Date), frequency = 365)

us_daily_model <- auto.arima(ts_train)
print(summary(us_daily_model))

forecast <- forecast(us_daily_model, h = length(ts_test))
plot(forecast)

# Evaluate the accuracy of the forecasts
accuracy(forecast, test_data$Value)

# save ARIMA model
saveRDS(us_daily_model, file = "F:\\APU\\FYP\\SEM 2\\Report Doc\\R script\\us_hydro_arima_model.rds")


#-------------------Canada Daily Data--------------------------
can_daily_hydro_data <- daily_data[daily_data$Country == "Canada", ]
can_daily_hydro_data <- can_daily_hydro_data[order(can_daily_hydro_data$Date), ]

# Split the data into train and test sets based on the split date
train_data <- subset(can_daily_hydro_data, Date < split_date)
test_data <- subset(can_daily_hydro_data, Date >= split_date)

ts_train <- ts(train_data$Value, start = min(train_data$Date), frequency = 365)
ts_test <- ts(test_data$Value, start = min(test_data$Date), frequency = 365)

can_daily_model <- auto.arima(ts_train)
print(summary(can_daily_model))

forecast <- forecast(can_daily_model, h = length(ts_test))
plot(forecast)

# Evaluate the accuracy of the forecasts
accuracy(forecast, test_data$Value)

# save canada ARIMA model
saveRDS(can_daily_model, file = "F:\\APU\\FYP\\SEM 2\\Report Doc\\R script\\can_hydro_arima_model.rds")

#-------------------Germany Daily Data--------------------------
ger_daily_hydro_data <- daily_data[daily_data$Country == "Germany", ]
ger_daily_hydro_data <- ger_daily_hydro_data[order(ger_daily_hydro_data$Date), ]

# Split the data into train and test sets based on the split date
train_data <- subset(ger_daily_hydro_data, Date < split_date)
test_data <- subset(ger_daily_hydro_data, Date >= split_date)

ts_train <- ts(train_data$Value, start = min(train_data$Date), frequency = 365)
ts_test <- ts(test_data$Value, start = min(test_data$Date), frequency = 365)

ger_daily_model <- auto.arima(ts_train)
print(summary(ger_daily_model))

forecast <- forecast(ger_daily_model, h = length(ts_test))
plot(forecast)

# Evaluate the accuracy of the forecasts
accuracy(forecast, test_data$Value)

# save ARIMA model
saveRDS(ger_daily_model, file = "F:\\APU\\FYP\\SEM 2\\Report Doc\\R script\\ger_hydro_arima_model.rds")

#-------------------Brazil Daily Data--------------------------
brz_daily_hydro_data <- daily_data[daily_data$Country == "Brazil", ]
brz_daily_hydro_data <- brz_daily_hydro_data[order(brz_daily_hydro_data$Date), ]

# Split the data into train and test sets based on the split date
train_data <- subset(brz_daily_hydro_data, Date < split_date)
test_data <- subset(brz_daily_hydro_data, Date >= split_date)

ts_train <- ts(train_data$Value, start = min(train_data$Date), frequency = 365)
ts_test <- ts(test_data$Value, start = min(test_data$Date), frequency = 365)

brz_daily_model <- auto.arima(ts_train)
print(summary(brz_daily_model))

forecast <- forecast(brz_daily_model, h = length(ts_test))
plot(forecast)

# Evaluate the accuracy of the forecasts
accuracy(forecast, test_data$Value)

# save ARIMA model
saveRDS(brz_daily_model, file = "F:\\APU\\FYP\\SEM 2\\Report Doc\\R script\\brz_hydro_arima_model.rds")


#-------------------China Daily Data--------------------------
chn_daily_hydro_data <- daily_data[daily_data$Country == "People's Republic of China", ]
chn_daily_hydro_data <- chn_daily_hydro_data[order(chn_daily_hydro_data$Date), ]

# Split the data into train and test sets based on the split date
train_data <- subset(chn_daily_hydro_data, Date < split_date)
test_data <- subset(chn_daily_hydro_data, Date >= split_date)

ts_train <- ts(train_data$Value, start = min(train_data$Date), frequency = 365)
ts_test <- ts(test_data$Value, start = min(test_data$Date), frequency = 365)

chn_daily_model <- auto.arima(ts_train)
print(summary(chn_daily_model))

forecast <- forecast(chn_daily_model, h = length(ts_test))
plot(forecast)

# Evaluate the accuracy of the forecasts
accuracy(forecast, test_data$Value)

# save ARIMA model
saveRDS(chn_daily_model, file = "F:\\APU\\FYP\\SEM 2\\Report Doc\\R script\\chn_hydro_arima_model.rds")



#-------------------Auatralia Daily Data--------------------------
aus_daily_hydro_data <- daily_data[daily_data$Country == "Australia", ]
aus_daily_hydro_data <- aus_daily_hydro_data[order(aus_daily_hydro_data$Date), ]

# Split the data into train and test sets based on the split date
train_data <- subset(aus_daily_hydro_data, Date < split_date)
test_data <- subset(aus_daily_hydro_data, Date >= split_date)

ts_train <- ts(train_data$Value, start = min(train_data$Date), frequency = 365)
ts_test <- ts(test_data$Value, start = min(test_data$Date), frequency = 365)

aus_daily_model <- auto.arima(ts_train)
print(summary(aus_daily_model))

forecast <- forecast(aus_daily_model, h = length(ts_test))
plot(forecast)

# Evaluate the accuracy of the forecasts
accuracy(forecast, test_data$Value)

# save ARIMA model
saveRDS(aus_daily_model, file = "F:\\APU\\FYP\\SEM 2\\Report Doc\\R script\\aus_hydro_arima_model.rds")


