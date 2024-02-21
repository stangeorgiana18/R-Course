loans <- read.csv('loan_data.csv')

#print(summary(loans))
#print(str(loans))

# COMNVERT TO CATEGORICAL
# fico for instance is int bcs it's a continuous value
loans$purpose <- factor(loans$purpose)
loans$inq.last.6mths <- factor(loans$inq.last.6mths)
loans$delinq.2yrs <- factor(loans$delinq.2yrs)
loans$pub.rec <- factor(loans$pub.rec)
loans$not.fully.paid <- factor(loans$not.fully.paid)
loans$credit.policy <- factor(loans$credit.policy)

print(str(loans))

library(ggplot2)

pl <- ggplot(loans, aes(fico)) + geom_histogram(aes(fill = not.fully.paid), color = 'black') +  theme_bw()
print(pl)

# position = 'dodge' - bars side by side, grouped bars 
pl <- ggplot(loans, aes(factor(purpose))) + geom_bar(aes(fill = not.fully.paid), position = 'dodge') + scale_fill_manual(values = c('green','red'))
print(pl)

pl <- ggplot(loans, aes(int.rate, fico)) + geom_point(aes(color = not.fully.paid), alpha = 0.5, size = 5)
print(pl)
 
library(e1071)
library(caTools)

sample <- sample.split(loans, SplitRatio = 0.7)
train <- subset(loans, sample == T)
test <- subset(loans, sample == F)

model <- svm(not.fully.paid ~ . , data = train)
print(summary(model))


predictions <- predict(model, test)
print(table(predictions, test$not.fully.paid)) # bad results: model predicts everything was 0 for not.fully.paid => evyn fully paid their loan

#### pass in the formula for prediction as train.x and you don't have to pass in train.y
####
#tune.results <- tune(svm, train.x = not.fully.paid ~ . , data = train, kernel='radial',
                     #ranges = list(cost = c(100, 200), gamma = c(0, 1)))

#print(summary(tune.results))

# cost gamma
# 100    0.1

tuned.model <- svm(not.fully.paid ~ . , data = train, cost = 100, gamma = 0.1)

# test[1:13] - only the test features, not the label one
tuned.predictions <- predict(tuned.model, test[1:13])
print(table(tuned.predictions, test$not.fully.paid))

# for a better svm, tune for a much larger range of cost and gamma combinations, at the cost of time

# predictions    0    1
#           0 2907  514
#           1    0    0
# 
# tuned.predictions    0    1
#                 0 2640  431
#                 1  267   83
