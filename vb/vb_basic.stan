data {
  int<lower=1> N;
  vector[N] length;
  vector[N] age;
}
parameters {
  real<lower=0> k;
  real<lower=0> linf;
  real<lower=0> sigma;
  real t0;
}
model {
  k ~ normal(0, 1);
  linf ~ normal(0, 100);
  t0 ~ normal(0, 1);
  sigma ~ student_t(3, 0, 2);
  length ~ normal(linf * (1 - exp(-k * (age - t0))), sigma);
}
