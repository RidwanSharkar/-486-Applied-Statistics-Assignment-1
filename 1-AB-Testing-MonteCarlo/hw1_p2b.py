## NAME: Ridwan Sharkar
## NetID: rrs126
import numpy as np 

#========================================================================================

# Initialize variables 
my_wins = 4 
my_ties = 2 
my_loss = 1 

# Calculate total games
n_games = my_wins + my_ties + my_loss

# Calculate new points
my_point = my_wins * 2 + my_loss * (-1)

n_sim = 2000 

all_results = np.zeros(n_sim)  # Create an array of zeros 

for cur_sim in range(n_sim): 
    outcome = np.random.choice([-1, 0, 2], n_games, p=[1/3, 1/3, 1/3])     # Randomly sample from [-1, 0, 2]
    all_results[cur_sim] = np.sum(outcome)

# Simulated p-value 
print("Simulated p-value:")
print(np.mean(all_results >= my_point))