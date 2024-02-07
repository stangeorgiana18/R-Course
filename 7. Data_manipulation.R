# DPLYR package  -- simplies the syntax

# install.packages('dplyr')
# install.packages('nycflights13') -- dataset flights 2013

# dplyr -- has its own filter, lag etc. function that will overwrite the default filter for R

# library(dplyr)
# library(nycflights13)



# FUNCTIONS TO MANIPULATE DATA, after calling library DPLYR:

# filter() (and slice())
# arrange()
# select() (and rename())
# distinct()
# mutate() (and transmute())
# summarise()
# sample_n() and sample_frac()


# selecting a subset of rows with filter
# first argument = df, next arguments = conditions filtering the df
head(filter(flights, month == 11, day == 3, carrier == 'AA'))


# a subset call is similar, but this is easier to read

# this is the normal way to do the above with a df:
head(flights[flights$month == 11 & flights$day == 3 & flights$carrier == 'AA', ])

# slice() returns rows by position
slice(flights, 1:10)

# reorrder the rows by passing in the columns we want to order by 

head(arrange(flights, year, month, day, arr_time))

# arrival time in descending order
head(arrange(flights, year, month, day, desc(arr_time)))


# select() -- quickly zoom in on a useful subset using op that'll only work for numeric variable positions
# grab data and pass in the columns you want

head(select(flights, carrier))
head(select(flights, carrier, arr_time))
head(select(flights, carrier, arr_time, month))


# rename columns: rename(df, new.column.name = new.name)
head(rename(flights, airline_carrier = carrier))


# select distinct/unique values in a COLUMN OR TABLE
distinct(select(flights, carrier)) # all the unique airline names


# add new columns that are functions of existing columns with MUTATE
head(mutate(flights, new_col = arr_delay - dep_delay))

# if I only want this column back, call transmute
head(transmute(flights, new_col = arr_delay - dep_delay))


# collapse df into single rows using a function that aggregates the result
# pass in the column we want back: abf_air_time
summarise(flights, avg_air_time = mean(air_time, na.rm = TRUE)) # and remove na values, built-in in mean func

# get one raw back
summarise(flights, total_air_time = sum(air_time, na.rm = TRUE))


# return n random rows 
sample_n(flights, 10)

# receive a fraction of the rows
sample_frac(flights, 0.1) # 10% of my rows



# PIPE OPERATOR
# CHAINS TOGETHER MULTIPLE OPERATIONS OR FUNCTIONS ON A DATASET

# Nesting

# read from inside out 
result <- arrange(sample_n(filter(df, mpg>20), size = 5), desc(mpg))

# Multiple assignments - rewrite the above 
# easier to read but too many variables
a <- filter(df, mpg > 20)
b <- sample_n(a, size = 5)
result <- arrange(b, desc(mpg))

# Pipe operator -- allows steps separations, easiness to read
# Data %>% op1 %>% op2 %>% op3 

# data passed in not needed bcs it's going along this pipeline
result <- df %>% filter(mpg > 20) %>% sample_n(size = 5) %>% arrange(desc(mpg))

print(result)



# training ex for dplyr library
head(filter(mtcars, mpg > 20, cyl == 6))

head(arrange(mtcars, cyl, desc(wt)))  # Reorder the Data Frame by cyl first, then by descending wt.
head(select(mtcars, mpg, cyl))


head(distinct(select(mtcars, gear))) 
mtcars %>% select(gear) %>% distinct()


head(mutate(mtcars, performance = hp / wt))
summarise(mtcars, mean_mpg = mean(mpg, na.rm = T))

# Use pipe operators to get the mean hp value for cars with 6 cylinders.
mtcars %>% filter(cyl == 6) %>% summarise(avf_hp = mean(hp))



# TYDLR - CLEAN DATA - get the data in a good format

# tidy data set -- every row = an observation; every column = a feature/variable
# --> every cell a value for a specific feature of a specific observation

# data.table - df with extra features; package that extends data frames (speed and cleaner syntax)

# KEEP IN MIND!
# MAIN DIFF DATA.TABLE - DATA.FRAME - THE SPEED OF THE OPERATION
# data.table won't do internal copying endlessly and it's usually faster for basic op


# install.packages('tidyr')
# install.packages('data.table')

# library(tidyr)
# library(data.table)


# gather() - colapse columns into key paired values

comp <- c(1,1,1,2,2,2,3,3,3)
yr <- c(1998,1999,2000,1998,1999,2000,1998,1999,2000)
q1 <- runif(9, min=0, max=100)
q2 <- runif(9, min=0, max=100)
q3 <- runif(9, min=0, max=100)
q4 <- runif(9, min=0, max=100)

df <- data.frame(comp=comp, year=yr, Qtr1 = q1, Qtr2 = q2, Qtr3 = q3, Qtr4 = q4)

gather(df, Quarter, Revenue, Qtr1:Qtr4)

df %>% gather(Quarter, Revenue, Qtr1 : Qtr4)


# spread() - the complement of gather

stocks <- data.frame(
  time = as.Date('2009-01-01') + 0:9,
  X = rnorm(10, 0, 1),
  Y = rnorm(10, 0, 2),
  Z = rnorm(10, 0, 4)
)

stocks.gathered <- stocks %>% gather(stock, price, X:Z)
# or:
stocks.gathered <- stocks %>% gather(stock, price, X, Y, Z) # key value pairs for gather: stock, price

spread(stocks.gathered, stock, price)
spread(stocks.gathered, time, price) # -- analogous to a pivot table in excel


# separate() -- turn single character column into multiple columns

separate(df, new.col, c('ABC', 'XYZ'))

# separate by default alpha numeric characters

df <- data.frame(new.col = c(NA, 'a-x', 'b-y', 'c-z'))
separate(data = df, col = new.col, into = c('abc', 'xyz'), sep = '-') # separate new.col into by sep


# unite() -- convenience function to paste together multiple columns into one

df.sep <- separate(data = df, col = new.col, into = c('abc', 'xyz'))
unite(df.sep, new.joined.col, abc, xyz)
unite(df.sep, new.joined.col, abc, xyz, sep = '---')


