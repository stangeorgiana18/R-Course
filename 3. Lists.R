# lists -- store a variety of data str under a sg var

v <- c(1, 2, 3)
m <- matrix(1:10, nrow = 2)
df <- mtcars

class(v)
class(m)
class(df)

my.list <- list(v, m , df)

# my.list will display each item in the list with double []: [[1]]
# we can name this items instead of having the automatically assigned numbers


my.named.list <- list(sample.vec = v, my.matrix = m, sample.df = df)

# select element
my.named.list$sample.df

# select objects from a list
# organizational tool

my.list[1]

my.named.list[1]  # or:
my.named.list['sample.vec']

class(my.named.list['sample.vec']) # LIST!!


my.named.list$sample.vec  # RETURN THE VECTOR ITSELF FROM THE LIST
# or without the $ notation:
my.named.list[['sample.vec']]


class(my.named.list$sample.vec) # numeric


# you can combine lists together 
double.list <- c(my.named.list, my.named.list)


# best way to get info about the list:
str(my.named.list) # report back number of obj in the list and what kind 


