function y = tm_cyl(f,d,l)
global c;
global ro;

k = k_complex(f, d);
      
y(1,1) = cos(k * l);
y(1,2) = sin(k * l) * 1i * (ro * c / (0.25 * pi * (d^2)));
y(2,1) = sin(k * l) * 1i * ((0.25 * pi * (d^2)) / (ro * c));
y(2,2) = cos(k * l);

end