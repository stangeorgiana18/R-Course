# BUILT-IN R FEATURES
# APPLY
# MATH FUNCTIONS WITH R
# REGULAR EXPRESSIONS
# DATES AND TIMESTAMPS


# BUILT-IN R FEATURES

# seq(): Create sequences
# sort(): Sort a vector
# rev(): Reverse elements in object
# str(): Show the structure of an object
# append(): Merge objects together (works on vectors and lists)

seq(0, 10, by = 2) # by = step
seq(0, 100, by = 10)
seq(0, 24, by = 2) # even numbers only 

v <- c(1, 4, 5, 23, 12)
sort(v)
sort(v, decreasing = TRUE) # decreasing order

cv <- c('b', 'd', 'C', 'a') # caps treated as lower case
# and lower case comes before upper case char

v <- 1:10
rev(v)

str(v)
str(mtcars) # obs of 11 var, kind of data rype of column values

summary(mtcars) # statistical summary of various columns

v <- 1:10
v2 <- 35:40
append(v, v2)


# CHECKING DATA TYPE
# is. 

is.vector(v)

# CONVERTING INTO ANOTHER DATA TYPE
# as.

as.list(v)

as.matrix(x) # convert v into a 2 dim matrix: 1 column, 3 rows


# APPLY FUNCTION OVER A LIST/VECTOR

# randomly sample objects from a vector
sample(x = 1:10, 1) # grab 1 object
print(sample(x = 1:100, 3)) # 3 random numbers from 1 to 100


# apply a function over a vector 
v <- c(1, 2, 3, 4, 5)

addrand <- function(x){
  ran <- sample(1:100, 1)
  return(x + ran)
}

print(addrand(10))

# listapply
# lapply(vector, function_passed_in)
result <- lapply(v, addrand)
print(result)


# RETURN A VECTOR INSTEAD OF A LIST
result <- sapply(v, addrand)
print(result)


v <- 1:5
times2 <- function(num){
  return(num * 2)
}

print(v)
result <- sapply(v, times2)
print(result)


# ANONYMOUS FUNCTIONS

addrand <- function(){
  # code 
}

# SIMILAR IDEA TO LAMBDA EXPRESSION IN PYTHON

v <- 1:5
result <- sapply(v, function(num){num * 2})
print(result)


times2 <- function(num){
  return(num * 2)
}

# anonymous functions useful for complex tasks


# APPLY WITH MULTIPLE INPUTS
v <- 1:5

add_choice <- function(num, choice){
  return(num + choice)
}

print(add_choice(2, 10))

sapply(v, add_choice, choice = 100)




