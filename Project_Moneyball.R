# recruit undervalued players

batting <- read.csv('/Users/georgianastan/Desktop/projects/Batting.csv')

#str(batting) # check the structure
# columns that start with a number get an 'X' in front of them

head(batting$AB[1:5]) # call the head of the first rows of AB (At Bats) column 

#head(batting$X2B)

batting$BA <- batting$H / batting$AB # add statistics: batting average 
batting$OBP <- (batting$H + batting$BB + batting$HBP) / (batting$AB + batting$BB + batting$HBP + batting$SF)  # on-base percentage

# create singles, X1B
batting$X1B <- batting$H - batting$X2B - batting$X3B - batting$HR
batting$SP <- (batting$X1B + 2*batting$X2B + 3*batting$X3B + 4*batting$HR) / batting$AB  # slugging percentage

#print(tail(batting$BA, 5))

sal <- read.csv('/Users/georgianastan/Desktop/projects/Salaries.csv')

#summary(batting) # check the minimum year in the yearID column -- 1871
#summary(sal) # minimum year: 1985 

# need to remove the batting data that occurred before 1985
batting <- subset(batting, yearID >= 1985)

# merge the df together
combo <- merge(x = batting, y = sal, by = c('playerID', 'yearID'))
  
lost_players <- subset(combo, playerID %in% c('giambja01', 'damonjo01', 'saenzol01'))
#print(lost_players)

# players lost in 2001 in the offseason -> select the data from 2001 onwards
lost_players <- subset(lost_players, yearID == 2001) # or use filter (dplyr)

# Reduce the lost_players data frame to the following columns:
lost_players <- lost_players[, c('playerID', 'H', 'X2B', 'X3B', 'HR', 'OBP', 'SP', 'BA', 'AB')]

#print(names(lost_players))
head(lost_players)

# replacement players
#  total combined salary of the three players can not exceed 15 million dollars
#  their combined number of At Bats (AB) needs to be equal to or greater than the lost players
#  their mean OBP had to equal to or greater than the mean OBP of the lost players

# SUMMING UP: 15 million, avg 0.364 OBP, 1469 AB


combo <- subset(combo, yearID == 2001)
str(combo) # 915 players (observations)

library(ggplot2)

ggplot(combo, aes(x = OBP, y = salary)) + geom_point(size = 2)

# cut off the salaries at 8 million and off-based % to be > 0
combo <- subset(combo, salary < 8000000 & OBP > 0)
str(combo) # 602 players now
 
print(1496/3) # 498.6667
combo <- subset(combo, AB >= 450)
str(combo) # 122 players now

library(dplyr)

options <- head(arrange(combo, desc(OBP)), 10)

print(options[ , c('playerID', 'AB', 'salary', 'OBP')])

# 3 players would be: heltoto0, berkmla01, gonzalu01

