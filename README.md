# Determining the impact of household income in the U.S. 2016 presidential elections with Bayesian Analysis
## #Elections #BayesianAnalysis

This project address the question if votes varied significantly across the 50 states based on the median household income 
during the U.S. presidential elections of 2016. A **hierarchical Bayesian model** is used to capture individual differences and group-level tendencies. 

This research brings insight as to why individual preferences could differ from the group-level tendencies. 
Accordingly, it has been noted that richer people are more likely to vote for Republican candidates while poorer people are more inclined to vote for Democratic candidates.  However, in recent decades, we can observe the opposite: poorer states have voted for conservative Republicans while rich states favor liberal Democrats. 

The model implemented **Markov Chain Monte Carlo (MCMC)** to generate a sequence of samples from the posterior distribution of the parameters. 

The repo is divided in:

(i) Part 1 proposes an over-arching distribution: the model puts each state's estimated probability of voting for the Republican candidate 
under a distribution of state income categories. State income categories were classified as poor, middle, mid-upper and rich. 

(ii) Part 2 proposes a Logistic Regression: we are interested in estimating the probability of getting a Republican vote based on the income category of the state. Income category is a nominal predictor (poor, middle, mid-upper, rich). This model focuses on descriptions at the group level, not at the individual 
level. 

Notes:
- Each folder contains a pdf with a theoretical explanation of the model and the results. 
- The code to compute the model was built in R, using **JAGS package** which can be downloaded [here](https://sourceforge.net/projects/mcmc-jags/files/JAGS/4.x/Mac%20OS%20X/JAGS-4.3.0.dmg/download).
