# bike sharing demand kaggle competition

library(ggplot2)
library(ggthemes)
library(dplyr)

# EDA
bike <- read.csv('bikeshare.csv')
head(bike)

# check the target we are trying to predict
# the total count of bikes rented during each hour covered by the test set

scatter.pl <- ggplot(bike, aes(x = temp, y = count)) + geom_point(alpha = 0.3, size = 4, aes(color = temp)) + theme_bw()

print(scatter.pl)

# CONVERT TO TIMESTAMP
bike$datetime <- as.POSIXct(bike$datetime, format = "%Y-%m-%d %H:%M:%S")

pl2 <- ggplot(bike, aes(x = datetime, y = count)) + geom_point(aes(color = temp))
print(pl2 + scale_color_continuous(low = 'red', high = 'blue') + theme_bw())

# noticed the data is non-linear -> linear regression model may not be the best
# PROS:
# Simple to explain
# Highly interpretable
# Model training and prediction are fast
# No tuning is required (excluding regularization)
# Features don't need scaling
# Can perform well with a small number of observations
# Well-understood

# CONS:
# Assumes a linear relationship between the features and the response
# Performance is (generally) not competitive with the best supervised learning methods due to high bias/simplicity
# Can't automatically learn feature interactions

# correlation between temp and count
print(cor(bike[ , c('temp', 'count')])) # 0.4

box.pl <- ggplot(bike, aes(factor(season), count)) + geom_boxplot(aes(fill = factor(season))) + theme_bw()
print(box.pl) 

# soo, a line cannot capture a non-linear relationship
# and there are more rentals in winter than in spring
# bcs of the growth of rental count, this isn't due to the actual season


# FEATURE ENGINEERING - create a new column that takes the 'hour' from the datetime column
bike$hour <- format(bike$datetime, format = '%H') # using the format function directly

# or use sapply() for more flexibility, in case of a more complex function applied to each element
# bike$hour <- sapply(bike$datetime, function(x){format(x,"%H")})

#print(head(bike))


# SCATTERPLOT
bike.working.day <- subset(bike, workingday == 1)
scatter.plot1 <- ggplot(bike.working.day, aes(x = hour, y = count)) + geom_point(aes(color = temp), position = position_jitter(w = 1, h = 0), alpha = 0.5) + scale_color_gradientn(colors = c('yellow', 'green', 'blue'))

# OR USING DYPLR 
# scatter.plot1 <- ggplot(filter(bike, workingday == 1), aes(hour,count)) 

# there's empty space between the hours -> USE JITTER() to fill it in by setting the data points off of their original data points
# we added jitter along the x axis: w (width) = 1, h = height

print(scatter.plot1 + theme_bw())

bike.nonworking.day <- subset(bike, workingday == 0)
scatter.plot2 <- ggplot(bike.nonworking.day, aes(x = hour, y = count)) + geom_point(aes(color = temp), position = position_jitter(w = 1, h = 0), alpha = 0.5) + scale_color_gradientn(colors = c('yellow', 'green', 'blue'))
print(scatter.plot2 + theme_bw())


# BUILD MODEL
# predict count based solely on the temp feature
# WE DON'T SPLIT THE DATA BCS OF THE GROWING TREND AND THE SEASONALITY OF THE DATA -> LR MODEL IS NOT HELPFUL HERE
# and bcs it's a time series version of data -> no sense to randomly select sections of data
# AND WE WANT TO PREDICT FUTURE TRENDS -> OTHER METHODS, NOT LIN. REG.

temp.model <- lm(formula = count ~ temp, data = bike)
print(summary(temp.model))


# the intercept = the predicted value of the dependent variable (response) when all independent variables are set to zero
# the intercept = the starting point of the prediction when all variables are zero, THE Y VALUE WHEN X = 0 - ESTIMATED RENTALS WHEN TEMP = 0
# coefficient for temp = the impact of one-unit change in the temp on the predicted outcome
# COEFFICIENT FOR TEMP = THE CHANGE IN Y / CHANGE IN X OR THE SLOPE
# β1 would be negative if an increase in temperature was associated with a decrease in rentals

# result: the model predicts 6.0462 bike rentals when the temperature is zero, and for each one-degree increase in temperature, the predicted number of bike rentals increases by 9.17

 
# how many rentals would we predict if the temperature was 25 degrees C
temperature <- 25
summary.result <- summary(temp.model)

# extracting the intercept and coefficient for 'temp'
intercept <- summary.result$coefficients['(Intercept)', 'Estimate']
temp.coefficient <- summary.result$coefficients['temp', 'Estimate']

predicted.rentals <- intercept + temp.coefficient * temperature

print(predicted.rentals) # got 235.3097 bikes

# predicting using predict() function
temp.test <- data.frame(temp = 25) # create a bike with a single observation
predicted.rentals <- predict(temp.model, temp.test)

print(predicted.rentals) # 235.3097

# using sapply and as.numeric to convert 'hour' to numeric
bike$hour <- sapply(bike$hour, as.numeric)
print(head(bike))


model <- lm(count ~ . - casual - registered - datetime - atemp , data = bike) # use all features except for '-' columns substracted
print(summary(model))

# model performance:
# this model won't take into account the seasonality of out data
# and it will get thrown off by the growth in our data set, accidentally
# attributing it towards the winter season instead of realising it's just overall demand growing



# TRAIN/TEST SPLIT
# not random split - 'future' data for test and 'previous' data for train

bike$datetime <- as.Date(bike$datetime) # convert to date format
bike <- bike[order(bike$datetime), ] # sort the df based on datetime column
split.date <- as.Date("2012-07-01")

train.data <- subset(bike, datetime < split.date)
test.data <- subset(bike, datetime >= split.date)

model <- lm(count ~ . - casual - registered - datetime - atemp, data = train.data)

# PREDICTIONS
bike.predictions <- predict(model, test.data)

# create a df for each of the test data points
results <- cbind(bike.predictions, test.data$count)
colnames(results) <- c('predicted', 'actual')

results <- as.data.frame(results)
print(results)

print('MSE: ')
mse <- mean((results$actual - results$predicted)^2)
print(mse) # high, which means low performance

print('Squared Root of MSE: ')
print(sqrt(mse)) # diff between predicted and actual counts ~ 198

SSE <- sum((results$predicted - results$actual)^2)
SST <- sum((mean(bike$count) - results$actual)^2)

R2 <- 1 - SSE/SST
print('R2')
print(R2) # 0.2426 => 24.26% of the variability in the actual counts is explained by the model
# low R-squared suggests that the model does not capture a significant portion of the variation in the data
