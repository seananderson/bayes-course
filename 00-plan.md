---
title: An introduction to applied Bayesian data analysis for ecologists
output: html_document
---

# Objectives

1. Develop an intuition for Bayes' theorem, how a Bayesian approach fundamentally differs from a frequentist approach, and when using a Bayesian approach is particularly advantageous.

2. Understand the principle behind MCMC (Markov chain Monte Carlo) sampling. Become familiar with the concepts of chain convergence and MCMC tuning. Develop a high-level understanding of Hamiltonian MCMC.

3. Learn to fit pre-packaged Bayesian regression models with brms. Become familiar with the concepts of posterior predictive checking and manipulating posterior samples to calculate posterior probabilities.

4. Learn how to assess the relative contribution of priors vs. the data. Learn the difference between weakly informative and informative priors. Learn what some common choices of weakly informative priors are. Become familiar with prior predictive checking.

5. Learn the basics of Stan model syntax and how to interact with Stan in R.

6. Put together what we've learned into a full Bayesian workflow.

7. Throughout, become familiar with several useful tools around Stan and R (rstan, cmdstanr, bayesplot, loo, tidybayes).

6. Leave with some ideas for where to find more information.

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

<!-- day 1 -->

1. Introduction to probability, Bayes' theorem, when to go Bayesian
   (slides and group exercises)
  - an introduction to Bayes' theorem and Bayesian updating
  - frequentist vs. Bayesian inference interpretation
  - went to go Bayes: advantages and disadvantages
  - *All together exercise*: small world Bayesian updating
  - *Small groups exercise*: manipulating and summarizing the posterior various ways

2. Demystifying MCMC (group exercises and online demo)
  - run through Metropolis MCMC in R and plot the chain together
  - experiment with tuning MCMC
  - play with online demo of Hamiltonian and NUTS MCMC
  - *Small groups exercise*: tuning MCMC, play with online MCMC samplers

<!-- day 2 -->

3. Introduction to applied Bayesian modeling (group walk-through of code)
  - fit a regression model with brms 
  - inspect MCMC chains for convergence
  - summarize MCMC chains to quantify the posterior
  - learn about the concept of posterior predictive checking and experiment 
    with posterior protective checks
  - experiment with making probabilistic statements by manipulating the 
    posterior samples
  - *Small groups exercise*: posterior predictive checking and probabilistic statements
  
4. Convergence and MCMC diagnostics
  - understand what we're aiming for
  - visualizations
  - explain Rhat and the ESS metrics
  - divergent transitions, `adapt_delta`, `max_treedepth`
  - *Small group exercise*: diagnose (and fix) issues with a set of models

5. All about priors (interactive code, slides, and discussion)
  - experiment with an interactive simulation
  - talk about weakly informative priors, informative priors, and the 
    fallacy of uninformative priors
  - go through a series of examples and discuss reasonable prior strategies in
    small groups and together
  - introduce prior predictive checks
  - *Small groups exercise*: assessing prior influence and prior predictive checks

<!-- day 3 -->

6. Introduction to Stan code and rstan
  - understand when/why you might use brms vs. custom Stan code
  - look at the syntax and the code sections of a Stan model
  - call the Stan model from R
  - extract the posterior samples and make similar plots as before
  - introduce (via slides) how to do prior predictive and posterior predictive
    checks with custom Stan models; introduce how to do LOOIC calculations with
    custom Stan models
  - fit an length-age growth model to groundfish data and summarize the output
  - *Small groups exercises*: plot parameter posteriors and linear predictor,
     change a prior, code a prior predictive check, code a posterior predictive
     check
  - *Small groups exercise?*: build on growth model to assess one-stock assumption
  
<!-- day 4 -->
  
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
