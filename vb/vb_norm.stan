data {
  int<lower=1> N;
  vector<lower=0>[N] length;
  vector<lower=0>[N] age;
  vector<lower=0>[4] prior_sds;
  int<lower=0, upper=1> prior_only;
}
parameters {
  real<lower=0> k;
  real<lower=0> linf;
  real<lower=0> sigma;
  real t0;
}
transformed parameters {
  vector[N] predicted_length;
  for (i in 1:N) {
    // record expected length for visualization and to use below:
    predicted_length[i] = linf * (1 - exp(-k * (age[i] - t0)));
  }
}
model {
  // priors:
  k ~ normal(0, prior_sds[1]);
  linf ~ normal(0, prior_sds[2]);
  t0 ~ normal(0, prior_sds[3]);
  sigma ~ student_t(3, 0, prior_sds[4]);
  // data likelihood:
  if (!prior_only) { // enable prior predictive simulations
    length ~ normal(predicted_length, sigma);
  }
}
generated quantities {
  vector[N] length_sim; // for posterior predictive simulations
  vector[N] log_lik; // for ELPD calculations
  for (i in 1:N) {
    length_sim[i] = normal_rng(predicted_length[i], sigma);
    log_lik[i] = normal_lpdf(length[i] | predicted_length[i], sigma);
  }
}
