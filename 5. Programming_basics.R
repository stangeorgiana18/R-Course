# or operator: |

# not operators can also be stacked: !!!

df <- mtcars
df[df$mpg > 20, ] # return all the rows where mpg > 20; other way:
subset(df, mpg > 20)

df[ (df$mpg > 20) & (df$hp > 100), ]
df[ (df$mpg > 20) | (df$hp > 100), ]


x <- 14
# if, else and else if statements
if (x == 10){
  # code to execute
  print('x is equal to 10')
}else if (x == 12){
  print('x is equal to 12')
}else{
  print('x was not equal to 10 or 12') # else like catchall
}


if (x %% 2 == 0){
  print('even number')
}else{
  print('odd number')
}

x <- matrix() # empty matrix

if (is.matrix(x)){
  print("x is a matrix")
}else{
  print('not a matrix')
}


# Create a script that given a numeric vector x with a length 3, will print out the elements in order from high to low. 
# You must use if, else if, and else statements for your logic.

x <- c(3, 7, 1)

if (x[1] > x[2]){
  # first and second place
  first <- x[1]
  second <- x[2]
}else{
  first <- x[2]
  second <- x[1]
}

if (x[3] > first & x[3] > second){
  # 3rd was the largest
  third <- second
  second <- first
  first <- x[3]
}else if (x[3] < first & x[3] < second){
  # 3rd was the smallest
  third <- x[3]
}else{
  # goes in the middle
  third <- second
  second <- x[3]
}

print(paste(first, second, third)) # paste together 3 variables


# Print the max element in a numeric vector with 3 elements
x <- c(20, 100, 1)

if (x[1] > x[2] & x[1] > x[3]){
  print(x[1])
}else if (x[2] > x[3]){
  print(x[2])
}else{
  print(x[3])
}


# while loops
x <- 0

while (x < 10){
  print(paste0('x is: ', x)) # concatenate the input values in a single character string WITHOUT SEPARATOR
  
  x <- x + 1
  if (x == 5){
    print('x is not equal to 5, break loop')
    break
  }
}


# for loops

v <- c(1, 2, 3, 4, 5)

for (variable in v){
  print(variable)
}


for (temp.var in v){
  # execute for every temporary variable in v
  print('hello')
}


my.list <- list(c(1, 2, 3), mtcars, 12)

for (item in my.list){
  print(item)
}

mat <- matrix(1:25, nrow = 5)
print(mat)

# iteration goes by column in matrices: for (item in mat)

# nrow(mat) -- 5
# 1:nrow(mat) -- 1:5

for (row in 1 : nrow(mat)) {
  for (col in 1 : ncol(mat)) {
    print(paste('The element at row: ', row, 'and col: ', col, 'is', mat[row, col]))
  }
}

# functions

name_of_func <- function(input1, input2, input3 = 45){
  # code to execute
  result <- input1 + input2
  return(result)
}


hello <- function(name = 'Geo'){
  print(paste("Hello,", name))
}

hello('Sam') # overwrite the default


add_num <- function(num1, num2){
  my.sum <- num1 + num2
  return(my.sum)
}

result <- add_num(4, 5)
print(result)


# scope -- how variables and objects get defined within R


times5 <- function(num){
  my.result <- num * 5
  return(my.result)
}

my.output <- times5(100)

print(my.output)


v <- "I'm a global variable"
stuff <- "I'm global stuff"

fun <- function(stuff){
  print(v)
  stuff <- "Reassign stuff inside of this functions fun"
  print(stuff)
}

fun(stuff)
print(stuff)


# practice exercises

num_check <- function(num, vec){
  for (item in vec){
    if (item == num){
      return(TRUE)
    }
  }
  return(FALSE)
}

print(num_check(2,c(1,2,3)))
print(num_check(2,c(1,4,5)))


num_count <- function(num, vec){
  count <- 0
  for (item in vec){
    if (item == num){
      count <- count + 1
    }
  }
  return(count)
}

print(num_count(2,c(1,1,2,2,3,3)))
print(num_count(1,c(1,1,2,2,3,1,4,5,5,2,2,1,3)))


bar_count <- function(kg){
  bars <- floor(kg / 5) + kg %% 5 
  return(bars)
}

print(bar_count(6))
print(bar_count(17))


summer <- function(a, b, c){
  sum <- a + b + c
  if (a %% 3 == 0){
    sum <- sum - a
  }
  if(b %% 3 == 0){
    sum <- sum - b
  }
  if (c %% 3 == 0){
    sum <- sum - c
  }
  return(sum)
}

print(summer(7,2,3))
print(summer(3,6,9))
print(summer(9,11,12))

# OR:

summer <- function(a, b, c){
  out <- c(0)
  
  if (a %% 3 != 0){
    out <- append(a,out)
  }
  if (b %% 3 != 0){
    out <- append(b,out)
  }
  if (c %% 3 != 0){
    out <- append(c,out)
  }
  return(sum(out))       
}


prime_check <- function(n){
  if(n < 2){
    return(FALSE)
  }else{
    i = 2
    while(i * i <= n){
      if( n %% i == 0 ){
        return(FALSE)
      }
      i <- i + 1
    }
  }
  return(TRUE)
}

print(prime_check(2))
print(prime_check(5))
print(prime_check(4))
print(prime_check(237))
print(prime_check(131))

# OR:
prime_check <- function(num) {
  if (num == 2) {
    return(TRUE)
  } else if (any(num %% 2:(num-1) == 0)) {
    return(FALSE)
  } else { 
    return(TRUE)
  }
}


# Alternatively:
prime_check <- function(num){
  # Could put more checks for negative numbers etc...
  if (num == 2) {
    return(TRUE)
  }
  for (x in 2:(num-1)){
    
    if ((num%%x) == 0){
      return(FALSE)
    }
  }
  return(TRUE)
  
}