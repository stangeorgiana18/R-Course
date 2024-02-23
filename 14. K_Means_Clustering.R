# cluster unlabeled data in unsupervised ML algorithm
# attempt to group similar clusters together in your data

# GOAL: divide data into distinct groups such that observations within each group are similar

# KMC doesn't take in labels, it just takes in the features and tries to create clusters based on the k value
# labels are only used to evaluate the algorithm

library(ISLR)

print(head(iris))

library(ggplot2)

pl <- ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point(size = 4)
print(pl)

set.seed(101)

# 3 --> how many cluster centers you actually expect
# usually you don't know how many labels you would expect
# nstart --> the number of random starts you can do

iris.cluster <- kmeans(iris[, 1:4], 3, nstart = 20)
print(iris.cluster)

print(table(iris.cluster$cluster, iris$Species))

# CLUSTER VISUALIZATION

library(cluster)

# plot against 2 features tht explain the most variability
pl <- clusplot(iris, iris.cluster$cluster, color = T, shade = T, labels = 0, lines = 0)
print(pl)


