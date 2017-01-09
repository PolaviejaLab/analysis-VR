function [pval] = stat_bootstrapping_std (iterations, array1, array2)
% STAT_BOOTSTRAPPING takes the number of iterations and compares de means
% of the two arrays. 
%
%

diff_std = abs(nanstd(array1) - nanstd(array2));
n_comp = size(array1, 1);

vec_values = [array1 array2];
vec_comp = repmat(diff_std, n_comp, iterations);
vec_res = zeros(n_comp, iterations);

for i = 1:iterations
    i_rand = randperm(size(vec_values, 2)); 
    
    for j = 1:n_comp
        vec_perm = vec_values(j, i_rand);
        vec_res(j, i) = ...
            abs(nanstd(vec_perm(1:length(vec_perm)/2)) - ...
            nanstd(vec_perm(length(vec_perm)/2+1:length(vec_perm))));
    end
end

pval = sum(vec_res > vec_comp, 2)/iterations;

end 