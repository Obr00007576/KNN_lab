library(kknn)
set.seed(333)

train_data <- read.table("svmdata4.txt", colClasses=c("NULL", rep("double", 2), "factor"), skip = 1)
colnames(train_data) <- c("V1", "V2", "Color")

test_data <- read.table("svmdata4test.txt", colClasses=c("NULL", rep("double", 2), "factor"), skip = 1)
colnames(test_data) <- c("V1", "V2", "Color")



model <- train.kknn(Color ~ ., data = train_data, kmax = 30)
pred <- as.data.frame(predict(model, test_data[, -3]))
plot(test_data$V1, test_data$V2, pch=21, bg=c("red","green") [unclass(pred[, c(1)])], main="My train data")
error_rate <- sum(pred[, c(1)] != test_data[, c(3)]) / nrow(test_data)
print(paste("Error rate:", error_rate))