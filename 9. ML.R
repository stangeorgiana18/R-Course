# statistical learning - mathematical term for machine learning 

# supervised, unsupervised, reinforcement learning 
# linear models -- relatively simple and interepretable inference, but may not yield as accurate predictions
# in contrast, some of the highly non-linear approaches -- potentially quite accurate predictions for Y -> less interpretable model for which inference is more challenging
# interested in inference -- restrictive models more interpretable


# LINEAR REGRESSION WITH R

# Get our Data - student performance dataset
# Exploratory Data Analysis (EDA)
# Clean our Data
# Review of Model Form
# Train and Test Groups
# Linear Regression Model

df <- read.csv('student-mat.csv', sep = ';')
#head(df)

# predict final grades

#summary(df)

# check for na values in the df
#print(any(is.na(df))) # F

# make sure our categorical var have a factor set to them
# str(df)
# 0 is the lowest level of education, 4 is the highest (Medu, Fedu)

# explore the data with ggplot2
library(ggplot2)
library(ggthemes)
library(dplyr)
library(corrgram)
library(corrplot)

# create a plot to understand the correlations between each of the features 

# grab num only columns 
num.cols <- sapply(df, is.numeric)

# filter for correlation
cor.data <- cor(df[ , num.cols])

#print(cor.data) # notice a diagonal of 1 -- each feature correlated with itself

# plot out correlation diagrams
# install.packages('corrgram') -- df passed in direclty but more arguments to specify how the plot to look like
# install.packages('corrplot') -- uses num columns

print(corrplot(cor.data, method = 'color'))

print(corrgram(df))

# order -- PCA principal components analysis
print(corrgram(df, order=TRUE, lower.panel = panel.shade,
         upper.panel = panel.pie, text.panel = panel.txt))
# blue - positive correlation
# red - negative corr

pl <- ggplot(df, aes(x = G3)) + geom_histogram(bins = 20, alpha = 0.5, fill = 'blue')

print(pl)


# SPLIT THE DATA INTO TRAIN AND TEST SET
# install.packages('caTools')

library(caTools)

# Set A Seed
set.seed(101) 

# Split up the Sample
sample <- sample.split(df$G3, SplitRatio = 0.7) # pass in the column we want to predict - the final grade; or pass in any other column 
# SplitRatio = the actual ratio of data equal to true

# 70% of data -> train
train <- subset(df, sample == TRUE)
# 30% of data -> test
test <- subset(df, sample == FALSE)

# Run Model

# The general model of building a linear regression model in R
# model <- lm(y ~ x1 + x2, data)
# or to use all the features in your data
# model <- lm(y ~. , data)

# TRAIN AND BUILD MODEL
model <- lm(G3 ~ . , train) # use all the features - .


# Interpret the Model
print(summary(model))

# residuals = the diff between the actual values of the var you're predicting and the 
# predicted values of your regression/ diff between the actual data points and the regression line
# You want your residuals to look like a normal distribution when plotted

# if data not normalised, coefficients are difficult to compare to one another
# std. error - the variability in the estimate of the coefficient; lower means better
# std. error should be at least an order of magnitude less than the coefficient estimate

# t value scores whether or not the coefficient for the variable os meaningful for the model
# it's used to calculate the p-value and the significance level

# Pr(>|t|) -- probability that the value is not relevant; should be as small as possible

# P-value - the var easy to interpret right out of the bat 
# stars = shorthand for significance levels of the number of * displayed according to the p-value computed
# the more stars, the higher the significance
# one star / period - lower significance

# low probability of not being relevant - ***

# R-squared - evaluate the goodness of fit for your model
# higher, the better; 1 is best - corresponds to the amount of variability in what you're predicting 

# correlation does not imply causation


# GRAB THE RESIDUALS OF THE MODEL
res <- residuals(model)
print(class(res)) # numeric

res <- as.data.frame(res)
print(head(res))


hist <- ggplot(res, aes(res)) + geom_histogram(fill = 'blue', alpha = 0.5)
print(hist)

# RESIDUALS SHOULD BE NORMALLY DISTRIBUTED -> DARTBOARD ANALOGY
# we want a normal distribution when plotted out -> the mean of the diff
# between our predictions and the actual values is close to 0 -> when we miss, we miss
# both the short and long of the actual value
# The likelihood of a miss being far from the actual value gets smaller as the distance 
# from the actual value gets larger


#plot(model) # TO SEE 4 advanced PLOTS


# PREDICTIONS
G3.predictions <- predict(model, test) # pass in the model you created and the testing set

# crate a df for each of the test data points
# numbers not in numerical order bcs this was a random grab of the df
results <- cbind(G3.predictions, test$G3)
colnames(results) <- c('predicted', 'actual')
results <- as.data.frame(results)
print(results)


# TAKE CARE OF NEGATIVE VALUES
# when we plotted out the residual values, there was a large amount of larger negative values
# bcs the model predicted negative final score test values/negative final period values
# now we take care of the negative predictions; the lowest value we can get is 0
to_zero <- function(x){
  if (x < 0){
    return (0)
  }else{
    return(x)
  }
}

# APPLY ZERO FUNCTION
results$predicted <- sapply(results$predicted, to_zero)
print('MSE: ')
## MEAN SQUARED ERROR - how off we are from the actual scores
mse <- mean( (results$actual - results$predicted) ^ 2)
print(mse)

# root mean squared error
# RMSE
print('Squared Root of MSE: ')
print(mse^0.5)

###########
# how well the model fits the predicted values
SSE <- sum((results$predicted - results$actual) ^2)
SST <- sum((mean(df$G3) - results$actual) ^ 2) # sum of squared total

R2 <-  1 - SSE/SST
print('R2')
print(R2) # got 80% variance on the test data



