# neural nets -- a lpt of times used for computer image recognition

library(ggplot2)

bank <- read.csv('bank_note_data.csv')

print(head(bank))
print(str(bank))

#print(ggplot(bank, aes(Image.Var, Entropy)) + geom_point(aes(color = Image.Skew)) + stat_smooth())

library(caTools)
set.seed(101)

split <- sample.split(bank$Class, SplitRatio = 0.7)
train <- subset(bank, split == T)
test <- subset(bank, split == F)

library(neuralnet)

print(names(train))
nn <- neuralnet(Class ~ Image.Var + Image.Skew + Image.Curt + Entropy, data = train, hidden = 10, linear.output = FALSE)

#plot(nn)

predicted.nn.values <- compute(nn, test[1:4])
print(head(predicted.nn.values$net.result))

# we did not normalize our data since columns were relatively at the same order of magnitude
# you should normalize it if there's a wide range between min and max values in the columns features

predictions <- sapply(predicted.nn.values$net.result, round)
print(head(predictions))

print(table(predictions, test$Class)) # notice we predicted perfectly


# check our results against a randomForest model

library(randomForest)
set.seed(101)
bank$Class <- factor(bank$Class)
split <- sample.split(bank$Class, SplitRatio = 0.7)

train <- subset(bank, split == T)
test <- subset(bank, split == F)

rf.model <- randomForest(Class ~ . , data = train)

#print(rf.model)

rf.pred <- predict(rf.model, test)

print(table(rf.pred, test$Class)) # did very well, but not perfect

