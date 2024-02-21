# SL models 
# data analysis and pattern recognition
# used for classification and regression analysis
# SVM training alg builds a model that assigns new examples into categories
# making it a non-probalistic binary linear classifier
# SVM model = representation of the examples as points in space, mapped so that 
# the eg of separate categories are divided by a clear gap that is as wide as possible 
# New eg are then mapped into the same space and predicted to belong to a category based on 
# which side of the gap they fall on

# the vector points at the margin line touch - knows as support vectors
# kernel trick - converts not separable problem to separable problem

library(ISLR)

#print(head(iris))

#install.packages('e1071') # package for svm

library(e1071)

model <- svm(Species ~ . , data = iris)
print(summary(model))

pred.values <- predict(model, iris[1:4])
print(table(pred.values, iris[, 5])) # predicted values vb the species column

# 2 steps: use tune function to know what cost, gamma to use & redo the model using those param
# TUNING

# parameters:
# cost --> allows svm to have a soft margin
# hard margin --> no training labels can cross over the margin

# if you have a cost value, you can play around and allow for soft margins --> svm allows
# some examples to be ignored or placed on the wrong side of that margin 
# this often leads to better fit
# cost involves trading error penalty for stability

# gamma parameter --> non-linear kernel functions 
# it is the free parameter of the Gaussian radial basis function 
# a small gamma means a Gaussian of a large variance => the influence of the svm is more
# a small gamma implies that the class of this svm has an influence on the side in the class of the vector 
# even if the distance between them is large 
# IF GAMMA LARGE, THE VARIANCE IS SMALL --> THE SVM DOESN'T HAVE A WIDESPREAD INFLUENCE 
# LARGE GAMMA => HIGH BIAS AND LOW VARIANCE and vice versa

# tune hyperparameters of statistical methods using a grid search
# hyperparameters - specified by the user, set prior to training

# train.x = features to train on; train.y = the actual label (species in this case)
# ranges - takes in a list of parameters as vectors with values to test

tune.results <- tune(svm, train.x = iris[1:4], train.y = iris[, 5], kernel = 'radial', ranges = list(cost = c(0.1, 1, 10), gamma = c(0.5, 1, 2)))

#print(summary(tune.results)) # report back the best cost and gamma combination: 1.0(c) and 0.5(g)

# grid search - try a diff combinations of the svm param and see which one has the lowest error rate 

tune.results <- tune(svm, train.x = iris[1:4], train.y = iris[, 5], kernel = 'radial', ranges = list(cost = c(0.5, 1, 1.5), gamma = c(0.1, 0.5, 0.7)))
#print(summary(tune.results)) # another set of best parameters: 1.5 and 0.1


# COST = 1.5
# GAMMA = 0.1

tuned.svm <- svm(Species ~ . , data = iris,  kernel = 'radial', cost = 1.5, gamma = 0.1)
print(summary(tuned.svm))



