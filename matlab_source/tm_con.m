function y = tm_con(f,d1,d2,l)
global c;
global ro;
      
k = k_complex(f, 0.5 * (d1 + d2));

pi25 = 0.25 * pi;

if d1 > d2
    x1 = d1 * l / (d2 - d1);
	x2 = l + x1;
	s1 = pi25 * (d1 ^ 2);
	s2 = pi25 * (d2 ^ 2);
else
	x1 = d2 * l / (d1 - d2);
	x2 = l + x1;
	s1 = pi25 * (d2 ^ 2);
	s2 = pi25 * (d1 ^ 2);
end
      
t1 = atan(2 * pi * f / c * x1);
t2 = atan(2 * pi * f / c * x2);

res1(1,1) = (-1) * (sin(k * l - t2) / sin(t2));
res1(1,2) = 1i * sin(k * l) * (ro * c / s2);
res1(2,1) = 1i * sin(k * l + t1 - t2) / sin(t1) / sin(t2) * (s1 / ro / c);
res1(2,2) = sin(k * l + t1) / sin(t1) * (s1 / s2);
      
if d2 > d1 %flaring cone
    res2 = res1\eye(2);
    res2(1,2) = - res2(1,2);
    res2(2,1) = - res2(2,1);
%	G = res1(1,1) * res1(2,2) - res1(1,2) * res1(2,1);
%    res2(1,1) = res1(2,2) / G;
% 	res2(1,2) = res1(1,2) / G;
%	res2(2,1) = res1(2,1) / G;
%	res2(2,2) = res1(1,1) / G;
else
    res2 = res1;
%	res2%a = res1%a
%	res2%b = res1%b
%	res2%c = res1%c
%	res2%d = res1%d
end
      
y = res2;
      

end