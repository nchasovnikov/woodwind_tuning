function y = tm_boreunit(f, bunit, state)
if bunit.has_hole
  k = k_complex(f, bunit.d_hole);
  t_h = tm_hole(k, bunit.d_hole, bunit.ti, bunit.ta, bunit.tsum, state);
else
  t_h = eye(2);
end

if bunit.is_conic
  t_c = tm_con(f, bunit.d_in, bunit.d_out, bunit.l);
else
  t_c = tm_cyl(f, bunit.d_in, bunit.l);
end

y = t_h * t_c;

%if bunit.is_conic && bunit.has_hole
%    k = k_complex(f, bunit.d_hole);
%    y = tm_hole(k, bunit.d_hole, bunit.ti, bunit.ta, bunit.tsum, state) * tm_con(f, bunit.d_in, bunit.d_out, bunit.l);
%elseif bunit.is_conic && not(bunit.has_hole)
%    y = eye(2) * tm_con(f, bunit.d_in, bunit.d_out, bunit.l);
%elseif not(bunit.is_conic) && bunit.has_hole
%    k = k_complex(f, bunit.d_hole);
%    y = tm_hole(k, bunit.d_hole, bunit.ti, bunit.ta, bunit.tsum, state) * tm_cyl(f, bunit.d_in, bunit.l);
%else
%    y = eye(2) * tm_cyl(f, bunit.d_in, bunit.l);
%end
end
