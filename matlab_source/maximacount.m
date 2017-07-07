function y = maximacount(fa,ima)
      
m = 0;

n = size(ima,2);
me = mean(ima);
for k = 5:n-5
    if ima(k) > ima(k - 1) && ima(k) > ima(k + 1) && ima(k) > me
        m = m + 1;
        [maxima(m,1), maxima(m,2)] = parapex(fa(k-1),ima(k-1),fa(k),ima(k),fa(k+1),ima(k+1));
        
        l = 1;
        
        while ima(k-l) > 0.5 * ima(k)
            l = l + 1;
        end

        maxima(m,3) = (fa(k - l + 1) - fa(k - l)) / (ima(k - l + 1) - ima(k - l)) * (0.5 * ima(k) - ima(k - l)) + fa(k - l);
        
    end
end

y = maxima;   

end