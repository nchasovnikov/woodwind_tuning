function y = z_radf(f, d)
global c;
global ro;

k  = (2 * pi * f) / c;

ka = k * d / 2;

f1= 0.8216 * d / 2 / (1 + (0.77 * ka) ^ 2 / (1 + 0.77 * ka));

% Is this a natural logarythm????
f2= 0.5 / k * log((1 + 0.323 * ka - 0.077 * ka ^ 2) / (1 + 0.323 * ka + (1 - 0.077) * ka ^ 2));

delta = f1 + 1i * f2;

y = ro * c / (0.25 * pi * d ^ 2) * 1i * tan(delta * k);

end