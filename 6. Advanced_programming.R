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


# Math functions with R

# abs(): computes the absolute value.
# sum(): returns the sum of all the values present in the input.
# mean(): computes the arithmetic mean.
# round(): rounds values (additional arguments to nearest)


v <- c(-2, -3, 0, 4)
abs(v)
sum(v)
mean(v)
round(2.33211, digits = 2)
round(2.377, 1)



# Regular expressions -- pattern searching in a string / pattern of strings 
# grepl --> returns a logical / boolean value
# grep = general regular expression -- returns an index

grepl('pattern', text)

v <- c('a', 'b', 'c', 'd', 'd')
grepl('b', v)

grep('b', v) # index where it's true

grep('a', c('b', 'a')) # -- 2 



# Date and Timestamps

Sys.Date() # today's date: [1] "2024-02-05"

today <- Sys.Date()
class(today) # -- "Date" object, not a character string

# in data imported, dates are usually strings

# convert to date object, the character is already in standard format
c <- '2002-07-18'
my.date <- as.Date(c)

as.Date('Feb-02-2024') # error

# convert the string into a date object
my.date <- as.Date('Feb-02-24', format = "%b-%d-%y")

my.date # -- standardized now: [1] "2024-02-02"

# DATES
#  %d  Day of the month (decimal number)
#  %m  Month (decimal_number)
#  %b  Month (abbreviated)
#  %B  Month (full name)
#  %y  Year (2 digit)
#  %y  Year (4 digit)

# useful for TIME SERIES ANALYSIS -- as.Date() in combination with the format argument 
# to convert any string repres of a date to an actual date object

as.Date('July, 18, 2002', format = "%B, %d, %Y") 
# "2002-07-18"

# portable operating system interface

as.POSIXct("19:28:11", format = "%H:%M:%S")
# [1] "2024-02-05 19:28:11 WET"

# usually strptime is used!
# strptime("date", format = "")

help("strptime") # call help to construct the string
strptime("19:40:19", format = "%H:%M:%S")  # "2024-02-05 19:40:19 WET"






