#Set Working Directory and verify
setwd("D:/Git/R Linear Regression")
getwd()

#Read in CSV data to a dataframe and verify
CAdata = read.csv('CalEstPop2017.csv', header=T, stringsAsFactors = F)
head(CAdata)

#Build Linear Model to predict population and view summary
model = lm(POPULATION ~ YEAR, data=CAdata)
summary(model)

#Create predictions for years 2018-2020
YEAR = 2018:2020
POPULATION = (YEAR * model$coefficients[2]) + model$coefficients[1]
PredictedData = data.frame(YEAR, POPULATION)

#Build Linear Model based on 2020 data and view summary
data2020 = rbind(CAdata, PredictedData)
model2020 = lm(POPULATION ~ YEAR, data=data2020)
summary(model2020)
data2020

#Plot a model for 2020
options(scipen=5)
plot(data2020$YEAR, data2020$POPULATION, main="California Population Predictions 2020", xlab="Year", ylab="Population")
abline(model2020)

#Create predictions for years 2021-2023
YEAR = 2021:2023
POPULATION = (YEAR * model2020$coefficients[2]) + model2020$coefficients[1]
PredictedData = data.frame(YEAR, POPULATION)

#Create finalized dataframe and plot the predicted data with a linear regression line
FinalData = rbind(data2020, PredictedData)
plot(FinalData$YEAR, FinalData$POPULATION, main="California Population Predictions 2023", xlab="Year", ylab="Population")
abline(model2020)
