
# make a csv file
write.csv(mtcars, file = 'my_example.csv')

# reading from csv
ex <- read.csv('my_example.csv')

# check the head 
head(ex)

# ex is a data.frame
class(ex)

# writing df to a csv file: write.csv(df_to_be_written, file = 'name_of_file_you_want')
write.csv(ex, file = 'my_new_example.csv')

read.csv('my_new_example.csv')


# EXCEL FILES WITH R
# install.packages("tidyverse")
# library(tidyverse)

# call the library -- no quotes 
library(readxl)

# call functions from the loaded library 
# RETURN THE NAME OF ALL THE SHEETS
excel_sheets('Sample-Sales-Data.xlsx') # list the sheets of the excel file: [1] "Sheet1"


# EACH SHEET IS GOING TO REPRESENT A DATAFRAME 

# read the excel file as a df
# export the excel file as a df in R: you can perform on this excel file anything you learned about R
df <- read_excel('Sample-Sales-Data.xlsx', sheet = 'Sheet1')

# for eg. the sum of the Value
sum(df$Value)

# download an entire workbook into excel
# lapply -- way to apply a function to an entire iterable object such as a list or a vector 

# get me the list of the sheets names, apply read_excel to each of those along the path of the excel file:
entire.workbook <- lapply(excel_sheets('Sample-Sales-Data.xlsx'), read_excel, path = 'Sample-Sales-Data.xlsx')

# then call specific df or sheets off this workbook to work with them 
entire.workbook


# WRITING TO EXCEL FILES 
# ABORT PROBLEM WITH R WHEN RUNNING library(xlsx)

# so I used another package: writexl after installing it 

# write the mtcars df into an excel file
# write_xlsx(data, path)

write_xlsx(mtcars, 'batai_de_cap.xlsx')


# SQL - structure query language 
# general strategy to connect R with SQL

# steps: call the library, connect (pass in db name, userid, pass for the db), 
# connection fetch (connect to the db and the to a table within it) and then ask
# for a sequel query => query data (= dataframe), close the connection

# independent research to make the connction
# eg. r + postgresql

install.packages('RPostgreSQL')
library(RPostgreSQL) # load the librray
help(RPostgresSQL)

# search for the available documentation
??RPostgresSQL

# check our R-bloggers



