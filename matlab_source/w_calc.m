function y = w_calc(f,h)
if h == 1
    y = 0.178 * f ^ (-0.55);
else
	y = 0.213 * f ^ (-0.55);
end

end