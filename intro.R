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



