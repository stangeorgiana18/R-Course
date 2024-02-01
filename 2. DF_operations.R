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



