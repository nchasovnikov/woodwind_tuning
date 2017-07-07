function [ta, ti, tsum] = t_hole(a, b, r)
% Function takes bore radius, hole radius and outer raduis of instrument at
% hole placement and calculates length corrections for impedance
% calculations.

% a - bore radius;
% b - hole radius;
% r - outer body radius;

% ta - 2 x 1 matrix of series length correction: 1 - closed, 2 - open hole;
% ti - inner length correction;
% tsum - 2 x 1 matrix of shunt length correction 1 - closed, 2 - open hole.


%% Hole radius coefficient
delta = b / a;

%% Inner length correction

%     Nederveen 1998 EQ (38.3)
%     ti = (1.3 - 0.9 * delta) * b;
%     Keefe 1982B EQ (67F)
%ti = (0.79 - 0.58 * delta ^ 2) * b;
%     Nederveen et al. 1998 EQ (40)
ti = (0.82 - 1.4 * delta ^ 2 + 0.75 * delta ^ 2.7) * b;

      
%% Series length correction

% closed tonehole series length correction
    
    % Keefe 1981, Eq. 54
    % ta = 0.47 * b * delta ^ 4 / (coth(1.84 *(r - d) / b) + 0.62 * delta ^ 2 +  0.64 * delta);
    % Dubos et al. 1999b, Eq. 74
ta(1) =(-1) * b * delta ^ 4 / (1.78 * coth(1.84 * (r - a) / b ) + 0.940 + 0.540 * delta + 0.285 * delta ^ 2);

% open tonehole series length correction
    
    % Keefe 1982b, Eq. 68b
    % ta = (-1) * 0.47 * b * delta ^ 4 / (tanh(1.84 *(r - d) / b) + 0.62 * delta ^ 2 +  0.64 * delta);
    % Nederveen et al. 1998, Fig. 11
    % ta = -0.28 * b * delta ^ 4;
    % Dubos et al. 1999b, Eq. 74
ta(2) =(-1) * b * delta ^ 4 / (1.78 * tanh(1.84 * (r - a) / b ) + 0.940 + 0.540 * delta + 0.285 * delta ^ 2);

      
%% Shunt length correction

%	matching volume correction
tm = b * delta / 8  * (1 + 0.207 * delta ^ 3);
      
%	wall thickness
t = r - a;
      
%	finger pad correction for closed tonehole
tf = (-0.76) * b ^ 2 / a;
      
%	matching volume correction for outer cylinder
tm1 = b ^ 2 / (8 * r ) * (1 + 0.207 * (b / r) ^ 3);
      
%	negative correction for nonplanar termination
tx = sqrt((r ^ 2) - (b ^ 2)) - r;

% dr = d_rad(f, b, r);

tsum(1) = tm + t + tx + tf;
tsum(2) = tm + t + tm1 + tx + 0.8216 * b;

% state == 2
% tsum = tm + t + tm1 + tx + dr;

end