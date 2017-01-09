function [matpvals, matdiff_means] = bootstrapping_location (mat_values)

ii = 10000;
jj = 3;
matdiff_means = [...
    mean(mat_values(1, :)) - mean(mat_values(3, :)); 
    mean(mat_values(4, :)) - mean(mat_values(6, :));
    mean(mat_values(1, :)) - mean(mat_values(4, :));
    ];

mat_combined = [...
    [mat_values(1, :), mat_values(3, :)];
    [mat_values(4, :), mat_values(6, :)];
    [mat_values(1, :), mat_values(4, :)];
    ];

compmat = repmat(matdiff_means, 1, ii);

resmat = zeros(3, ii);

aux = size(mat_combined, 2);

for i = 1:ii
    i_perm = randperm(aux); 
    
    for j = 1:jj
        permmat = mat_combined(j, i_perm);
        resmat(j, i) = mean(permmat(1:19) - mean(permmat(20:38)));
    end
end

matpvals = sum(resmat <= compmat, 2)/ii;
end

