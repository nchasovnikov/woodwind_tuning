function y = populatebore (hg, bg)
      
l = 1;
l_old = 0;
k = 0;

b_unit = struct('has_hole',{},'is_conic',{},'l',{},'d_in',{},'d_out',{},'d_hole',{},'douter',{},'ta',{},'ti',{},'tsum',{});

if size(hg,2) ~= 0
    for m = 1:size(hg,2)            % do 100,i=1,size(hg,1)
        while l < size(bg,2)                            % 101 continue
            % Hole coordinate is between two bore points
            if hg(m).coo >= bg(l).coo && hg(m).coo < bg(l+1).coo                
                k = k + 1;
                b_unit(k).has_hole = true;
                b_unit(k).douter = bg(l).odia;
                b_unit(k).d_hole = hg(m).dia;
            
                % Hole is the first hole
                if m == 1
                    b_unit(k).l      = hg(m).coo - bg(l).coo;
                    b_unit(k).d_out  = bg(l).dia + (bg(l+1).dia - bg(l).dia) / (bg(l + 1).coo - bg(l).coo) * (bg(l).coo - bg(l).coo);
                
                % Hole is not the fisrt
                else
                    % Last hole coordinate is between same two bore points
                    if hg(m-1).coo >= bg(l).coo
                        b_unit(k).l      = hg(m).coo - hg(m-1).coo;
                        b_unit(k).d_out  = bg(l).dia + (bg(l+1).dia - bg(l).dia) / (bg(l+1).coo - bg(l).coo) * (hg(m-1).coo-bg(l).coo);
                    % Last hole coordinate is not between same two bore points
                    else
                        b_unit(k).l      = hg(m).coo - bg(l).coo;
                        b_unit(k).d_out  = bg(l).dia + (bg(l+1).dia - bg(l).dia) / (bg(l+1).coo - bg(l).coo) * (bg(l).coo - bg(l).coo);
                    end
                end
            
                b_unit(k).d_in  = bg(l).dia + (bg(l+1).dia - bg(l).dia) / (bg(l+1).coo - bg(l).coo) * (hg(m).coo - bg(l).coo);
        
                if  b_unit(k).d_in == b_unit(k).d_out
                    b_unit(k).is_conic = false;
                else
                    b_unit(k).is_conic = true;
                end
                
                [b_unit(k).ta, b_unit(k).ti, b_unit(k).tsum] = t_hole(b_unit(k).d_in / 2, b_unit(k).d_hole / 2, b_unit(k).douter / 2);
                
                %disp( sprintf('Unit %2i : ta(1)= %6.4e ; ta(2)= %6.4e', k, b_unit(k).ta));
                %disp( fprintf('Hole # %i is between points %i and %i', m, l, l+1));
                break
            % Hole coordinate is not between two bore points
            else
                k = k + 1;
                b_unit(k).has_hole = false;
                b_unit(k).douter = bg(l).odia;
                b_unit(k).d_hole = 0;

                % Hole is the first hole
                if m == 1
                    b_unit(k).l      = bg(l+1).coo - bg(l).coo;
                    b_unit(k).d_out  = bg(l).dia + (bg(l+1).dia - bg(l).dia) / (bg(l+1).coo - bg(l).coo) * (bg(l).coo - bg(l).coo);
                
                % Hole is not the fisrt
                else
                    % Last hole coordinate is between same two bore points
                    if hg(m-1).coo >= bg(l).coo
                        b_unit(k).l      = bg(l+1).coo - hg(m-1).coo;
                        b_unit(k).d_out  = bg(l).dia + (bg(l+1).dia - bg(l).dia) / (bg(l+1).coo - bg(l).coo) * (hg(m-1).coo - bg(l).coo);
                    % Last hole coordinate is not between same two bore points
                    else
                        b_unit(k).l      = bg(l+1).coo - bg(l).coo;
                        b_unit(k).d_out  = bg(l).dia + (bg(l+1).dia - bg(l).dia) / (bg(l+1).coo - bg(l).coo) * (bg(l).coo - bg(l).coo);
                    end
                end
                b_unit(k).d_in  = bg(l).dia + (bg(l+1).dia - bg(l).dia) / (bg(l+1).coo - bg(l).coo) * (bg(l+1).coo - bg(l).coo);
        
                if b_unit(k).d_in == b_unit(k).d_out
                    b_unit(k).is_conic = false;
                else
                    b_unit(k).is_conic = true;
                end
                % move to next bore point
                l = l + 1;
            end
        end
    end

    n = size(hg,2);
    
    tl = 0;

    for m = 1:k      %do 103,i=1,k
        tl = tl + b_unit(m).l;
    end

    for l = l:size(bg,2)      %do 102,l=l,size(bg,1)
        if bg(l).coo >= tl
            k = k + 1;
            b_unit(k).has_hole = false;
            b_unit(k).douter = bg(l).odia;
            b_unit(k).d_hole = 0;
        
            if size(hg,2) == 1
                b_unit(k).l      = bg(l).coo - bg(l-1).coo;
                b_unit(k).d_out  = bg(l-1).dia + (bg(l).dia - bg(l-1).dia) / (bg(l).coo - bg(l-1).coo) * (bg(l-1).coo - bg(l-1).coo);
            else
                if hg(n).coo >= bg(l-1).coo
                    b_unit(k).l      = bg(l).coo - hg(n).coo;
                    b_unit(k).d_out  = bg(l-1).dia + (bg(l).dia - bg(l-1).dia) / (bg(l).coo - bg(l-1).coo) * (hg(n).coo - bg(l-1).coo);
                else
                    b_unit(k).l      = bg(l).coo - bg(l-1).coo;
                    b_unit(k).d_out  = bg(l-1).dia + (bg(l).dia - bg(l-1).dia) / (bg(l).coo - bg(l-1).coo) * (bg(l-1).coo - bg(l-1).coo);
                end
            end
            b_unit(k).d_in  = bg(l-1).dia + (bg(l).dia - bg(l-1).dia) / (bg(l).coo - bg(l-1).coo) * (bg(l).coo - bg(l-1).coo);
            if b_unit(k).d_in == b_unit(k).d_out
                b_unit(k).is_conic = false;
            else
                b_unit(k).is_conic = true;
            end
        end
    end
    
% No holes     
else
    for l = 2:size(bg,2)
        b_unit(l).has_hole = false;
        b_unit(l).douter = bg(l).odia;
        b_unit(l).d_hole = 0;
        b_unit(l).l      = bg(l).coo - bg(l-1).coo;
        b_unit(l).d_out  = bg(l-1).dia;
        b_unit(l).d_in   = bg(l).dia;
        if b_unit(l).d_in == b_unit(l).d_out
            b_unit(l).is_conic = false;
        else
            b_unit(l).is_conic = true;
        end
    end
end
        


y = b_unit;

end