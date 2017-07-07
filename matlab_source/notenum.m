function y = notenum(f)
      
n = round(69 + 12 * log(f / 440) / log(2));
n1 = mod(n, 12);

nprec = 0.01 * round(100 * (1200 * log(f / (440 * 2 ^ ((n - 69) / 12))) / log(2)));

switch n1
    case 0
        re = sprintf('C %+6.2f', nprec);
    case 1
        re = sprintf('Db%+6.2f', nprec);
    case 2
        re = sprintf('D %+6.2f',nprec);
    case 3
        re = sprintf('Eb%+6.2f',nprec);
    case 4
        re = sprintf('E %+6.2f',nprec);
    case 5
        re = sprintf('F %+6.2f',nprec);
    case 6
        re = sprintf('Gb%+6.2f',nprec);
    case 7
        re = sprintf('G %+6.2f',nprec);
    case 8
        re = sprintf('Ab%+6.2f',nprec);
    case 9
        re = sprintf('A %+6.2f',nprec);
    case 10
        re = sprintf('Bb%+6.2f',nprec);
    case 11
        re = sprintf('B %+6.2f',nprec);
end
      
y = re;
      

end