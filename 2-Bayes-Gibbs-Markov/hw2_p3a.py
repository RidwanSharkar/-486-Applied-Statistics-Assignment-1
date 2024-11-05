import pandas as pd
import numpy as np

games = pd.read_csv("premier.csv")
n_games = len(games)

teams = pd.unique(games.iloc[:, 0].append(games.iloc[:, 1]))
n_teams = len(teams)

ratings = {}
all_ratings = {team: [] for team in teams}

n_MCMC = 1100
n_Burn = 100

SAprob = 0.6
SBprob = 0.75
SCprob = 0.9
ABprob = 0.6
ACprob = 0.75
BCprob = 0.6
sameprob = 0.5  # Should always be 0.5

for team in teams:
    ratings[team] = 1

for j in range(n_MCMC):
    for cur_team in teams:
        weights = np.array([0.4, 0.3, 0.2, 0.1])

        for i in range(n_games):
            if cur_team != games.iat[i, 0] and cur_team != games.iat[i, 1]:
                continue
            opponent_index = 1 if cur_team == games.iat[i, 0] else 0
            cur_index = 0 if opponent_index == 1 else 1
            cur_team_won = cur_index == 0
            opponent_team = games.iat[i, opponent_index]
            opponent_rating = ratings[opponent_team]
            
            # A series of if else conditions to calculate weights
            ## cur_team won
            if cur_team_won:
                #opponent is tier S
                if opponent_rating == 1: weights *= [SAprob, ABprob, BCprob, 1]
                #opponent is tier A
                elif opponent_rating == 2: weights *= [SAprob, sameprob, ABprob, BCprob]
                #opponent is tier B
                elif opponent_rating == 3: weights *= [SBprob, ABprob, sameprob, BCprob]
                elif opponent_rating == 4: weights *= [SCprob, ACprob, BCprob, sameprob]
            ## cur_team won
            else:
                if opponent_rating == 1: weights *= [sameprob, 1-ABprob, 1-BCprob, 0]
                elif opponent_rating == 2: weights *= [1-SAprob, sameprob, 1-ABprob, 1-BCprob]
                elif opponent_rating == 3: weights *= [1-SBprob, 1-ABprob, sameprob, 1-BCprob]
                elif opponent_rating == 4: weights *= [1-SCprob, 1-ACprob, 1-BCprob, sameprob]
        
        # normalize the weights 
        weights /= np.sum(weights)

        # randomly sample a rating
        ratings[cur_team] = np.random.choice([1, 2, 3, 4], p=weights)
        
        if j > n_Burn:
            all_ratings[cur_team].append(ratings[cur_team])

for cur_team in teams:
    print(f"Posterior rating for {cur_team}")
    post_rate = pd.value_counts(all_ratings[cur_team], normalize=True).sort_index()
    print(post_rate)
    print(f"Posterior mean rating: {np.sum(post_rate.index * post_rate.values)}")
    print("----------")
