function [nmt] = nanstdthr(matr, thr)

thrr = thr * size(matr, 2);
nmt = nanstd(matr,1,2);
matr_binary = matr;
matr_binary(~isnan(matr_binary)) = 1;
matr_binary(isnan(matr_binary)) = 0;

matb = sum(matr_binary,2);

nmt(matb<thrr) = nan;
    
end