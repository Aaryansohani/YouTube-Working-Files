ARIMA Model In R
========================================================
author: Kunaal Naik
date: 
width: 1500
font-family: 'Arial'
transition: rotate


========================================================
![Sample](ARIMA_MODEL_IN_R_Intro.jpg)


========================================================
![Sample](ARIMA_MODEL_IN_R_Objective.jpg)

Links
========================================================

YouTube Channel - [www.youtube.com/fxexcel](http://www.youtube.com/fxexcel) 

Download Code and Data - [https://github.com/FunXExcel/YouTube-Working-Files](https://github.com/FunXExcel/YouTube-Working-Files)

Import Libraries
========================================================


```r
library(forecast)
library(tseries)
library(ggplot2)
```

Change Working Directory
========================================================

Change the Directory to the location of the dataset


```r
setwd("C:\\Users\\DELL\\Documents\\__Fun_X_Excel_Channel_Videos\\Arima\\R")
```

Read Sales Dataset
========================================================


```r
sales <- read.csv("sales.csv")
```
![Sample](Sales.png)

ARIMA Model in R Process
========================================================
![Sample](ARIMA_MODEL_IN R_Process.jpg)

ARIMA Model in R Process
========================================================
![Sample](ARIMA_MODEL_IN R_Process1.jpg)

Change Sales trend to Time Series
========================================================

The series is monthly. Hence, we use frequency as 12


```r
sales_ts <- ts(sales$Sales_k,start=c(1972),frequency=12)
```

Plot Sales Time series
========================================================

We will use autoplot (forecast library)


```r
autoplot(sales_ts)
```

![plot of chunk unnamed-chunk-5](ARIMA_model_in_R_Presentation-figure/unnamed-chunk-5-1.png)

Check Stationarity
========================================================

**Stationarity** : A stationary process has a mean and variance that do not change overtime and the process does not have trend.

![Sample](Stationary.png)

Perform ADF Test
========================================================

~~Null Hypothesis - Non Stationary (Do **NOT** Reject if p value > significance level {1%} )~~

Since p is not greater significance level, the Series is **NON Stationary**


```r
adf.test(sales_ts, k = 12)
```

```

	Augmented Dickey-Fuller Test

data:  sales_ts
Dickey-Fuller = -2.3266, Lag order = 12, p-value = 0.4402
alternative hypothesis: stationary
```

Perform ADF Test on First Difference
========================================================

First Level Difference is **NON Stationary**


```r
sales_ts_d1 <- diff(sales_ts, differences = 1)
adf.test(sales_ts_d1, k = 12)
```

```

	Augmented Dickey-Fuller Test

data:  sales_ts_d1
Dickey-Fuller = -2.7588, Lag order = 12, p-value = 0.2601
alternative hypothesis: stationary
```

Perform ADF Test on Second Difference
========================================================

Since p is less than significance level, the second difference is **Stationary**

The d term in the ARIMA(p,d,q) will be **d = 2**


```r
sales_ts_d2 <- diff(sales_ts, differences = 2)
adf.test(sales_ts_d2, k = 12)
```

```

	Augmented Dickey-Fuller Test

data:  sales_ts_d2
Dickey-Fuller = -8.3478, Lag order = 12, p-value = 0.01
alternative hypothesis: stationary
```


Plot Stationary Series (d = 2)
========================================================

```r
autoplot(sales_ts_d2) 
```

![plot of chunk unnamed-chunk-9](ARIMA_model_in_R_Presentation-figure/unnamed-chunk-9-1.png)

Choosing p (AR or Lag) term with ACF Plot
========================================================

With the ACF plot we find that **p = 6**


```r
Acf(sales_ts_d2)
```

![plot of chunk unnamed-chunk-10](ARIMA_model_in_R_Presentation-figure/unnamed-chunk-10-1.png)

Chossing q (MA or Moving Average) term with PACF Plot
========================================================

With the PACF plot we find that **q = 5**


```r
Pacf(sales_ts_d2) 
```

![plot of chunk unnamed-chunk-11](ARIMA_model_in_R_Presentation-figure/unnamed-chunk-11-1.png)

Fitting ARIMA(6,2,5)
========================================================


```r
tsMod <- Arima(y = sales_ts,order = c(6,2,5))
```

Model Summary
========================================================


```r
print(tsMod)
```

```
Series: sales_ts 
ARIMA(6,2,5) 

Coefficients:
         ar1      ar2      ar3     ar4      ar5      ar6      ma1      ma2
      0.3639  -0.1160  -0.3512  0.6481  -0.7157  -0.2353  -0.9882  -0.0037
s.e.  0.0797   0.0614   0.0334  0.0332   0.0602   0.0804      NaN   0.1576
          ma3      ma4     ma5
      -0.0181  -0.9799  0.9929
s.e.   0.1764   0.1496  0.1341

sigma^2 estimated as 267.5:  log likelihood=-656.2
AIC=1336.4   AICc=1338.62   BIC=1372.85
```

Forecast 12 periods ahead (1985)
========================================================


```r
forecast(tsMod,h=12)
```

```
         Point Forecast    Lo 80     Hi 80    Lo 95     Hi 95
Jan 1985       852.8065 831.5837  874.0293 820.3490  885.2640
Feb 1985       904.7881 868.5908  940.9853 849.4291  960.1470
Mar 1985       927.9997 880.9973  975.0021 856.1158  999.8836
Apr 1985       962.3522 910.5591 1014.1454 883.1415 1041.5630
May 1985       980.8371 928.2491 1033.4252 900.4107 1061.2636
Jun 1985       968.9315 916.1409 1021.7220 888.1953 1049.6677
Jul 1985       918.1213 863.0798  973.1628 833.9426 1002.3000
Aug 1985       890.2583 831.2867  949.2300 800.0690  980.4477
Sep 1985       874.4437 812.3327  936.5547 779.4531  969.4343
Oct 1985       863.0507 799.7424  926.3590 766.2291  959.8724
Nov 1985       844.0804 780.7388  907.4219 747.2079  940.9529
Dec 1985       867.4761 803.6643  931.2879 769.8844  965.0678
```

ARIMA Model in R Process
========================================================
![Sample](ARIMA_MODEL_IN R_Final.jpg)

Plot the Final Series with Forecast
========================================================


```r
autoplot(forecast(tsMod,h=12))
```

![plot of chunk unnamed-chunk-15](ARIMA_model_in_R_Presentation-figure/unnamed-chunk-15-1.png)

