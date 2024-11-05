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



## For a given beta, lambda, computes objective value
##
## sum_i  -Yi Xi^T beta + log(1 + exp(Xi^T beta)) + lambda |beta|_2^2

objectiveValue <- function(X, Y, beta, lambda){

    obj = _______FILL IN________

    return(obj)

}


## Gradient descent for ridge regularized logistic regression
##
## computes
## argmin_beta  sum_i  - Yi Xi^T beta + log(1 + exp(Xi^T beta)) + lambda |beta|_2^2
##
##

logisticReg_gradientDescent <- function(X, Y, lambda) {
    n = nrow(X)
    p = ncol(X)

    beta_prev = rep(0, p)
    maxiter = 100000

    stepsize = .01/n

    for (t in 1:maxiter){
        xb = X %*% beta_prev

        ## 
        ## Incorporate the gradient of lambda |beta|_2^2 
        ##
        ## use the following two facts:
        ## 1. (gradient of f+g) = (gradient of f) + (gradient of g)
        ## 2. gradient of || x ||_2^2 = 2 x  for a vector x

        gradient = - t(X) %*% (Y - exp(xb)/(1 + exp(xb)) ) + _____FILL IN_____

        beta_next = beta_prev - stepsize * gradient


        if (norm(gradient, '2') < 1e-4) {
            print(paste("Converged at iteration: ", t))
            break
        } else beta_prev = beta_next

        cur_obj = objectiveValue(X, Y, beta_next, lambda)

        if (t %% 5000 == 0)
            print(paste("Current iter: ", t, " Current objective value: ", cur_obj))

        if (t == maxiter){
            print("Reached maxiter; did not converge.")
        }
    }

    print(paste("Final gradient norm: ", norm(gradient, '2')))
    return(beta_next)
}


################
## Using logistic regression
##
## We look at counties in TX, NY, PA, CA and use socio-demographic features
## to predict whether the county is in Texas or not.

library(dplyr)
library(magrittr)

votes = read.csv("votes.csv")

votes = votes %>% filter(state_abbr %in% c("TX", "NY", "PA", "CA")) %>% mutate(texas= state_abbr == "TX")
n = nrow(votes)

set.seed(2)
votes = votes[sample(1:n, n), ]


features = c("white", "hispanic", "poverty",
             "bachelor", "highschool", "age18under",
             "female", "landarea", "income", "asian",
             "population2014", "density", "household_size",
             "veteran", "age65plus", "black",
             "immigrant")

Y = votes$texas
X = cbind(rep(1, n), as.matrix(votes[, features]))
p = ncol(X)

for (j in 2:p){
    X[, j] = (X[, j] - mean(X[, j]))/sd(X[, j])
}

n_learn = 200
n_test = 200

Y_test = Y[1:n_test]
Y_learn = Y[(n_test+1):(n_test+n_learn)]

X_test = X[1:n_test, ]
X_learn = X[(n_test+1):(n_test+n_learn), ]

## Using our functions to compute logistic regression

beta_lambda = _____FILL IN________


## Making predictions on test data and computing the
## misclassification error

Ypred = (X_test %*% beta_lambda > 0)

print("Test misclassification error:")
print(mean( Y_test != Ypred ))
