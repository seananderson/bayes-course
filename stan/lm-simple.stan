data {
  int<lower=1> N;      // number of observations
  vector[N] y;         // response
  vector[N] x;         // a predictor
}
parameters {
  real beta;           // slope coefficient
  real alpha;          // intercept coefficient
  real<lower=0> sigma; // residual error standard deviation
}
model {
  sigma ~ student_t(3, 0, 2);  // prior
  alpha ~ normal(0, 10);       // prior
  beta ~ normal(0, 2);         // prior

  y ~ normal(alpha + x * beta, sigma); // data likelihood
}
