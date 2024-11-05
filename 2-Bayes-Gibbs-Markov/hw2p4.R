## NAME: 
## NetID:
##
## Instructions:
##
## Complete the following R program by
## filling in lines labled __FILL IN___
## 
## Each ___FILL IN____ should be only one line but you 
## may add additional lines of code if you think it is 
## necessary. 
##

# Define the matrices A_1, A_2, A_3, A_4
A1 <- matrix(c(0, 0, 0, 0.16), nrow=2, byrow = TRUE)
A2 <- matrix(c(0.2, -0.26, 0.23, 0.22), nrow=2, byrow = TRUE)
A3 <- ___FILL IN____
A4 <- ___FILL IN____

# Define the vectors b_1, b_2, b_3, b_4
b1 <- ___FILL IN____
b2 <- ___FILL IN____
b3 <- ___FILL IN____
b4 <- ___FILL IN____

# Set the number of samples
n <- 100000

# Initialize the matrix to store X_t values
X <- matrix(0, nrow=n, ncol=2)
# Set initial value of X
X[1,] <- c(0, 0)

# Define the probabilities for theta
prob_theta <- c(0.01, 0.07, 0.07, 0.85)

# Run the Markov Chain for n iterations
set.seed(123) # for reproducibility
for(t in 2:n){
  # Sample theta_t based on the given probabilities
  theta_t <- sample(1:4, 1, prob=prob_theta)
  
  # Compute X_t+1 based on the sampled theta_t
  if(theta_t == 1){
    X[t,] <- A1 %*% X[t-1,] + b1
  } else if(theta_t == 2){
    X[t,] <- ___FILL IN____
  } else if(theta_t == 3){
    X[t,] <- ___FILL IN____
  } else if(theta_t == 4){
    X[t,] <- ___FILL IN____
  }
}

# Plot the generated Markov chain
plot(X[,1], X[,2],cex = 0.05, asp = 0.5)
