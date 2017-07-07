function y = d_rad(f, b, r)
global c;
      
%     INTEGER STATE
k = 2 * pi * f / c;

%     RADIATION FROM TUBE OF RADIUS B WITH CYL FLANGE OF RADUIS R
delta = (0.8216 * b - (0.47 * (b / r) ^ 0.8) * b);
      
f1 = delta * (1 + ((0.77 * k * b) ^ 2) / (1 + 0.77 * k * delta)) ^ (-1);
f2 = 0.5 / k * log(sqrt(5 * (k * delta) ^ 2 - 2 * k * delta + 1) / (1 + (k * delta) ^ 2));
     
y = f1 + 1i * f2;
      

end