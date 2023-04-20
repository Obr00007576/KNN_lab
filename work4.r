train_data <- read.csv('train.csv', head = TRUE)
train_data <- train_data[, -1]
train_data <- train_data[, -3]
train_data <- train_data[, -7]
train_data <- train_data[, -8]
train_data <- train_data[, -4]
train_data <- train_data[-62, ]
train_data$Sex <- ifelse(train_data$Sex == "male", 1, 2)
train_data$Embarked <- as.numeric(factor(train_data$Embarked, levels = c("S", "C", "Q")))

test_data <- read.csv('test.csv', head = TRUE)
test_data <- test_data[, -1]
test_data <- test_data[, -2]
test_data <- test_data[, -3]
test_data <- test_data[, -5]
test_data <- test_data[, -6]
test_data$Sex <- ifelse(test_data$Sex == "male", 1, 2)
test_data$Embarked <- as.numeric(factor(test_data$Embarked, levels = c("S", "C", "Q")))

model <- train.kknn(Survived ~ ., data = train_data, kmax = 30)
pred <- as.data.frame(predict(model, test_data))
colnames(pred) <- c("Survived")
write.csv(pred, "./Titanic_prediction_from_test.csv")