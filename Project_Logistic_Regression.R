# emphasis on possible issues when cleaning data

adult <- read.csv('adult_sal.csv')

#print(head(adult))

# noticed the index is repeated --> drop that column

library(dplyr)

adult <- select(adult, -X)

#print(head(adult))
#print(str(adult))
#print(summary(adult))

###############
# DATA CLEANING
###############

# clean the columns by reducing the number of factors

table.type.employer <- table(adult$type_employer) # check the frequency of a column 
#print(table.type.employer)

missing.values <- sum(is.na(adult$type_employer))
#print(missing.values)

# find the 2 smallest groups in type_employer
smallest.groups <- head(sort(table.type.employer), 2)
#print(smallest.groups)


# Combine these two smallest groups into a single group called "Unemployed"
smallest.groups <- names(sort(smallest.groups)[1:2])

combine.unemployed <- function(x) {
  if (x %in% smallest.groups) {
    return ("Unemployed")
  } else {
    return (as.character(x))
  }
}

adult$type_employer <- sapply(adult$type_employer, combine.unemployed)

#print(table(adult$type_employer))

#### table function - how many times a unique value appears in a vector


# group self employed & state and local
gov.groups <- c('State-gov', 'Local-gov')
self.employed <- c('Self-emp-inc', 'Self-emp-not-inc')

combine.employed <- function(x) {
  if (x %in% gov.groups){
    return('SL-gov')
  } else if (x %in% self.employed){
    return ('self-emp')
  } else{
    return (as.character(x))
  }
}

adult$type_employer <- sapply(adult$type_employer, combine.employed)

#print(table(adult$type_employer))

# look at the marital column 
#print(table(adult$marital))

married <- c('Married-AF-spouse', 'Married-civ-spouse',  'Married-spouse-absent')
unmarried <- c('Divorced', 'Widowed', 'Separated' )

marital.status <- function(x) {
  if (x %in% married){
    return ('Married')
  } else if (x %in% unmarried){
    return ('Unmarried')
  } else {
    return ('Never-married')
  }
}
adult$marital <- sapply(adult$marital, marital.status)

#print(table(adult$marital))

#print(adult$country)


Asia <- c('China','Hong','India','Iran','Cambodia','Japan', 'Laos' ,
          'Philippines' ,'Vietnam' ,'Taiwan', 'Thailand')

North.America <- c('Canada','United-States','Puerto-Rico' )

Europe <- c('England' ,'France', 'Germany' ,'Greece','Holand-Netherlands','Hungary',
            'Ireland','Italy','Poland','Portugal','Scotland','Yugoslavia')

Latin.and.South.America <- c('Columbia','Cuba','Dominican-Republic','Ecuador',
                             'El-Salvador','Guatemala','Haiti','Honduras',
                             'Mexico','Nicaragua','Outlying-US(Guam-USVI-etc)','Peru',
                             'Jamaica','Trinadad&Tobago')
Other <- c('South')

group_country <- function(ctry){
  if (ctry %in% Asia){
    return('Asia')
  }else if (ctry %in% North.America){
    return('North.America')
  }else if (ctry %in% Europe){
    return('Europe')
  }else if (ctry %in% Latin.and.South.America){
    return('Latin.and.South.America')
  }else{
    return('Other')      
  }
}

adult$country <- sapply(adult$country, group_country)

#print(table(adult$country))


#print(str(adult))
 
#print(table(adult$education))

primary <- c('1st-4th', '5th-6th', '7th-8th', '9th', 'Preschool')
secondary <- c('10th', '11th', '12th')
higher.secondary <- c('Some-college', 'Assoc-acdm', 'Assoc-voc')
higher.education <- c('Bachelors', 'Masters', 'Doctorate', 'Prof-school')

education.level <- function(x){
  if (x %in% primary){
    return ('Primary')
  } else if (x %in% secondary){
    return ('Secondary')
  } else if (x %in% higher.education){
    return ('Higher secondary')
  } else {
    return ('Higher education')
  }
}

adult$education <- sapply(adult$education, education.level)


#print(table(adult$education))

#print(table(adult$occupation))

office.jobs <- c('Adm-clerical', 'Exec-managerial', 'Tech-support')
service.jobs <- c('Handlers-cleaners', 'Other-service', 'Priv-house-serv')
professional.jobs <- 'Prof-specialty'
protective.services <- c('Armed-Forces', 'Protective-serv')
sales.and.marketing <- 'Sales'
skilled.trades <- c('Craft-repair', 'Farming-fishing', 'Machine-op-inspct', 'Transport-moving')

occupation.category <- function(x){
  if (x %in% office.jobs){
    return ('Office jobs')
  } else if (x %in% service.jobs){
    return ('Service jobs')
  } else if (x %in% professional.jobs){
    return ('Professional job')
  } else if (x %in% protective.services){
    return ('Protective services')
  } else if (x %in% sales.and.marketing){
    return ('Sales and marketing')
  } else {
    return('Skilled trades')
  }
}

adult$occupation <- sapply(adult$occupation, occupation.category)

#print(table(adult$occupation))

### check the final structure (the factors in particular)
#print(str(adult))


### notice MISSING DATA

library(Amelia) # create missing maps


# convert any cell with a '?' or a ' ?' value to a NA value
adult[adult == '?'] <- NA

# using table() on a column with NA values should now not display those NA values, instead you'll just see 0 for ?
#print(table(adult$type_employer))


# moved the factor here consequently to apply factor to all the columns again after the transformation above
adult$education <- sapply(adult$education, factor)
adult$relationship <- sapply(adult$relationship, factor)
adult$race <- sapply(adult$race, factor)
adult$sex <- sapply(adult$sex, factor)
adult$occupation <- sapply(adult$occupation, factor)
adult$income <- sapply(adult$income, factor)
adult$country <- factor(adult$country)
adult$marital <- factor(adult$marital)
adult$type_employer <- factor(adult$type_employer)

#print(table(adult$type_employer))

#missmap(adult)
#missmap(adult, main = 'Missing Map', col = c('yellow', 'black'), legend = FALSE)

missmap(adult, y.at=c(1), y.labels = c(''), col=c('yellow','black'))

## DROP MISSING DATA

# for the missing data, we could pass in avg values
# however, occupation and type_empoyer are not numeric values
# so, we'll drop the data because it's not much missing

adult <- na.omit(adult)

print(str(adult))

# check if all na values were dropped
missmap(adult, y.at=c(1), y.labels = c(''), col=c('yellow','black'))


#####
# EDA
#####

library(ggplot2)

# histogram of ages coloured by income
pl <- ggplot(adult, aes(age)) + geom_histogram(aes(fill = income), binwidth = 1, color = 'black') + theme_bw()
print(pl)


pl <- ggplot(adult, aes(hr_per_week)) + geom_histogram(bins = 20) + theme_bw()
print(pl)
# noticed high counts of 40h/week -> you make consider creating another feature such as <40, 40, >40 h/week

# RENAME the country column to region column to better reflect the factor levels
#colnames(adult)[colnames(adult) == "country"] <- "region"

adult <- rename(adult, region = country) # use dplyr

#print(head(adult))

# barplot of regions with fill color defined by income class
pl <- ggplot(adult, aes(region)) + geom_bar(aes(fill = income), color = 'black') + theme_bw() 
print(pl)


#######
####### BUILD THE MODEL 
#######
# logistic regression - classification model
# predict the outcome of categorical variables

# predict whether sb makes >/< $50k/year

# TRAIN TEST SPLIT
library(caTools)

set.seed(101)
#
sample <- sample.split(adult$income, SplitRatio = 0.7)
# TRAIN
train <- subset(adult, split == TRUE)
# TEST
test <- subset(adult, split == FALSE)

# create a binary variable where 1 represents the positive class ('>50K')
#train$income <- as.numeric(train$income == '>50K')

model <- glm(income ~ . , family = binomial(logit), data = train)

#print(summary(model))


# the step() function iteratively tries to remove predictor variables from the model in an attempt to delete variables that do not significantly add to the fit
# the less information a model loses, the higher the quality of that model

new.model <- step(log.model) # create a new model

print(summary(new.model))

##### review variable inflation factor (VIF) and vif() function to explore other options for COMPARISON CRITERIA

test$predicted.income <- predict(model, test, type = 'response')

# CONFUSION MATRIX
print(table(test$income, test$predicted.income > 0.5))

# (TP + TN)/total = accuracy
# ACCURACY shows how often a classification ML model is correct overall
acc <- (6406 + 1408)/(6406 + 517 + 887 + 1408)
print(acc) # 0.847

# recall - the “positive class” out of the total samples for that class
# RECALL shows whether an ML model can find all objects of the target class
# TP / (TP + FN)
rec <- 6406/(6406 + 517)
print(rec)

# precision = TP/(TP + FP)
# PRECISION shows how often an ML model is correct when predicting the target class
prec <- 6406/(6406 + 887)
print(prec)

# what is the cost associated with accuracy versus recall versus precision?
# in some models you'll try to maximize recall/precision vs other model - accuracy

