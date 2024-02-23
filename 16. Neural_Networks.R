# reinforcement learning 
# stepping stone to understanding deep learning - nn with many hidden layers 

## USE CASES
# pattern recognition
# time series predictions
# signal processing
# anomaly detection
# control

# attempt to solve problems that would be easy for humans but hard for computers

#install.packages('MASS')

library(MASS) # fo the Boston dataset

#print(head(Boston)) # fetures of houses

#print(str(Boston)) # 14 features/variables: the last one -- we're trying to predict

#print(any(is.na(Boston)))

data <- Boston

##### PREPROCESS OUR DATA:
## NORMALIZE OUR DATA
maxs <- apply(data, MARGIN = 2, max) # apply max function to the second column in the data
#print(maxs)

mins <- apply(data, 2, min)
#print(mins)

# use mins and maxs values to scale/normalize the data
scaled.data <- scale(data, center = mins, scale = maxs - mins) 
# each single data point in the column will have the minimum value substracted from it
# then divide it by the scale 
# this is a matrix

scaled <- as.data.frame(scaled.data)
#print(scaled)

library(caTools)

split <- sample.split(scaled$medv, SplitRatio = 0.7)
train <- subset(scaled, split == T)
test <- subset(scaled, split == F)

#install.packages('neuralnet')

library(neuralnet)
# for the nn function we cannot use the dot notation -> we have to poss in the columns, not like that y ~ .
n <- names(train)
#print(n) # the columns names

### automatically join the column names together into a formula
# grab every single column name, pasting it together with a + in between
# and we're going to paste this as long as it'n not in the medv
f <- as.formula(paste("medv ~", paste(n[!n %in% "medv"], collapse = " + ")))


## TRAIN THE MODEL

# hidden specifies the number of hidden neurons in each layer as a vector of integers
nn <- neuralnet(f, data = train, hidden = c(5, 3), linear.output = TRUE) # first layer of 5 hidden neurons, 2nd of 3
# what would be the reasonable value to choose here?

# linear.output = T because we're not performing classification 

plot(nn)

# black lines show the connection between each layer and the weights on this connection
# blue lines show the bias term added in each step -- thought almost as the intercept of a linear model

# the net here is essentially a black box -> we can't say much about the fitting, the weights or the model
# but we can say that the algorithm converged 

# CREATE PREDICTIONS with the model

predicted.nn.values <- compute(nn, test[1:13]) # pass in the values without the labels and use compute instead of predict as in the other models
print(str(predicted.nn.values))

# to get the true predictions, we have to undo the scaling/normalization
true.predictions <- predicted.nn.values$net.result * (max(data$medv) - min(data$medv)) + min(data$medv)

# convert the test data
test.r <- (test$medv) * (max(data$medv) - min(data$medv)) + min(data$medv)

# the mean squared error
MSE.nn <- sum((test.r - true.predictions) ^ 2)/nrow(test)

# the true prediction = the non scaled predictions

print(MSE.nn) # 13.15869

error.df <- data.frame(test.r, true.predictions)
print(head(error.df))

library(ggplot2)

pl <- ggplot(error.df, aes(x=test.r, y=true.predictions)) + geom_point() + stat_smooth()
print(pl)


