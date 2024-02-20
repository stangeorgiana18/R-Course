# categorical features don't work well with this model
# not good with high dimensional data - hard to measure distances in various dimensions

#######
####### predict if sb will purchase the insurance policy or not
#######


# GET THE DATA

#install.packages('ISLR')

library(ISLR)

#print(str(Caravan))
#print(summary(Caravan$Purchase)) # only 6% purchased the insurance

#print(any(is.na(Caravan))) # F

# STANDARDIZE THE VARIABLES 
# bcs the KNN classifier predicts the class of a given test observation by identifying
# the obs that are nearest to it, the scale of the variables really matters

# variables on a large scale will have a much larger effect on the distance between observations

# check the variance of columns
print(var(Caravan[, 1])) # 165.03
print(var(Caravan[, 2])) # 0.164

# standardize the variables except for the purchase var bcs it is an actual label we want to predict
# the purchase column is the last one and we'll save it as a separate var bcs the KNN function will need as a separate argument

purchase <- Caravan[, 86]
# 
standardized.Caravan <- scale(Caravan[, -86])
#
#print(var(standardized.Caravan[, 1])) # 1
#print(var(standardized.Caravan[, 2])) # 1

# TRAIN TEST SPLIT
test.index <- 1:1000
test.data <- standardized.Caravan[test.index, ]
test.purchase <- purchase[test.index]

# Train
train.data <- standardized.Caravan[-test.index, ] # grab anything that's not in test.index
train.purchase <- purchase[-test.index]

###################
###################
###################
# KNN MODEL
###################

library(class) # this contains the knn function

set.seed(101)

# pass in the train. test data and the training labels  
predicted.purchase <- knn(train.data, test.data, train.purchase, k = 5) # predict the purchase for the test.data

print(head(predicted.purchase))

# evaluate the model 
misClass.error <- mean(test.purchase != predicted.purchase)

print(misClass.error) # 0.116 for k = 1 --> 11.6% - relatively high 


#######
#### CHOOSING A K VALUE
#######

predicted.purchase <- NULL # this is going to be the vector of predicted purchases eventually
error.rate <- NULL # a vector of all the error rates

for (i in 1:20){
  set.seed(101)
  predicted.purchase <- knn(train.data, test.data, train.purchase, k = i)
  error.rate[i] <- mean(test.purchase != predicted.purchase)
}

#print(error.rate)

########
## VISUALIZE K ELBOW METHOD
########

library(ggplot2)
k.values <- 1:20
error.df <- data.frame(error.rate, k.values)

#print(error.df) # the error rate and the k value associated with it 

# added a connecting dotted red line in the scatterplot as well
pl <- ggplot(error.df, aes(k.values, error.rate)) + geom_point() + geom_line(lty = 'dotted', color = 'red')
print(pl)
# noticed that increasing k will drop your error rates/misclassification rate
# up to value 9 only and that's where the elbow is








