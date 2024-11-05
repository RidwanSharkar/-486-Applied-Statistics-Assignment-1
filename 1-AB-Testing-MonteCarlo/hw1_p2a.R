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


my_wins = 4
my_ties = 2
my_loss = 1
n_games = my_wins + my_ties + my_loss

my_point = 1*my_wins + 0*my_ties + (-1)*my_loss

n_sim = 2000

all_results = rep(0, n_sim)

for (cur_sim in 1:n_sim){
  
  outcome = sample(c(-1, 0, 1), n_games, replace=TRUE)
  
  all_results[cur_sim] = ____FILL IN_____
  
}

print("Simulated p-value:")
print( ___FILL IN____ )

