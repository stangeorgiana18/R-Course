df1 <- read.csv('winequality-red.csv', sep = ';')
df2 <- read.csv('winequality-white.csv', sep = ';')

#print(head(df1))

# apply lable to the df
#df1$label <- 'red'
#df2$label <- 'white'

df1$label <- sapply(df1$pH, function(x){'red'}) # for every row in the pH column return red and assign that to the label column
df2$label <- sapply(df2$pH, function(x){'white'}) 

# bind the 2 df into 1
#wine <- rbind(df1, df2) # or like that without dplyr lib

library(dplyr)

wine <- bind_rows(df1, df2) # by rows bcs they have the same columns 

#print(str(wine))

library(ggplot2)

pl <- ggplot(wine, aes(residual.sugar)) + geom_histogram(aes(fill = label), color = 'black') + scale_fill_manual(values = c('red','white')) + theme_bw()
print(pl) # the red wine has a lower residual sugar count (also there are more white wine samples than red)


pl <- ggplot(wine, aes(citric.acid)) + geom_histogram(aes(fill = label), color = 'black') + scale_fill_manual(values = c('red','white')) + theme_bw()
print(pl)


pl <- ggplot(wine, aes(alcohol)) + geom_histogram(aes(fill = label), color = 'black') + scale_fill_manual(values = c('red','white')) + theme_bw()
print(pl)

pl <- ggplot(wine, aes(citric.acid, residual.sugar)) + geom_point(aes(color = label), alpha = 0.5, size = 4) + scale_color_manual(values = c('red', 'white')) + theme_dark()
print(pl) # there's much noise/overlap

pl <- ggplot(wine, aes(volatile.acidity, residual.sugar)) + geom_point(aes(color = label), alpha = 0.5, size = 4) + scale_color_manual(values = c('red', 'white')) + theme_dark()
print(pl)

clus.data <- select(wine, -label) 
# or clus.data <- wine[, 1:12]
#print(head(clus.data))

wine.cluster <- kmeans(clus.data, 2, nstart = 20)
print(wine.cluster$centers) # the center value for each feature for each cluster

# evaluate the clusters
print(table(wine$label, wine.cluster$cluster))

