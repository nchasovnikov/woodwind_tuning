function y = z_radu(f,d)
global c;
global ro;

k  = 2 * pi * f / c;
ka = k * d / 2;

f1 = 0.6133 * d / 2 * ((1 + 0.044 * ka ^ 2) / (1 + 0.19 * ka ^ 2) - 0.02 * (sin(2 * ka))^2);

f2 = 0.5 / k * log((1 + 0.2 * ka - 0.084 * ka ^ 2) / (1 + 0.2 * ka + (0.5 - 0.084) * ka ^ 2));

delta = f1 + 1i * f2;

y = ro * c / (0.25 * pi * d ^ 2) * 1i * tan(delta * k);

end