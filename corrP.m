function P=corrP(T,N)

% One-tailed probability
% P=1-tcdf(T, N-2);

% Two-tailed probability
  P=2*(1-tcdf(abs(T),N-2));