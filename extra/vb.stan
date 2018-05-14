data {
  int<lower=1> N;
  vector[N] length;
  vector[N] age;

  int<lower=1> N_pred;
  vector<lower=0>[N_pred] age_pred;
}
parameters {
  real<lower=0> k;
  real<lower=0> linf;
  real<lower=0> sigma;
  real t0;
}
model {
  k ~ normal(0, 2);
  linf ~ normal(0, 200);
  sigma ~ student_t(3, 0, 2);
  t0 ~ normal(0, 20);
  length ~ lognormal(log(linf * (1 - exp(-k * (age - t0)))), sigma);
}
generated quantities {
  vector[N_pred] length_pred;
  vector[N] posterior_predictions;

  for (i in 1:N_pred) {
    length_pred[i] = linf * (1 - exp(-k * (age_pred[i] - t0)));
  }

  for (i in 1:N) {
    posterior_predictions[i] = lognormal_rng(log(linf * (1 - exp(-k * (age[i] - t0)))), sigma);
  }
}
