function y = z_in(tm,zl)

f1 = tm(1,1) * zl + tm(1,2);
f2 = tm(2,1) * zl + tm(2,2);
      
y = f1 / f2;

end