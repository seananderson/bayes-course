data {
  int<lower=1> N;
  vector[N] length;
  vector[N] age;
  real<lower=0> error;

  int<lower=1> N_pred;
  vector<lower=0>[N_pred] age_pred;
}
parameters {
  real<lower=0> k;
  real<lower=0> linf;
  real<lower=0> sigma;
  real t0;
  vector<lower=0>[N] age_true; // this is new
}
model {
  // priors:
  k ~ normal(0, 2);
  linf ~ normal(0, 200);
  sigma ~ student_t(3, 0, 2);
  t0 ~ normal(0, 20);

  // aging measurement error:
  age ~ lognormal(log(age_true), error); // this is new

  // likelihood:
  length ~ lognormal(log(linf * (1 - exp(-k * (age_true - t0)))), sigma); // this is modified
}
generated quantities {
  vector[N_pred] length_pred;
  vector[N] posterior_predictions;
  vector[N] age_true_posterior_predict; // this is new

  for (i in 1:N_pred) {
    length_pred[i] = linf * (1 - exp(-k * (age_pred[i] - t0)));
  }

  for (i in 1:N) {
    age_true_posterior_predict[i] = lognormal_rng(log(age[i]), error); // this is new
    posterior_predictions[i] =
      lognormal_rng(log(linf * (1 - exp(-k * (age_true_posterior_predict[i] - t0)))), sigma); // this is new
  }
}
