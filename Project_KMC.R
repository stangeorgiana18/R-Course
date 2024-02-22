df1 <- read.csv('winequality-red.csv', sep = ';')
df2 <- read.csv('winequality-white.csv', sep = ';')

#print(head(df1))

df1$label <- 'red'
df2$label <- 'white'


# bind the 2 df into 1
library(dplyr)

wine <- bind_rows(df1, df2) # by rows bcs they have the same columns 

#print(str(wine))

library(ggplot2)

pl <- ggplot(wine, aes(residual.sugar)) + geom_histogram(aes(fill = label), color = 'black') + scale_fill_manual(values = c('red','white')) + theme_bw()
print(pl)


pl <- ggplot(wine, aes(citric.acid)) + geom_histogram(aes(fill = label), color = 'black') + scale_fill_manual(values = c('red','white')) + theme_bw()
print(pl)


pl <- ggplot(wine, aes(alcohol)) + geom_histogram(aes(fill = label), color = 'black') + scale_fill_manual(values = c('red','white')) + theme_bw()
print(pl)

pl <- ggplot(wine, aes(citric.acid, residual.sugar)) + geom_point(aes(color = label), alpha = 0.5, size = 4) + scale_color_manual(values = c('red', 'white')) + theme_dark()
print(pl)

pl <- ggplot(wine, aes(volatile.acidity, residual.sugar)) + geom_point(aes(color = label), alpha = 0.5, size = 4) + scale_color_manual(values = c('red', 'white')) + theme_dark()
print(pl)

clus.data <- select(wine, -label)
#print(head(clus.data))

wine.cluster <- kmeans(clus.data, 2, nstart = 20)
print(wine.cluster)

# evaluate the clusters
print(table(wine$label, wine.cluster$cluster))

