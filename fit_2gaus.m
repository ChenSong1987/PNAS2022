function SSE = fit_2gaus(parameters,inputs,DATA)

mu = parameters(1);
sig = exp(parameters(2));
amp1 = exp(parameters(3));
amp2 = exp(parameters(4));

g1 = amp1*exp(-.5*((inputs{1} - inputs{2}(1))./inputs{2}(2)).^2);

g2 = amp2*exp(-.5*((inputs{1} - mu)./sig).^2);

output = g1 + g2;

SSE = sum((DATA - output).^2);