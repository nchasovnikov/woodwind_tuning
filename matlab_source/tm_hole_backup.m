function y = tm_hole(k, f, d, d1, b, state)
global c;
global ro;

delta = b / d;
b  = b  / 2;
d  = d  / 2;
d1 = d1 / 2;

%%     SPECIFIC IMPEDANCE FOR HOLE
z0 = ro * c / (pi * b ^ 2);

%%     INNER LENGTH CORRECTION

%ti = t_i(d, b);

%     NEDERVEEN 1998 EQ (38.3)
%     ti = (1.3 - 0.9 * delta) * b;
%     KEEFE 1982B EQ (67F)
%ti = (0.79 - 0.58 * delta ^ 2) * b;
%     NEDERVEEN ET AL 1998 EQ (40)
ti = (0.82 - 1.4 * delta ^ 2 + 0.75 * delta ^ 2.7) * b;

      
%%     SERIES LENGTH CORRECTION WITH RESPECT TO STATE

%ta = t_a(d, b, (d1 - d), state);
      
if state == 0
    % closed tonehole series length correction
    
    % Keefe 1981, Eq. 54
%    ta = 0.47 * b * delta ^ 4 / (coth(1.84 *(d1 - d) / b) + 0.62 * delta ^ 2 +  0.64 * delta);
    % Dubos et al. 1999b, Eq. 74
    ta =(-1) * b * delta ^ 4 / (1.78 * coth(1.84 * (d1 - d) / b ) + 0.940 + 0.540 * delta + 0.285 * delta ^ 2);
else
    % open tonehole series length correction
    
    % Keefe 1982b, Eq. 68b
%    ta = (-1) * 0.47 * b * delta ^ 4 / (tanh(1.84 *(d1 - d) / b) + 0.62 * delta ^ 2 +  0.64 * delta);
    % Nederveen et al. 1998, Fig. 11
%    ta = -0.28 * b * delta ^ 4;
    % Dubos et al. 1999b, Eq. 74
	ta =(-1) * b * delta ^ 4 / (1.78 * tanh(1.84 * (d1 - d) / b ) + 0.940 + 0.540 * delta + 0.285 * delta ^ 2);
end
      
%%     SHUNT LENGTH CORRECTION WITH RESPECT TO STATE

%tsum = t_sum(d, b, d1, state, f);

%	matching volume correction
tm = b * delta / 8  * (1 + 0.207 * delta ^ 3);
      
%	wall thickness
t = d1 - d;
      
%	finger pad correction for closed tonehole
tf = (-0.76) * b ^ 2 / d;
      
%	metching volume correction for outer cylinder
tm1 = b ^ 2 / (8 * d1 ) * (1 + 0.207 * (b / d1) ^ 3);
      
%	negative correction for nonplanar termination
tx = sqrt((d1 ^ 2) - (b ^ 2)) - d1;

dr = d_rad(f, b, d1);

if state == 0
    tsum = tm + t + tx + tf;
end
if state == 1
    tsum = tm + t + tm1 + tx + 0.8216 * b;
end
if state == 2
    tsum = tm + t + tm1 + tx + dr;
end
      
%%     SERIES AND SHUNT IMPEDANCE WITH RESPECT TO STATE
za = 1i * k * (ta * z0);
      
if state == 0
    zs = 1i * (k * ti - 1 / tan(k * tsum)) * (z0);
end
if state == 1
    zs = 1i * (k * ti + tan(k * tsum)) * (z0);
end
if state == 2
    zs = 1i * (k * ti + tan(k * tsum)) * (z0);
end
     
%%
%     FIRST TRANSFER MATRIX DOWNSTREAM
t1(1,1) = 1;
t1(1,2) = za / 2;
t1(2,1) = 0;
t1(2,2) = 1;

%     SECOND TRANSFER MATRIX SHUNT
t2(1,1) = 1;
t2(1,2) = 0;
t2(2,1) = 1 / zs;
t2(2,2) = 1;

%     THIRD TRANSFER MATRIX UPSTREAM
t3 = t1;


y = t3 * (t2 * t1);

end