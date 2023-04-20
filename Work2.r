library(mlbench)
library(kknn)
set.seed(333)
data(Glass)

my_data = df <- data.frame(RI = 1.516, Na = 11.7, Mg = 1.01, Al = 1.19, Si = 72.59, K = 0.43, Ca = 11.44, Ba = 0.02, Fe = 0.1)

train_index <- sample(nrow(Glass), 0.7 * nrow(Glass))
train_data <- Glass[train_index, ]
test_data <- Glass[-train_index, ]



k <- seq(1, 100, 1)
error_list <- list()
for(n in k)
{
    model <- as.data.frame(knn(train_data[, -10], test_data[, -10], train_data[, 10], k = n))
    error_rate <- sum(model[, c(1)] != test_data[, c(10)]) / nrow(test_data)
    error_list[[as.character(n)]] <- error_rate
}
plot(k, sapply(error_list, unlist), type = "b", xlab = "k", ylab = "Test error")
title("Glass")

error_list <- list()
kern <- c("rectangular", "triangular", "epanechnikov", "biweight", "triweight", "cos", "inv", "gaussian", "rank", "optimal")
for(n in kern)
{
    model <- train.kknn(Type ~ ., data = train_data, kmax = 20, kernel = n)
    pred <- as.data.frame(predict(model, test_data[, -10]))
    error_rate <- sum(pred[, c(1)] != test_data[, c(10)]) / nrow(test_data)
    error_list[[as.character(n)]] <- error_rate
}
barplot(unlist(error_list), names.arg = kern, xlab = "Kernel Type", ylab = "Error rate", main = "KNN Kernel Comparison")

model <- as.data.frame(knn(train_data[, -c(10)], test_data[, -c(10)], train_data[, 10], k = 7))
standard_error <- sum(model[, c(1)] != test_data[, c(10)]) / nrow(test_data)

deleted_col <- seq(1, 9, 1)
error_list <- list()
for(i in deleted_col)
{
    model <- as.data.frame(knn(train_data[, -c(10, i)], test_data[, -c(10, i)], train_data[, 10], k = 7))
    error_rate <- sum(model[, c(1)] != test_data[, c(10)]) / nrow(test_data)
    error_list[[as.character(i)]] <- abs(error_rate - standard_error)
}
barplot(unlist(error_list), names.arg = deleted_col, xlab = "Deleted column", ylab = "Error rate - Standard error rate", main = "KNN Kernel Comparison")

model <- train.kknn(Type ~ ., data = train_data, kmax = 20, kernel = "triweight")
my_data = df <- data.frame(RI = 1.516, Na = 11.7, Mg = 1.01, Al = 1.19, Si = 72.59, K = 0.43, Ca = 11.44, Ba = 0.02, Fe = 0.1)
pred <- as.data.frame(predict(model, my_data))
print(paste("Predicted type:", pred))
