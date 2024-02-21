# predict if the school is private/public

library(ISLR)

#print(str(College))
#print(data(package = 'ISLR')) # check the available datasets in ISLR

df <- College

#####
##### EDA
#####

library(ggplot2)

pl <- ggplot(df, aes(Room.Board, Grad.Rate)) + geom_point(aes(color = Private), size = 0.4, alpha = 0.5)
print(pl)

pl <- ggplot(df, aes(F.Undergrad)) + geom_histogram(aes(fill = Private), color = 'black', bins = 50, alpha = 0.5) + theme_bw()
print(pl)


pl <- ggplot(df, aes(Grad.Rate)) + geom_histogram(aes(fill = Private), color = 'black', bins = 50, alpha = 0.6) + theme_bw()
print(pl)

print(subset(df, Grad.Rate > 100)) # check college with grad rate > 100%

df['Cazenovia College', 'Grad.Rate'] <- 100


#####
##### TRAIN TEST SPLIT
#####

library(caTools)

sample <- sample.split(df$Private, SplitRatio = 0.7)
train <- subset(df, sample == T)
test <- subset(df, sample == F)

#### DECISION TREE

library(rpart)

# build the tree off the training data
tree <- rpart(Private ~ . , method = 'class', data = train)

printcp(tree) # complexity parameter 

#pl <- plot(tree, unifrom = T, main = 'Sector tree') + text(tree, use.n = T, all = T)
#print(pl)

#### TRAIN MODEL #####
# predict the Private label on the test data
tree.preds <- predict(tree, test)
print(head(tree.preds))

tree.preds <- as.data.frame((tree.preds))

joiner <- function(x){
  if (x >= 0.5){
    return('Yes')
  } else{
    return('No')
  }
}

tree.preds$Private <- sapply(tree.preds$Yes, joiner)

# Turn these two columns into one column to match the original Yes/No Label for a Private column
#tree.preds$Private <- ifelse(tree.preds[, 'Yes'] >= 0.5, 'Yes', 'No')

print(head(tree.preds))

#confusion matrix
confusion.matrix <- table(tree.preds$Private, test$Private)
print(confusion.matrix)

library(rpart.plot)

prp(tree)

# RANDOM FOREST

library(randomForest)

rf.model <- randomForest(Private ~ . , data = train, importance = TRUE)
# importance = the extractor function for variable importance measures that are produced by the RF function
# the Gini impurity index - how much info you gte when you do a certain split on a certain value and how you judge that

#print(rf.model)
# 
print(rf.model$confusion)
# 
print(rf.model$importance) # the imp based on the gini impurity index 
# 
rf.preds <- predict(rf.model, newdata = test)
print(table(rf.preds, test$Private))
# it performed slighlty better than the conf matrix for the DT


