function [pval] = permutationAnalysis_diffSize (iterations, array1, array2)
% STAT_BOOTSTRAPPING takes the number of iterations and compares de means
% of the two arrays. 
%
% Not using absolute values

diff_means = abs(nanmean(array1) - nanmean(array2));
n_comp = size(array1, 1);                           % n_rows

vec_values = [array1 array2];
vec_comp = repmat(diff_means, n_comp, iterations);
vec_res = zeros(n_comp, iterations);



for i = 1:iterations
    i_rand = randperm(size(vec_values, 2)); 
    
    for j = 1:n_comp
        vec_perm = vec_values(j, i_rand);
        vec_res(j, i) = ...
            nanmean(vec_perm(1:size(array1))) - ...
            nanmean(vec_perm(size(array1)+1:length(vec_perm)));
    end
end

pval = sum(abs(vec_res) > vec_comp, 2)/iterations;

end 