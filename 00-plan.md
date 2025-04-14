---
title: "An introduction to applied Bayesian data analysis for ecologists"
output:
  html_document:
    toc: true
---

# Objectives

1. Develop an intuition for Bayes' theorem, how a Bayesian approach fundamentally differs from a frequentist approach, and when using a Bayesian approach is particularly advantageous.

2. Understand the principle behind MCMC (Markov chain Monte Carlo) sampling. Become familiar with the concepts of chain convergence and MCMC tuning. Develop a high-level understanding of Hamiltonian MCMC.

3. Learn to fit pre-packaged Bayesian regression models with brms. Become familiar with the concepts of posterior predictive checking and manipulating posterior samples to calculate posterior probabilities.

4. Learn how to assess the relative contribution of priors vs. the data. Learn the difference between weakly informative and informative priors. Learn what some common choices of weakly informative priors are. Become familiar with prior predictive checking.

5. Learn the basics of Stan model syntax and how to interact with Stan in R.

6. Become familiar with how the pieces fit together into a Bayesian workflow.

7. Throughout, gain some familiarity with several useful tools built around Stan and R (e.g., rstan, brms, bayesplot, loo, tidybayes).

6. Leave with some ideas for where to find more information.

# Plan

## Day 1

1. Introduction to probability, Bayes' theorem, when to go Bayesian
  - Slides: an introduction to Bayes' theorem and Bayesian updating
  - Slides: frequentist vs. Bayesian inference interpretation
  - Slides: went to go Bayes: advantages and disadvantages
  - *All together exercise*: small world Bayesian updating
  - Rmd: manipulating and summarizing the posterior various ways

2. Demystifying MCMC (group exercises and online demo)
  - Slides: MCMC intro
  - Rmd: run through Metropolis MCMC in R and plot the chain together
  - *Individual exercise*: tuning MCMC
  - Hamiltonian and NUTS slides
  - *Individual exercise*: play with online demo of Hamiltonian and NUTS MCMC

3. Convergence and MCMC diagnostics
  - Slides: MCMC diagnostics part 1
  - *Small groups exercise*: MCMC diagnostics
  - Slides: divergent transitions
  - Rmd: divergent transitions
  
## Day 2

4. Posterior predictive checking
  - Slides: posterior predictive checking
  - *Small groups exercise*: posterior predictive checking

5. Priors (interactive code, slides, and discussion)
  - Slides: goals of priors, types of priors
  - *Small groups exercise*: experiment with an interactive prior demo
  - Slides: prior predictive checks
  - Rmd: brms priors and prior predictive checks
  
6. Introduction to applied Bayesian modeling
  - Rmd: 04-brms-basic.Rmd
    - fit a regression model with brms 
    - inspect MCMC chains for convergence
    - summarize MCMC chains to quantify the posterior
    - first intro to posterior predictive checking
    - making probabilistic statements by manipulating the  posterior samples

## Day 3

6. Introduction to Stan code and rstan
  - Slides: Stan model syntax
  - Rmd: regression with a Stan model
  - understand when/why you might use brms vs. custom Stan code
  - look at the syntax and the code sections of a Stan model
  - call the Stan model from R
  - extract the posterior samples and make similar plots as before
  - fit an length-age growth model to groundfish data and summarize the output

7. Leave-one-out cross validation, log scores, and ELPD
  - Slides: cross-validation concepts and terms
  - Rmd: ELPD + LOO
  
## Day 4
  
7. Putting it all together: Bayesian workflow
  - discuss why and what the suggested steps are
  - *All together exercise*: work through an example as a group
  - *Small groups exercise*: work through an example as an exercise

8. Applied Bayesian modeling standards, words of wisdom, and resources (slides)
  - standards for iterations, warmup, chains, and assessing convergence
  - Stan warnings to watch out for
  - how to describe the models
  - what to report in a paper
  - good books and online resources
