## NAME:
## NetID:
##
## Instructions:
##
## Complete the following R program by
## filling in lines labled __FILL IN___
##
## Each ___FILL IN____ could be multiple lines.
##

movies = read.csv("movies.csv")
set.seed(4)
movies = movies[sample(1:nrow(movies), nrow(movies)), ]

library(dplyr)
library(magrittr)
library(lubridate)

## Remove movies whose budget is in the bottom 10 percentile.
## Remove movies whose runtime information is missing.

movies = movies %>% filter(budget > quantile(budget, 0.1)) %>%
    filter(!is.na(runtime))

## Create three new features:
## age -- how old the movie is in days
## title_len -- number of characters in the movie title
## log_budget -- log(budget)

movies$age = as.integer(mdy("10/12/2021") - ymd(movies$release_date))
movies$title_len = nchar(movies$title)
movies$log_budget = log(movies$budget)

features = c("Drama",
             "Action",
             "Comedy",
             "Horror",
             "log_budget",
             "runtime",
             "age",
             "title_len")

## predict vote_average using the above features
Y = movies$vote_average
X = movies[, features]

## ========== ##
## Making predictive models:

n = nrow(X)
p = ncol(X)

X = cbind(as.matrix(X), rep(1, n))

n_test = 500
n_learn = 1500

Y_test = Y[1:n_test]
Y_learn = Y[(n_test+1):(n_test+n_learn)]

X_test = X[1:n_test, ]
X_learn = X[(n_test+1):(n_test+n_learn), ]

K = 10 ## we require that n_learn is divisible by K
folds = matrix(1:n_learn, K)

validerr = matrix(0, K, 2)

for (k in 1:K){

    valid_ix = folds[k, ]
    train_ix = setdiff(1:n_learn, folds[k, ])

    X_valid = X_learn[valid_ix, ]
    X_train = X_learn[train_ix, ]

    Y_valid = Y_learn[valid_ix]
    Y_train = Y_learn[train_ix]

    n_valid = length(Y_valid)

    ## ============= ##
    ## Fit two separated linear regression
    ## one for Drama movies, one for non-Drama movies
    ##

    ## X_train[, 1] correspond to "Drama" indicator
    ixs = X_train[, 1] == 1

    ## remove "Drama" feature in the subset of data
    X_train1 = X_train[ixs, 2:(p+1)]
    X_train2 = X_train[!ixs, 2:(p+1)]

    Y_train1 = Y_train[ixs]
    Y_train2 = Y_train[!ixs]

    beta1 = ______FILL IN______

    beta2 = _____FILL IN______

    ixs = X_valid[, 1] == 1

    X_valid1 = X_valid[ixs, 2:(p+1)]
    X_valid2 = X_valid[!ixs, 2:(p+1)]

    Y_validpred = rep(1, n_valid)

    Y_validpred[ixs] = ____FILL IN_______
    Y_validpred[!ixs] = ____FILL IN_______

    validerr[k, 1] = mean( (Y_validpred - Y_valid)^2)

    ## ======== ##
    ## Fit linear regression on all data, with
    ## "Drama" as a 0/1 feature among the other features

    beta_all = _____FILL IN_____

    Y_validpred = ____FILL IN_____

    validerr[k, 2] = mean( (Y_validpred - Y_valid)^2)

}

mean_validerr = apply(validerr, 2, mean)

print(paste("Separated linreg validation error: ", round(mean_validerr[1], 3),
            "Single linreg validation error: ", round(mean_validerr[2], 3)))


## =========== ##
## Create final prediction using the best
## model on X_test, Y_test

if (mean_validerr[1] < mean_validerr[2]){

    ixs = X_learn[, 1] == 1





    ____FILL IN______






    Y_pred[ixs] = ____FILL IN_______
    Y_pred[!ixs] = ____FILL IN_________

} else {

    ___FILL IN_____

    Y_pred = ___FILL IN_________
}


## evaluate test error
test_error = sqrt( mean( (Y_test - Y_pred)^2 ) )
baseline_error = sqrt( mean( (Y_test - mean(Y_learn) )^2 ) )
print("Test Error vs Baseline Error")
print(c(test_error, baseline_error))


