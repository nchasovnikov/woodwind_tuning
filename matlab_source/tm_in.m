function y = tm_in(f, d)
    
r = 0.9;

k = k_complex(f, sqrt(r * (d ^ 2)));

z0 = ro * c / (r * 0.25 * pi * d ^ 2);
      
t = 0.8216 * sqrt(r * (d ^ 2));
      
res(1,1) = cos(k * t);
res(1,2) = 1i * sin(k * t) * (z0);
res(2,1) = 1i * sin(k * t) * (1 / z0);
res(2,2) = cos(k * t);
      
y = res;

end