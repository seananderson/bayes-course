data {
  int<lower=0> N;
  vector[N] y;
  vector<lower=0>[N] sigma;
}
parameters {
  real mu;
  real<lower=0> sigma_prime;
  vector[N] eta;
}
transformed parameters {
  vector[N] theta;
  theta = mu + sigma_prime * eta;
}
model {
  mu ~ normal(0, 10);
  sigma_prime ~ cauchy(0, 10);
  eta ~ normal(0, 1);
  y ~ normal(theta, sigma);
}
