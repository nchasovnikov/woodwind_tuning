function y = k_complex(f, d)

global c;
 
y = 2 * pi * f / c / (1 - 0.0033 / d / sqrt(f)) - 1i * 0.00006 * sqrt(f) / d;

end