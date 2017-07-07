function [freq, y] = impedance(b_unit,fin)
% Calculates acoustic impedance of passive resonator for given fingering
% schemes

freq = 110 .* 2 .^ ((1:5501 - 1) ./ 1200);

for k = 1:size(fin,1)
	fingering = fin(k,:);
	for l = 1:size(freq,2)
        f = freq(l);
        zr = z_radu(f,b_unit(1).d_out);                                   % radiance impedance (flanged tube)
        tm = eye(2);
        m = 0;
        for n = 1:size(b_unit,2)
            tm_old = tm;
            if b_unit(n).has_hole
                m = m + 1;
                state = fingering(m);
            else
                state = 0;
            end
            tm = tm_boreunit(f, b_unit(n), state) * tm_old; 
        end 
        zp = z_in(tm, zr);
        res(k,l) = zp; 
	end
end

y = res;

end