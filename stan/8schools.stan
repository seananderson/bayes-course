data {
  int<lower=0> N;
  vector[N] y;
  vector<lower=0>[N] sigma;
}
parameters {
  real mu;
  real<lower=0> sigma_prime;
  vector[N] theta;
}
model {
  mu ~ normal(0, 10);
  sigma_prime ~ cauchy(0, 10);
  theta ~ normal(mu, sigma_prime);
  y ~ normal(theta, sigma);
}
