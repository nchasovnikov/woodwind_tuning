function y = minimacount(fa,ima)

n = size(ima,1);

z0 = 0;

for k = 1:n
    z0 = z0 + ima(k) / (n-1);
end

m = 0;

% do 22,i=5,size(fa)-5

for k = 5:n-5
    if ima(k) < ima(k-1) && ima(k) < ima(k+1)
        if m == 0
            m = m + 1;
            [minima(m,1), minima(m,2)] = parapex(fa(k-1),ima(k-1),fa(k),ima(k),fa(k+1),ima(k+1));
            f_1 = fa(k);
        else
            if ima(k) <= 0.9*z0 && (fa(k)/f_1)/round(fa(k)/f_1) < 1.15 && fa(k)/f_1/round(fa(k)/f_1) > 0.85
                m = m + 1;
                [minima(m,1), minima(m,2)] = parapex(fa(k-1),ima(k-1),fa(k),ima(k),fa(k+1),ima(k+1));
            end
        end
    end
end
y = minima;
end