# logistic regression -> classification problems -> predict discrete categories (not continuous as regression problems)
# the logistic regression curve only goes from 0 to 1
# for evaluating classification models - CONFUSION MATRIX
# false positive - type 1 error; false negative - type 2 error in statistics
# accuracy = (TP + TN)/total
# misclassification/error rate = (FP + FN)/total


# predict whether sb survived or was deceased in the Titanic disaster

df.train <- read.csv('titanic_train.csv')
print(head(df.train))
print('    ')
print(str(df.train)) # we may do feature engineering and grab titles from the name: Mr., Dr., etc.


# check how much missing data we have

# install.packages('Amelia')
library(Amelia)

missmap(df.train, main = 'Missing Map', col = c('yellow', 'black'), legend = FALSE) # pass in data, main title of visualization, col = vector of missing cells color and observed cells color
# noticed that ~20% of the data is missing 

library(ggplot2)
library(ggthemes)

ggplot(df.train, aes(Survived)) + geom_bar() # bar plot to check how many people survived/did not

ggplot(df.train, aes(Pclass)) + geom_bar(aes(fill = factor(Pclass))) # noticed there are more 3rd class passengers


ggplot(df.train, aes(Sex)) + geom_bar(aes(fill = factor(Sex))) # noticed there are more males on board (x2)

ggplot(df.train, aes(Age)) + geom_histogram(bins = 20, alpha = 0.5, fill = 'blue') # most 20-40 yo

ggplot(df.train, aes(SibSp)) + geom_bar() # siblings and spouse count --> the majority of people didn't have any 

# the color is the outline and the fill is the actual fill value
ggplot(df.train, aes(Fare)) + geom_histogram(fill = 'green', color = 'black', alpha = 0.5) # most people paid a low fare 



# EXPLORE DATA CLEANING AND TRY TO FILL IN MISSING DATA
# we want to make sure the data is clean and tidy before running the logistic regression model

# ways to get rid of the na values: drop all the rows with na values for age / FILL IN THAT DATA THROUGH IMPUTATION 
# so we can fill in the data by the average age value/avg age by class

pl <- ggplot(df.train, aes(Pclass, Age))
pl <- pl + geom_boxplot(aes(group = Pclass, fill = factor(Pclass), alpha = 0.4))

# seq() - regular sequence generator function
pl <- pl + scale_y_continuous(breaks = seq(min(0), max(80), by = 2)) # set the numbers on the y axis
pl <- pl + theme_bw()

print(pl)

# noticed 1st class pass older than 3rd class pass

#######
# IMPUTATION OF AGE BASED ON CLASS
#######

impute_age <- function(age,class){
  out <- age
  for (i in 1:length(age)){
    
    if (is.na(age[i])){
      
      if (class[i] == 1){
        out[i] <- 37
        
      }else if (class[i] == 2){
        out[i] <- 29
        
      }else{
        out[i] <- 24
      }
    }else{
      out[i] <- age[i]
    }
  }
  return(out)
}

#####
fixed.ages <- impute_age(df.train$Age, df.train$Pclass)
#####
df.train$Age <- fixed.ages
#####
print(missmap(df.train, main = 'Imputation check', col = c('yellow', 'black', legend = FALSE)))

# everything is black --> we no longer have any missing values



# BUILD THE MODEL
# remove the features we don't use and make sure the features are of the correct data type

str(df.train)

library(dplyr)

df.train <- select(df.train, -PassengerId, -Name, -Ticket, -Cabin)
head(df.train)
str(df.train)

# set factor columns
df.train$Survived <- factor(df.train$Survived)
df.train$Pclass <- factor(df.train$Pclass)
df.train$Parch <- factor(df.train$Parch)
df.train$Sex <- factor(df.train$Sex)
df.train$SibSp <- factor(df.train$SibSp)
df.train$Embarked <- factor(df.train$Embarked)

str(df.train)

# glm = generalised linear model
# pass in the formula: predict the Survived column based off of every feature, family = description of error 
# distribution used - link = 'logit' -- use the logistic reg function
log.model <- glm(Survived ~ . , family = binomial(link = 'logit'), data = df.train)

print(summary(log.model))
# *** - very unlikely not to be important, statistically correct

################
# as an exercise: predict titanic_test.csv - impute the data as the train_data
################

library(caTools)

set.seed(101)

split <- sample.split(df.train$Survived, SplitRatio = 0.7)
final.train <- subset(df.train, split == TRUE)
final.test <- subset(df.train, split == FALSE)

final.log.model <- glm(Survived ~ . , family = binomial(link = 'logit'), data = final.train)

print(summary(final.log.model))

# predict values off of the above
# pass in model, new data, and type = 'response' bcs we're predicting an actual class PROBABILITY response: 0 OR 1
fitted.probabilities <- predict(final.log.model, final.test, type = 'response')

fitted.results <- ifelse(fitted.probabilities > 0.5, 1, 0) # if > 0.5 set it equal to 1 --> VECTOR OF 0 AND 1

misClassError <- mean(fitted.results != final.test$Survived) # calculate the proportion of misclassified observations = the proportion of TRUE values in the logical vector
# TRUE if the predicted label is not equal to the actual label, and FALSE otherwise


# proportion of correctly classified observations, and subtracting the misclassification rate from 1
print(1 - misClassError) # THE ACCURACY: 80%


# main standard of evaluating the model: the confusion matrix
# CONFUSION MATRIX

table(final.test$Survived, fitted.probabilities > 0.5)


