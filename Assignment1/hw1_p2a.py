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

# Calculate points
my_point = my_wins * 1 + my_loss * (-1)

n_sim = 2000

all_results = np.zeros(n_sim)                           # Create an array filled with zeros

for cur_sim in range(n_sim):
    outcome = np.random.choice([-1, 0, 1], n_games)     # Randomly sample from [-1, 0, 1]
    all_results[cur_sim] = np.sum(outcome)

pValue = np.mean(all_results >= my_point)

# Simulated p-value
print("Simulated p-value:")
print(pValue)
