data {
  int N;               // number of observations
  int K;               // number of predictors
  real y_meas[N];      // measurement of y
  matrix[N, K] X;      // model predictor matrix
}
parameters {
  vector[K] beta;      // vector of predictors
  real alpha;          // intercept
  real<lower=0> sigma; // residual sd
}
model {
  sigma ~ student_t(3, 0, 2);  // prior
  alpha ~ normal(0, 10);  // prior
  beta ~ normal(0, 2);   // prior
  y_meas ~ normal(alpha + X * beta, sigma); // likelihood
}
