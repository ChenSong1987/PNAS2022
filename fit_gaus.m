function [SSE,output] = fit_gaus(parameters,inputs,DATA)

mu = parameters(1);
sig = exp(parameters(2));
amp = exp(parameters(3));

output = amp*exp(-.5*((inputs - mu)./sig).^2);
SSE = sum((DATA - output).^2);
