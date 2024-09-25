## NAME: Ridwan Sharkar
## NetID: rrs126
import numpy as np

#========================================================================================

n_sim = 3000
my_viewsA = 60
my_viewsB = 31
my_viewsC = 41

# Calculate the total number of views
all_views = my_viewsA + my_viewsB + my_viewsC
n_impsA = 160
n_impsB = 120
n_impsC = 150

# Calculate the total number of impressions
all_imps = n_impsA + n_impsB + n_impsC

# Calculate the CTRs for each title
my_CTRs = [my_viewsA / n_impsA, my_viewsB / n_impsB, my_viewsC / n_impsC]

# Calculate the test statistic
my_deviation = max(my_CTRs) - np.mean(my_CTRs)

# Initialize an array to store the results
all_results = np.zeros(n_sim)

# Begin simulation
for cur_sim in range(n_sim):
        
    pool = np.array([1]*all_views + [0]*(all_imps - all_views))         # Create the pool of all impressions
    np.random.shuffle(pool)
    
    impsA = np.random.choice(pool, n_impsA, replace=False)              # Sample for title A
    viewsA = np.sum(impsA)
    
    pool_BC = pool[~np.isin(pool, impsA)]                              # Update the pool for titles B and C
    
    impsB = np.random.choice(pool_BC, min(len(pool_BC), n_impsB), replace=False)          # **Sample for title B
    viewsB = np.sum(impsB)
    
    viewsC = all_views - viewsA - viewsB                                # Compute views for title C
    
    CTRs = [viewsA / n_impsA, viewsB / n_impsB, viewsC / n_impsC]       # Calculate the CTRs for this simulation
    
    deviation = max(CTRs) - np.mean(CTRs)                               # Calculate the test statistic for this simulation
    
    all_results[cur_sim] = deviation                                    # Store the result
    
# Compute the p-value
p_value = np.mean(all_results >= my_deviation)                          

print("Simulated p-value:")
print(p_value)