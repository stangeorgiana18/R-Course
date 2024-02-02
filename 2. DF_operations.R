# dataframes = the workhorse of R

# Creating Data Frames
# Importing and Exporting Data
# Getting Information about Data Frame
# Referencing Cells
# Referencing Rows
# Referencing Columns
# Adding Rows
# Adding Columns
# Setting Column Names
# Selecting Multiple Rows
# Selecting Multiple Columns
# Dealing with Missing Data

# make an empty df
empty <- data.frame()

# make a df from vector
c1 <- 1:10
c2 <- letters[1:10] #  built-in vector for the letters of the alphabet
df <- data.frame(col.name.1 = c1, col.name.2 = c2) # if no names, columns will be named by the variables


# import and export 

write.csv(df, file = 'saved_df.csv')
df2 <- read.csv('saved_df.csv')

# notice: the index will be also saved as a column into the csv file
# we'll see this when read from the csv
# because the index is usually a string - names etc. so it's good to save that info when writing into the csv file
# when reading it, you can delete/drop/whatever that info


# getting info about a df

nrow(df)
ncol(df) # 2: not include the actual index, just the columns having names
colnames(df)
rownames(df)
str(df) # no. of observations, variables..
summary(df) # statistical summary of the df


# referencing single cells

df[[5, 2]] # row 5, col 2

df[[5, 'col.name.2']] # USUALLY


# reassign a value for a single cell
df[[2, 'col.name.1']] <- 9999

# return a ROW
df[1, ] # return a df, not a vector -- column names included in the output 

# as.numeric() - if you want a straight vector of those values to convert the row to a vector


# get a COLUMN - 4 methods --> VECTORS returned
# eg. dataframe$column.name

mtcars$mpg
mtcars[, 'mpg']
mtcars[, 1] # by no. of the column
mtcars[['mpg']] # 2 sets of brackets and column name


# get a column - 2 ways --> DATAFRAME 

mtcars['mpg'] 
mtcars[1]

# get multiple columns 
head(mtcars[c('mpg', 'cyl')])


# adding rows: df2 as new row
dfnew <- rbind(df, df2) 

# adding columns -- by naming the new column directly
# eg. df$new.col.name <- 2*df$col.name.1
df$newcol <- 2*df$col.name.1

# copy of that column 
df$newcol.copy <- df$newcol
df[, 'newcol.copy2'] <- df$newcol # or this way: the diff - the way the column is addressed

# you call your column as though it's already on your df but give it a reassignment for new values 


# setting column names
colnames(df) # get the names of the columns in the df
colnames(df) <- c('1', '2', '3', '4', '5') # rename columns all at once 

# rename a single column by selecting the column number with []
colnames(df)[1] <- 'NEW COL NAME' 
# first column -- colnames(df)[1] -- integer, not character!


# selecting multiple rows
df[1:10, ]
df[1:3, ]
head(df, 7)

df[-2, ] # select everything but the second row


# conditional selection

mtcars[ mtcars$mpg > 20, ] # DON'T FORGET THE COMMA 

# in brackets: df$column.name > condition


# filtering rows by 2 separate columns 
mtcars[ mtcars$mpg > 20 & mtcars$cyl == 6, ]


# THE TYPE OF FILTERING YOU'LL BE DOING ALL THE TIME WHEN IMPORTING DATA FROM A CSV -
# to get an idea how it looks like, play around with it
mtcars[mtcars$mpg > 20 & mtcars$cyl == 6, c('mpg', 'cyl', 'hp')] # select some columns 

# another way without specifying the df everythin in the name of the column
subset(mtcars, mpg > 20 & cyl == 6)


mtcars[, c(1, 2, 3)] # columns 1, 2, 3
mtcars[, c('mpg', 'cyl' )] # select by the names of the columns 


# dealing with missing data

# check if there are data points missing
is.na(mtcars) # check in the df
any(is.na(df)) # if there's any missing


any(is.na(mtcars$mpg)) # anywhere in col

# replace missing data
df[is.na(df)] <- 0 # replace null values 


# replace NAs with something else
df[is.na(df)] <- 0 # works on whole df

df$col[is.na(df$col)] <- 999 # For a selected column


# delete selected missing data rows
df <- df[ !is.na(df$col), ]


# COMMON WAY OF DEALING WITH MISSING VALUES - IMPUTE THE MEAN OF THE COLUMN
mtcars$mpg[ is.na(mtcars$mpg)] <- mean(mtcars$mpg) 


# exercises

Name <- c("Sam","Frank","Amy")
Age <- c(22,25,26)
Weight <- c(150,165,120)
Sex <- c("M", "M", "F")
df <- data.frame (row.names = Name, Age, Weight, Sex)

# naming the rows - another way
rownames(df) <- c('sam', 'frank', 'amy')

is.data.frame(mtcars)


mat <- matrix(1:25,nrow = 5)

as.data.frame(mat) # convert matrix to df

# mean of a column values
df <-  mtcars
df$mpg # --> vector of the values
mean(df$mpg)

# all the rows, where column satisfies condition
df[df$cyl == 6, ]

subset(df, cyl == 6)

# create a new column
df$performance <- df$hp / df$wt


df$performance <- round(df$performance, 2)

# average mpg for cars that have more than 100 hp AND a wt value of more than 2.5
mean(subset(df, hp > 100 & wt > 2.5)$mpg)

df[df$hp > 100 & df$wt > 2.5, ]$mpg # --> vectors
mean(df[df$hp > 100 & df$wt > 2.5, ]$mpg)

df['Hornet Sportabout',]  # --> the row HS
df['Hornet Sportabout',]$mpg  # the mpg of the Hornet Sportabout


