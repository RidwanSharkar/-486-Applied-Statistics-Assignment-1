## NAME: Ridwan Sharkar
## NetID: rrs126
import numpy as np
import matplotlib.pyplot as plt

#========================================================================================

def f(k):
    return k**1.5

n_points = 1000000                              # No. of random points to generate
k_min, k_max = 1, 10000                         # Range of k
f_max = f(k_max)                                # Max value of f(k) within range      

# Generate
k_random = np.random.uniform(k_min, k_max, n_points)
y_random = np.random.uniform(0, f_max, n_points)

# Count
points_under_curve = np.sum(y_random < f(k_random))

# Calculate Area
area = (k_max - k_min) * f_max * (points_under_curve / n_points)
print(f"MC Estimated Sum: {area:.2f}")

#========================================================================================

# Visual
plt.figure(figsize=(10, 6))
plt.scatter(k_random, y_random, alpha=0.1, s=1)
k = np.linspace(k_min, k_max, 1000)
plt.plot(k, f(k), 'r-', lw=2)
plt.title("MC Estimation of Sum(k^1.5)")
plt.xlabel("k")
plt.ylabel("k^1.5")
plt.show()