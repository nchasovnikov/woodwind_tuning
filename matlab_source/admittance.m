function y = admittance(fi, imi, fin, f_names)

y = struct('freq',{},'adm',{},'halfa',{},'f',{},'a',{});

for k = 1:size(fin,1)
    
    ima = abs(imi(k,:));
    minima = minimacount(fi, abs(ima.'));

      
%     find W distance, define width b
	if strcmp(f_names(k), 'o')
        w = w_calc(minima(1,1),1);
    else
        w = w_calc(minima(2,1),2);
    end;
    
    b = 0.012;
    sw = w * b;
    rw = sqrt(sw/pi);

    for l = 1:size(fi,2)
    %     given frequency
        f = fi(l);
        zw = z_radf(f, rw);
        zp = imi(k,l);
        ad = 1 / sw / (zp + zw);
        res(k,l) = abs(ad);
    end
    
    maxima = maximacount(fi,res(k,:));
    
    if strcmp(f_names(k), 'o')
        y(k).freq  = maxima(1,1);
        y(k).amd   = maxima(1,2);
        y(k).halfa = maxima(1,3);
        y(k).f = fi;
        y(k).a = res(k,:);
        
    else
        
        y(k).freq  = maxima(2,1);
        y(k).amd   = maxima(2,2);
        y(k).halfa = maxima(2,3);
        y(k).f = fi;
        y(k).a = res(k,:);
        
    end
end

end