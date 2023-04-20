library(mlbench)
library(caret)
library(class)
library(kernlab)
set.seed(333)

TicTacToe <- read.table('./Tic_tac_toe.txt', sep = ",")

for(n in 1:9)
{
    TicTacToe[, c(n)] <- as.numeric(factor(TicTacToe[, c(n)], levels = c("o", "x", "b")))
}
train_sizes <- seq(0.1, 0.9, 0.05)
error_list <- list()
for(n in train_sizes)
{
    train_index <- sample(nrow(TicTacToe), n * nrow(TicTacToe))
    train_data <- TicTacToe[train_index, ]
    test_data <- TicTacToe[-train_index, ]
    model <- as.data.frame(knn(train_data[, -10], test_data[, -10], train_data[, 10], k = 5))
    error_rate <- sum(model[, c(1)] != test_data[, c(10)]) / nrow(test_data)
    error_list[[as.character(n)]] <- error_rate
}

plot(train_sizes*nrow(TicTacToe), sapply(error_list, unlist), type = "b", xlab = "Sample size", ylab = "Test error")
title("Tic_tac_toe")

data(spam)

train_sizes <- seq(0.1, 0.9, 0.05)
error_list <- list()
for(n in train_sizes)
{
    train_index <- sample(nrow(spam), n * nrow(spam))
    train_data <- spam[train_index, ]
    test_data <- spam[-train_index, ]
    model <- as.data.frame(knn(train_data[, -58], test_data[, -58], train_data[, 58], k = 5))
    error_rate <- sum(model[, c(1)] != test_data[, c(58)]) / nrow(test_data)
    error_list[[as.character(n)]] <- error_rate
}

plot(train_sizes*nrow(spam), sapply(error_list, unlist), type = "b", xlab = "Sample size", ylab = "Test error")
title("Spam")