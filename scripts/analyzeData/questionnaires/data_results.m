function [results] = data_results (array)

results = [...
    nanmean(array'); ...
    nanmedian(array'); ...
    std(array'); ...
    normalyDistributed(array) ...
    ]; 


end