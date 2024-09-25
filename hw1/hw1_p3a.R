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

n_sim = 3000

my_viewsA = 60
my_viewsB = 31
my_viewsC = 41
all_views = my_viewsA + my_viewsB + my_viewsC

n_impsA = 160
n_impsB = 120
n_impsC = 150
all_imps = n_impsA + n_impsB + n_impsC

my_CTRs = c(my_viewsA/n_impsA, my_viewsB/n_impsB, my_viewsC/n_impsC)

my_deviation = max(my_CTRs) - mean(my_CTRs)

all_results = rep(0, n_sim)

for (cur_sim in 1:n_sim){
  
  pool = c(rep(1, all_views), rep(0, all_imps - all_views))
  impsA = sample(pool, n_impsA, replace=FALSE)
  viewsA = sum(impsA)
  
  pool_BC = ____FILL IN______
  impsB = ___FILL IN_____
  viewsB = ____FILL IN_____
  
  viewsC = ___FILL IN____
  
  CTRs = c(viewsA/n_impsA, viewsB/n_impsB, viewsC/n_impsC)

  deviation = ____FILL IN ___
  all_results[cur_sim] = ___FILL IN_____
  
}

print("Simulated p-value:")
print( ___FILL IN____ )