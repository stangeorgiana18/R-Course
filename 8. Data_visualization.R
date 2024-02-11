# ggplot2 -- adding layers together -- to the visualization: data, aesthetics, geometries, facets, statistics, coordinates, theme
# aes -- which columns/features to plot out
# facet -- multiple plots on a single canvas
# coordinates -- to smooth out the plot


# HISTROGRAMS

library(ggplot2)
library(ggplot2movies)

colnames(movies)

# DATA & AESTHETICS
pl <- ggplot(movies, aes(x = rating))

# GEOMETRIES
pl2 <- pl + geom_histogram(binwidth = 0.1, color = 'red', fill = 'pink', alpha = 0.4)


# FILL OUT THE COLOUR OF THE HISTOGRAM BASED ON THE COUNTS OF THE HISTOGRAM
pl2 <- pl + geom_histogram(binwidth = 0.1, aes(fill = after_stat(count)))
# count getting higher - blue colour lighter


pl3 <- pl2 + xlab('Movie Rating') + ylab('Count')

print(pl3 + ggtitle("My Title"))
# alpha for transparency

# then the plot can be saved/copied


# SCATTERPLOTS -- place points on a plot to show possible correlations between 2 features of a dataset

df <- mtcars
# DATA AND AESTHETICS
pl <- ggplot(data = df, aes(x = wt, y = mpg))

# GEOMETRY
print(pl + geom_point(alpha = 0.5, size = 5))

# size of the scatterplot points grow bigger as the hp values increase:
print(pl + geom_point(aes(size = hp)))

# sizing by factor - that feature is categorical, not a continuous spectrum:
print(pl + geom_point(aes(size = factor(cyl))))

print(pl + geom_point(aes(shape = factor(cyl)), size = 5))

# !!!!!
# for calling size, shape and we want them to be based off other features/columns of our data
# we should pass them in the aes() function inside the geometry layer
# otherwise, size/shape have to be called by integer values
# !!!!!

print(pl + geom_point(aes(shape = factor(cyl), color = factor(cyl)), size = 5))

print(pl + geom_point(aes(shape = factor(cyl), color = factor(cyl)), size = 5, color = 'blue'))



df <- mtcars
pl <- ggplot(df, aes(x = wt, y = mpg))
pl2 <- pl + geom_point(size = 5, color = '#43e8d8') # hex color code



pl2 <- pl + geom_point(size = 5, aes(color = hp))
pl3 <- pl2 + scale_color_gradient(low = 'blue', high = 'red')

print(pl3)


# BARPLOTS 
# categorical data, not continuous
library(ggplot2)
df <- mpg

pl <- ggplot(df, aes(x = class))

print(pl + geom_bar(aes(fill = drv), position = 'dodge')) # stacked bar plot
# showing the percentages: position = 'fill'


# BOXPLOTS 
# depicting groups of numerical data through their core tiles
# whiskers - show the variability outside the upper and lower core tiles

df <- mtcars

pl <- ggplot(df, aes(x = factor(cyl), y = mpg))

print(pl + geom_boxplot() + coord_flip())

print(pl + geom_boxplot(aes(fill = factor(cyl))) + theme_dark())


# COMPARING 2 VARIABLES FROM THE SAME DATASET

library(ggplot2)
library(ggplot2movies)

pl<- ggplot(movies, aes(x = year, y = rating))

pl2 <- pl + geom_bin2d(binwidth = c(3, 1)) 

pl3 <- pl2 + scale_fill_gradient(high = 'red', low = 'blue') # 2D bin chart

print(pl3)



library(ggplot2)
library(ggplot2movies)

pl<- ggplot(movies, aes(x = year, y = rating))

pl2 <- pl + geom_hex() 

pl3 <- pl2 + scale_fill_gradient(high = 'red', low = 'blue') # 2D bin chart

print(pl3)



# 2D density plot

library(ggplot2)
library(ggplot2movies)

pl<- ggplot(movies, aes(x = year, y = rating))

pl2 <- pl + geom_density2d() 

print(pl2)


# COORDINATED AND FACETING 

library(ggplot2)

pl <- ggplot(mpg, aes(x = displ, y = hwy)) + geom_point()

pl2 <- pl + coord_cartesian(xlim = c(1, 4), ylim = c(15, 30))

# set aspect ratios
pl2 <- pl + coord_fixed(ratio = 1/3)

print(pl2)


library(ggplot2)

pl <- ggplot(mpg, aes(x = displ, y = hwy)) + geom_point()

# facet grid syntax: column you want to facet by, ~ and a . that represents anything else
# for the other dimension: vice verse: . ~ column 
print(pl + facet_grid(. ~ cyl))

print(pl + facet_grid(drv ~ .))

print(pl + facet_grid(drv ~ cyl))


# THEMES

library(ggplot2)
library(ggthemes)

# theme_set(theme_minimal()) # set the theme for all the plots

pl <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()

print(pl + theme_fivethirtyeight())

# for more themes options: install.packages('ggthemes')

# you can even set your own themes for your own publications


# exercises - plots

library(ggplot2)
library(ggthemes)
head(mpg)

# histogram -- frequency count
pl <- ggplot(mpg, aes(x = hwy))
pl2 <- pl + geom_histogram(bins = 20, color = 'pink', fill = 'pink', alpha = 0.5)
print(pl2)


# barplot
pl <- ggplot(mpg, aes(x = manufacturer))
pl2 <- pl + geom_bar(aes(fill = factor(cyl)))
print(pl2)


# scatterplot
pl <- ggplot(txhousing, aes(x = sales, y = volume))
pl2 <- pl + geom_point(alpha = 0.5, size = 1.5, color = 'blue')
print(pl2)

# Add a smooth fit line to the scatterplot from above
pl3 <- pl2 + geom_smooth(color = 'red', method = "loess")
print(pl3)



# INTERACTIVE DATA VIZUALIZATIONS WITH PLOTLY
 
install.packages('plotly')

library(ggplot2)
library(plotly)

pl <- ggplot(mtcars, aes(mpg, wt)) + geom_point()

gpl <- ggplotly(pl) # convert the ggplot into a ggplotly

print(gpl)

# https://plotly.com/ggplot2/



