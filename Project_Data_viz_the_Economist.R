library(ggplot2)
library(data.table) # to use fread
library(ggthemes)

df <- fread('/Users/georgianastan/Desktop/projects/Economist_Assignment_Data.csv', drop = 1) # drop the first column which is a repeat of the index 

#print(head(df))

pl <- ggplot(df, aes(x = CPI, y = HDI, color = Region)) + geom_point(size = 4, shape = 1) # shape as circles
# we can also use geom_point(aes(color = factor(Region))) instead of using it in ggplot(aes(color = Region))

pl2 <- pl + geom_smooth(aes(group=1), method = 'lm', formula = y ~ log(x), se = FALSE, color = 'red') # add a trend line and customize the smoothing line

# formula for the model - linear regression
# se - shaded confidence interval; if FALSE, no shading


# manually set the subset of countries to label
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20", data = subset(df, Country %in% pointsToLabel), check_overlap = TRUE) 

pl4 <- pl3 + theme_economist_white() + scale_x_continuous(name = 'Corruption Perceptions Index, 2011 (10=least corrupt)', limits = c(0.9, 10.5), breaks = 1:10) + 
       scale_y_continuous(name = 'Human Development Index, 2011 (1=Best)', limits = c(0.2, 1.0), breaks = seq(0.2:1.0, by = 0.2))

pl5 <- pl4 + ggtitle('Corruption and Human development')

print(pl5)









