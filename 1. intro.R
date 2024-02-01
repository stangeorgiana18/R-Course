print('First experience with RStudio')
print('And I like it')

# Ctrl + Enter - run highlighted line
# Ctrl + Enter + Shift - execute all the code

# bad style in R for var: bank_account
# usually: bank.account

# clear the console: Control + L

# delete all variables: rm(list = ls())

# assign logicals as TRUE/FALSE
a <- T 

print(a)

# check data type class
print(class(a))

# numeric
print(class(32.2)) 

# character
print(class("hello"))

# vector - one dimensional array
# you can't mix data types 
# R will convert everything to be of the same class

# combine function
v <- c(TRUE, 20, 40)
print(class(v)) # 1 20 40, "numeric"

v <- c('USA', 20, 32)
print(class(v)) # "USA" "20"  "32", "character"

# assign values to elements in a vector:
temps <- c(71, 78, 60, 55, 70, 60, 66)

names(temps) <- c('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun')

# assign to a new vector days
days <- c('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun')

names(temps) <- days


# we can use these names to grab data out of the vector
print(temps)

# Mon Tue Wed Thu Fri Sat Sun 
# 71  78  60  55  70  60  66 


# VECTOR OPERATIONS
v1 <- c(1, 2, 3)
v2 <- c(5, 6, 7)

print(v1 + v2) # element by element operation: 6  8 10

sum.of.vec <- sum(v1)
print(sum.of.vec) # 6

print(mean(v1)) # 2
print(sd(v1)) # standard deviation: 1

# min and max value in a vector
print(max(v1))
print(min(v1))

# product for all elements in v1
print(prod(v1)) # 6


# INDEXING STARTS AT 1

v <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

# slicing at specific index pos
v[c(1, 2)]

# slicing continuous seq 
v[2:4]

v <- c(1, 2, 3, 4)
names(v) <- ('a', 'b', 'c', 'd')

print(v[c('c', 'd', 'a')])
# c d a 
# 3 4 1 


print(v[v>2])

# c d 
# 3 4

# pass logical cond statements into vectors that have names

my.filter <- v > 2

print(my.filter)

# a     b     c     d 
# FALSE FALSE  TRUE  TRUE 

v[my.filter] 

# c d 
# 3 4 


# you can use R documentation directly from the R environment with help or ??term
# specifically search for help: help.search('vector')


# day and value with max price 
stock.prices <- c(23, 27, 23, 21, 24)
days <- c('Mon', 'Tue', 'Wed', 'Thu', 'Fri')
names(stock.prices) <- days

max.price <- stock.prices == max(stock.prices)

print(stock.prices[max.price])

# Tue 
# 27 

# MATRICES

# filling the matrix, default is by column 

goog <- c(450, 488, 500, 400, 390)
msft <- c(230, 237, 439, 234, 489)

stocks <- c(goog, msft)

print(stocks)

stock.matrix <- matrix(stocks, byrow = T, nrow = 2)

print(stock.matrix)

# name columns/rows
days <- c('Mon', 'Tue', 'Wed', 'Thu', 'Fri')
st.names <- c('GOOG', 'MSFT')

colnames(stock.matrix) <- days
rownames(stock.matrix) <- st.names

print(stock.matrix)


mat <- matrix(1:25, byrow = T, nrow = 5)

mat[mat>15] # results a vector with all the values where this was true

mat %*% mat # matrix multiplication in the algebra sense
mat * mat # element * element

# OPERATIONS 

colSums(stock.matrix) # sum each column 
rowSums(stock.matrix)
rowMeans(stock.matrix)

FB <- c(112, 113, 143, 120, 124)
tech.stock <- rbind(stock.matrix, FB) # bind a new row


avg <- rowMeans(tech.stock)

# GOOG  MSFT    FB 
# 445.6 325.8 122.4 

tech.stock <- cbind(tech.stock, avg) # add column avg

mat[1, ] # first row
mat[, 1] # first column
mat[1:3,] # first 3 rows
mat[2:3, 5:6] 


# factor function --> categorical matrices 
# useful when applying data analysis and machine learning to our data
# idea also known for creating dummy variables


# categorical variables - data that can be divided into distinct groups/categories
# ordinal categorical - order
# nominal categorical - no order

animal <- c('d', 'c', 'd', 'c', 'c')
id <- c(1, 2, 3, 4, 5)


factor(animal)
# [1] d c d c c
# Levels: c d

fact.ani <- factor(animal)
ord.cat <- c('cold', 'med', 'hot')
temps <- c('cold', 'med', 'hot', 'hot', 'hot', 'cold', 'med')

# levels -- the order you want
fact.temps <- factor(temps, ordered = T, levels = c('cold', 'med', 'hot'))

fact.temps
# [1] cold med  hot  hot  hot  cold med 
# Levels: cold < med < hot

# difference between the factor version of the vector vs the summary of the original
summary(fact.temps)
# cold  med  hot 
# 2    2    3 

summary(temps)
# Length     Class      Mode 
#     7 character character 


# Factors - useful in statistical analysis --> work with categorical data in a meaningful way
# used in regression analysis, analysis of variance (ANOVA), statistical modeling techniques

# runif - generates random numbers for a uniform distribution
# runif(n, min = 0, max = 1)
# n - number of observations

# 4 x 5 matrix consisting of 20 random numbers 
matrix(runif(20), nrow = 4)


