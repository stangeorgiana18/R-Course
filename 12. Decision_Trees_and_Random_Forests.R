# in the tree we have nodes that split for the value of a certain attribute 
# edges are the outcome of a split to the next node
# root node, terminal nodes
# entropy and information gain - the mathematical methods for choosing the best split

# actual intuition - choose the features that best split your data - try maximizing the 
# information gain off of this split

# random forests -  way to improve performance off single decision trees
# primary weakness of DT - not the best predictive accuracy bcs of the high variance
# bcs different splits in the training data can lead to very different trees
# BAGGING - general purpose procedure for reducing the variance of ml method

# in RF - we create an ensemble of DT using bootstrap samples of the training set 
# bootstrap samples of the training set = sampling from the training set with replacement

#install.packages('rpart') # lib for DT model

# DECISION TREE = RECURSIVE PARTITIONING 

library(rpart)

print(str(kyphosis))
print(head(kyphosis))

tree <- rpart(Kyphosis ~ . , method = 'class', data = kyphosis) # 'class' --> classification

# functions to examine the tree model:
# printcp(fit), plotcp(fit), rsq.rpart(fit), print(fit), summary(fit), plot(fit), text(fit), post(fit, file=)

printcp(tree) # display the cp table 

pl <- plot(tree, uniform = TRUE, main = 'Kyphosis Tree') # plot the tree
text(tree, use.n = T, all = T)
print(pl) # add text to the tree

#install.packages('rpart.plot')

library(rpart.plot)

prp(tree) # plot the tree: also show the split criteria and what the classes fit under 

#install.packages('randomForest')

library(randomForest)

rf.model <- randomForest(Kyphosis ~ . , data = kyphosis)

print(rf.model)

# RF model = essentially a list of components

print(rf.model$predicted)
print(rf.model$ntree)

# you can possibly lower your error/misclassification rate by adding more trees
# but a certain point adding this is not going to help you
# decide that by plotting out your number of trees vs your misclassification rate 

print(rf.model$confusion) # confusion matrix for the training data 

# RF - for distributing computing 
# you can distribute some the trees to one server and others to another server
# they're all independent from each other --> they don't need to communicate to each other
# until we aggregate the actual nodes
