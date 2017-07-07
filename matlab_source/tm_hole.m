function y = tm_hole(k, b, ti, ta, tsum, state)
% Function calculates transfer matrix of a hole, whether it is closed or
% open.

% k - wave number, corresponding to given frequency;
% b - bore diameter (further is modified to represent radius);
% ti - inner length correction;
% ta - 2 x 1 matrix of series length correction;
% tsum - 2 x 1 matrix of shunt length correction;
% state - logical: 0 - closed hole; 1 - open hole.

% y - transfer matrix of the hole.



%% Global variables definition

global c;
global ro;

b  = b  / 2;

%% Specific impedance of hole
z0 = ro * c / (pi * b ^ 2);
      
%% Series and shut impedances with respect to state
za = 1i * k * (ta(state + 1) * z0);
      
if state == 0
    zs = 1i * (k * ti - 1 / tan(k * tsum(state + 1))) * (z0);
else
    zs = 1i * (k * ti + tan(k * tsum(state + 1))) * (z0);
end
     
%% Transfer matrix representation

% First transfer matrix
t1(1,1) = 1;
t1(1,2) = za / 2;
t1(2,1) = 0;
t1(2,2) = 1;

% Second transfer matrix
t2(1,1) = 1;
t2(1,2) = 0;
t2(2,1) = 1 / zs;
t2(2,2) = 1;

% Third transfer matrix
t3 = t1;

y = t3 * (t2 * t1);

end