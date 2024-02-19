# emphasis on possible issues when cleaning data

adult <- read.csv('adult_sal.csv')

print(head(adult))

# noticed the index is repeated --> drop that column

library(dplyr)

adult <- select(adult, -X)

print(head(adult))
print(str(adult))
print(summary(adult))

###############
# DATA CLEANING
###############

# clean the columns by reducing the number of factors

table.type.employer <- table(adult$type_employer) # check the frequency of a column 
print(table.type.employer)

missing.values <- sum(is.na(adult$type_employer))
print(missing.values)

# find the 2 smallest groups in type_employer
smallest.groups <- head(sort(table.type.employer), 2)
print(smallest.groups)


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

print(table(adult$type_employer)) # table function - how many times a unique value appears in a vector

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

print(table(adult$type_employer))

# look at the marital column 
print(table(adult$marital))

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

print(table(adult$marital))

print(adult$country)

Asia = c('Cambodia', 'China', 'Hong', 'India', 'Iran', 'Japan', 'Laos', 'Philippines', 'Taiwan', 'Thailand', 'Vietnam')
Europe = c('England', 'France', 'Germany', 'Greece', 'Hungary', 'Ireland', 'Italy', 'Poland', 'Portugal', 'Scotland', 'Holand-Netherlands')
Latin.and.South.America = c('Columbia', 'Cuba', 'Dominican-Republic', 'Ecuador', 'El-Salvador', 'Guatemala', 'Haiti', 'Honduras', 'Jamaica', 'Mexico', 'Nicaragua', 'Peru', 'Puerto-Rico', 'Trinadad&Tobago')
North_America = c('Canada', 'United-States', 'Outlying-US(Guam-USVI-etc)')
Other = setdiff(unique(adult$country), c('Cambodia', 'China', 'Hong', 'India', 'Iran', 'Japan', 'Laos', 'Philippines', 'Taiwan', 'Thailand', 'Vietnam',
                                         'England', 'France', 'Germany', 'Greece', 'Hungary', 'Ireland', 'Italy', 'Poland', 'Portugal', 'Scotland', 'Holand-Netherlands',
                                         'Columbia', 'Cuba', 'Dominican-Republic', 'Ecuador', 'El-Salvador', 'Guatemala', 'Haiti', 'Honduras', 'Jamaica', 'Mexico', 'Nicaragua', 'Peru', 'Puerto-Rico', 'Trinadad&Tobago',
                                         'Canada', 'United-States', 'Outlying-US(Guam-USVI-etc)'))


continents <- function(x) {
  if (x %in% Asia){
    return ('Asia')
  } else if (x %in% Europe){
    return ('Europe')
  } else if (x %in% Latin.and.South.America){
    return ('Latin and South America')
  } else if (x %in% North_America){
    return ('North America')
  } else if (x %in% Other) {
    return ('Other')
  }

}

adult$country <- sapply(adult$country, continents)

print(table(adult$region))

adult$country <- factor(adult$country)
adult$marital <- factor(adult$marital)
adult$type_employer <- factor(adult$type_employer)

print(str(adult))


print(table(adult$education))

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

print(table(adult$education))

print(table(adult$occupation))

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

print(table(adult$occupation))

# notice missing data 
library(Amelia)


# convert any cell with a '?' or a ' ?' value to a NA value
adult[adult == '?'] <- NA

# using table() on a column with NA values should now not display those NA values, instead you'll just see 0 for ?
print(table(adult$type_employer))

#missmap(adult, main = 'Missing Map', col = c('yellow', 'black'), legend = FALSE)

missmap(adult,y.at=c(1),y.labels = c(''),col=c('yellow','black'))

adult <- na.omit(adult)

print(str(adult))


#####
# EDA
#####

library(ggplot2)

# check if all na values were dropped
missmap(adult,y.at=c(1),y.labels = c(''),col=c('yellow','black'))

pl <- ggplot(adult, aes(age)) + geom_histogram(aes(color = income), bins = 20, alpha = 0.5, fill = 'red') 
print(pl)


pl <- ggplot(adult, aes(hr_per_week)) + geom_histogram(bins = 20) 
print(pl)


colnames(adult)[colnames(adult) == "country"] <- "region"

pl <- ggplot(adult, aes(region)) + geom_bar(aes(fill = income)) # noticed there are more males on board (x2)
print(pl)

# BUILD THE MODEL

print(head(adult))

library(caTools)

set.seed(101)

split <- sample.split(adult$income, SplitRatio = 0.7)
train <- subset(adult, split == TRUE)
test <- subset(adult, split == FALSE)

# create a binary variable where 1 represents the positive class ('>50K')
train$income <- as.numeric(train$income == '>50K')

log.model <- glm(income ~ . , family = binomial('logit'), data = train)

print(summary(log.model))


# the step() function iteratively tries to remove predictor variables from the model in an attempt to delete variables that do not significantly add to the fit

# the less information a model loses, the higher the quality of that model

new.model <- step(log.model) # create a new model

print(summary(new.model))


# review variable inflation factor (VIF) and vif() function to explore other options for COMPARISON CRITERIA

fitted.probabilities <- predict(log.model, test, type = 'response')

fitted.results <- ifelse(fitted.probabilities > 0.5, 1, 0)

misClassError <- mean(fitted.results != test$income) 

print(1 - misClassError) # THE ACCURACY: 80%

# CONFUSION MATRIX

table(test$income, fitted.probabilities > 0.5)



