clear;
%% Global parameters

global T c ro;

% Ambient air characteristics
T = 24;
%c = 343.21;                 % Sound speed in air
c = 331.4 + 0.6 * T;
ro = 1.2041;                % Air density

%% Open and read geometry of bore and holes positions. Create "bore units"

% Bore geometry structure
bg = struct('coo',{},'dia',{},'odia',{});
% Holes geometry structure
hg = struct('coo',{},'dia',{});
% Open file comtaining bore and holes geometry information
[filename, pathname] = uigetfile('*.dat');

disp('');
disp('Geometry is defined in file:');
disp(fullfile(pathname,filename));
f1 = fopen(fullfile(pathname,filename));

% Read number of bore points
bn = fscanf(f1,'%i',1);

% Read bore points coordinates
for k=1:bn
    bg(k).coo = fscanf(f1,'%f',1);
end
% Read bore points diameters
for k=1:bn
    bg(k).dia = fscanf(f1,'%f',1);
end
% Read bore points outer diameters
for k=1:bn
    bg(k).odia = fscanf(f1,'%f',1);
end

% Read number of holes
hn = fscanf(f1,'%i',1);

% Read holes coordinates
for k=1:hn
	hg(k).coo = fscanf(f1,'%f',1);
end
% Read holes diameters
for k=1:hn
	hg(k).dia = fscanf(f1,'%f',1);
end

% Populate "bore units"

b_unit = populatebore(hg,bg);

%% Display geometry

disp(' ');
disp('Geometry info:');

for k = 1:size(b_unit,2)
    if k == 1
        l = 0;
    else
        l = l + b_unit(k-1).l;
    end
    disp(sprintf(' %6.4f %6.4f %6.4f %6.4f %i %6.4f %i %6.4f',l,b_unit(k).l, b_unit(k).d_in, b_unit(k).d_out, b_unit(k).is_conic, b_unit(k).douter, b_unit(k).has_hole, b_unit(k).d_hole));
end
%%

fingering = [   0,0,0,0,0;...
                1,0,0,0,0;...
                1,1,0,0,0;...
                1,1,1,0,0;...
                0,0,1,1,0;...
                0,0,1,1,1;...
                0,0,0,0,0;...
                1,0,0,0,0;...
                1,1,0,0,0;...
                1,1,1,0,0;...
                0,1,1,1,0;...
                0,1,1,1,1];
            
f_names = [ 'o';'o';'o';'o';'o';'o';...
            'k';'k';'k';'k';'k';'k'];


[freq, imp] = impedance(b_unit,fingering);
res = admittance(freq, imp, fingering, f_names);





%% Display tuning
disp(' ');
disp('Tuning info:');
disp('Fingering Octave  Note      freq    Admit  Width');
for k=1:size(res,2)
    disp(sprintf('   %2i        %s    %s %7.2f %6.3f %7.2f',k , f_names(k), notenum(res(k).freq),res(k).freq, res(k).amd, res(k).halfa));
end

f0 = 220 * 2 ^ (7/12);  % E note
for k = 1:4
f(5*(k-1)+1) = f0 * 2 ^ (((k-1)*12+0)/12);
f(5*(k-1)+2) = f0 * 2 ^ (((k-1)*12+3)/12);
f(5*(k-1)+3) = f0 * 2 ^ (((k-1)*12+5)/12);
f(5*(k-1)+4) = f0 * 2 ^ (((k-1)*12+7)/12);
f(5*(k-1)+5) = f0 * 2 ^ (((k-1)*12+10)/12);
end





plot(res(1).f,res(1).a, res(2).f,res(2).a, res(3).f,res(3).a, res(4).f,res(4).a, res(5).f,res(5).a, res(6).f,res(6).a);
set(gca,'XTick',f);

f2 = fopen(fullfile(pathname,strrep(filename,'.dat','_export.dat')),'w');

for k = 1:size(res(1).f,2)
    fprintf(f2,'%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f;%.4f \n',res(1).f(k),res(1).a(k),res(2).a(k),res(3).a(k),res(4).a(k),res(5).a(k),res(6).a(k)...
        ,res(7).a(k),res(8).a(k),res(9).a(k),res(10).a(k),res(11).a(k),res(12).a(k));
end
fclose('all');


