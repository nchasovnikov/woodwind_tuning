function [x, y] = parapex(x1,y1,x2,y2,x3,y3)

a = [x1, x2, x3];
b = [y1, y2, y3];
[C, S, mu] = polyfit(a,b,2);

% Use to calculate errors

x = (- C(2)/(2 * C(1)))*mu(2) + mu(1);
y =polyval(C,x,[],mu);
%y = C(1) * x ^ 2 + C(2) * x + C(3);

end