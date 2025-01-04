---
title: An introduction to applied Bayesian data analysis for ecologists
output: html_document
---

# Objectives

1. Develop an intuition for Bayes' theorem, how a Bayesian approach fundamentally differs from a frequentist approach, and when using a Bayesian approach is particularly advantageous.

2. Understand the principle behind MCMC (Markov chain Monte Carlo) sampling. Become familiar with the concepts of chain convergence and MCMC tuning. Develop a high-level understanding of Hamiltonian MCMC.

3. Learn to fit pre-packaged Bayesian regression models with brms. Become familiar with the concepts of posterior predictive checking and manipulating posterior samples to calculate posterior probabilities.

4. Learn how to assess the relative contribution of priors vs. the data. Learn the difference between weakly informative and informative priors. Learn what some common choices of weakly informative priors are.

5. Learn the basics of Stan model syntax and how to interact with Stan in R.

6. Leave with some ideas for how to describe Bayesian models in publications and where to find more information.

### Stuff I want to make sure to cover that may not already be in the material:

- What is the fundamental difference between Bayesian and frequentist approaches?
   - Prior? No, not necessarily (although commonly, yes)
   - It's about how we view probability and frequency
   - Some good ideas here: https://stats.stackexchange.com/questions/22/bayesian-and-frequentist-reasoning-in-plain-english
   
- Software
   - brms vs. rstanarm vs. rethinking vs. Stan vs. rstan vs. cmdstanr vs. TMB/RTMB 

- Unspoken goal: empower people to work with Bayesian methods, give them the fundamentals to start from and an understanding of where to look to learn more

- ESS: Bulk and Tail - what they mean, how calculated, threshold guidance
- Split Rhat - what it means, how calculated, how different from non-split version, threshold guidance

- Develop slides on:
 - Hamiltonian, NUTS
 - ESS, Rhat
 - Bayesian workflow paper

- Develop exercises on:
 - Prior predictive and push forward checks
 - Somewhat more advanced Stan

# Plan

1. Introduction to probability, Bayes' theorem, when to go Bayesian
   (slides and group exercises)
  - an introduction to Bayes' theorom and Bayesian updating
  - frequentist vs. Bayesian inference interpretation
  - went to go Bayes: advantages and disadvantages

2. Demystifying MCMC (group exercises and online demo)
  - run through Metropolis MCMC in R and plot the chain together
  - experiment with tuning MCMC
  - play with online demo of Hamiltonian and NUTS MCMC

3. Introduction to applied Bayesian modeling (group walk-through of code)
  - fit a regression model with brms 
  - inspect MCMC chains for convergence
  - summarize MCMC chains to quantify the posterior
  - learn about the concept of posterior predictive checking and experiment 
    with posterior protective checks
  - experiment with making probabilistic statements by manipulating the 
    posterior samples

4. Priors, priors, and more priors (interactive code, slides, and discussion)
  - experiment with an interactive simulation
  - talk about weakly informative priors, informative priors, and the 
    fallacy of uninformative priors
  - go through a series of examples and discuss reasonable prior strategies in
    small groups and together

5. Introduction to Stan code and rstan (group walk-through of code)
  - look at the syntax and the code sections of a Stan model
  - call the Stan model from R
  - extract the posterior samples and make similar plots as before
  - fit a population-growth time series model in Stan if there is time

6. Applied Bayesian modeling standards, words of wisdom, and resources (slides)
  - standards for iterations, warmup, chains, and assessing convergence
  - Stan warnings to watch out for
  - how to describe the models
  - what to report in a paper
  - good books and online resources
