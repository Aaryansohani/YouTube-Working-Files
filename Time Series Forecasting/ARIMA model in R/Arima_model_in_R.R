#Import Libraries
library(forecast)
library(tseries)

#Change working Directory
setwd("C:\\Users\\DELL\\Documents\\__Fun_X_Excel_Channel_Videos\\Arima\\R")

#Import Sales Dataset
sales <- read.csv("sales.csv")

#Convert sales_k column to Time Series object 
sales_ts <- ts(sales$Sales_k,start=c(1972),frequency=12)

#Plot Sales Time series using autoplot (forecast library)
autoplot(sales_ts)

#Stationarity : A stationary process has a mean and variance 
#               that do not change overtime and the process does not have trend.

#Perform ADF Test
#Null Hypothesis - Non Stationary 
#               (Do NOT Reject if P value > sig lvl (1%, 5%, 10%) )
adf.test(sales_ts)

#Null Hypothesis not Rejected - Series is Non Stationary

#We will use first order difference to make it Stationary
sales_ts_d1 <- diff(sales_ts, differences = 1)
adf.test(sales_ts_d1)

#Since P is very small and less than sig lvl - 
#                 we accept alternate hypothesis

#ARIMA (p,d,q)

#q term will remain 0 

#Run ACF test to select AR term or the p term - correlation between lags
Acf(sales_ts)
Acf(sales_ts_d1)

#Run PACF test to select MA term or the q term - 
Pacf(sales_ts) 
Pacf(sales_ts_d1) 

#BASIC ARIMA - does not work that good
tsMod <- Arima(y = sales_ts,order = c(6,1,6))

#Summary of the model
tsMod

#Forecast 12 periods ahead
forecast(tsMod,h=12)

#Plot Sales with forecast 
autoplot(forecast(tsMod,h=12))

#LJung test for serial correlation on Residuals 
#Null Hypothesis : No Serial correlation up to a certain lag
#Reject NUll Hypothesis if p-value less than significant level(0.05)
Box.test(autoARMIA$residuals, type = 'Ljung-Box')


