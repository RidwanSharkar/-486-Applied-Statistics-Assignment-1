## NAME: 
## NetID:
##
## Instructions:
##
## Complete the following R program by
## filling in lines labled __FILL IN___
## 
## Each ___FILL IN____ in this file may correspond to multiple lines.
##

games = read.csv("premier.csv")
n_games = nrow(games)

teams = unique(c(games[, 1], games[, 2]))
n_teams = length(teams)

ratings = list()
all_ratings = list()

## Arbitrarily initialization
for (cur_team in teams){
  ratings[[cur_team]] = rep(1, n_teams)
  all_ratings[[cur_team]] = c()
}

n_MCMC = 1100
n_Burn = 100

SAprob = 0.6
SBprob = 0.75
SCprob = 0.9

ABprob = 0.6
ACprob = 0.75

BCprob = 0.6
sameprob = 0.5 ## Should always be 0.5

for (j in 1:n_MCMC){
  
  for (cur_team in teams){
    
    weights = _____FILL IN______
    
    for (i in 1:n_games){
      if (cur_team != games[i, 1] && cur_team != games[i, 2]) {
        next
      } else if (cur_team == games[i, 1] && ratings[[ games[i, 2] ]]  == 1){
        ## cur_team won, opponent is tier S

        ___FILL In____

        
      } else if (cur_team == games[i, 1] && ratings[[ games[i, 2] ]] == 2){
        ## cur_team won, opponent is tier A

        __FILL In___
        
        
      } else if (cur_team == games[i, 1] && ratings[[ games[i, 2] ]] == 3){
        ## cur_team won, opponent is tier B
        
        ___FILL IN____
        
        
      } else if (cur_team == games[i, 1] && ratings[[ games[i, 2] ]] == 4){
        ## cur_team won, opponent is tier C
        
        ____FILL IN____
        
        
      } else if (cur_team == games[i, 2] && ratings[[ games[i, 1] ]] == 1){
        ## cur_team lost, opponent is tier S
        
        ___FILL IN___
        
        
      } else if (cur_team == games[i, 2] && ratings[[ games[i, 1] ]] == 2){
        ## cur_team lost, opponent is tier A
        
        ____FILL IN______
        
        
      } else if (cur_team == games[i, 2] && ratings[[ games[i, 1] ]] == 3){
        ## cur_team lost, opponent is tier B
        
        ____FILL IN_____
        
        
      } else if (cur_team == games[i, 2] && ratings[[ games[i, 1] ]] == 4){
        ## cur_team lost, opponent is tier C
        
        _____FILL IN_____
        
        
      } 
      
    }
    
    weights = _____FILL IN_____
    
    ratings[[cur_team]] = _____FILL IN_____
    
    if (j > n_Burn){
      all_ratings[[cur_team]] = c(all_ratings[[cur_team]], ratings[[cur_team]])
    }
  }
}

for (cur_team in teams){
  print(paste("Posterior rating for", cur_team))
  post_rate = table(all_ratings[[ cur_team ]]) / (n_MCMC - n_Burn)
  print(post_rate)
  print(paste("Posterior mean rating:", sum(post_rate * c(1,2,3,4)) ) )
  print("----------")
}