library(ISLR)

#print(head(iris))
#print(str(iris))


# SCALE THE DATA 

#print(var(iris[, 1])) # 0.68
#print(var(iris[, 2])) # 0.18

# in this case, the iris data set has all its features in the same order of magnitude, 
# but its good practice (especially with KNN) to standardize features in your data
stand.features <- scale(iris[1:4]) # columns 1-4

#print(var(stand.features[, 1])) # 1
#print(var(stand.features[, 2])) # 1

# join the standardized data with the response target / label column 
# take the scaled version of my data and join it back with the original label
# bcs we cannot scale our label (since it's a name)

final.data <- cbind(stand.features, iris[5])

species <- iris[, 5]

library(caTools)
library(class)

# TRAIN TEST SPLIT
set.seed(101)
#
sample <- sample.split(final.data$Species, SplitRatio = 0.7)
# TRAIN
train.data <- subset(final.data, sample == TRUE)
# TEST
test.data <- subset(final.data, sample == FALSE)


#####
# KNN
#####

predicted.species <- knn(train.data[1:4], test.data[1:4], train.data$Species, k = 1) 


print(predicted.species)


misClass.error <- mean(test.data$Species != predicted.species)

print(misClass.error) # 0.04

#####
## CHOOSE A K VALUE
#####

predicted.species <- NULL
error.rate <- NULL
for (i in 1:10){
  set.seed(101)
  predicted.species <- knn(train.data[1:4], test.data[1:4], train.data$Species, k = i)
  error.rate[i] <- mean(test.data$Species != predicted.species)
}

####
#### PLOT THIS OUT FOR THE ELBOW METHOD


library(ggplot2)

# the df should match the values used in for
k.values <- 1:10
error.df <- data.frame(error.rate, k.values)

pl <- ggplot(error.df, aes(x = k.values, y = error.rate)) + geom_point()
pl <- pl + geom_line(lty = 'dotted', color = 'red', size = 2)
# size used to make the line thicker

print(pl)

# noticed that k should around 2-6


