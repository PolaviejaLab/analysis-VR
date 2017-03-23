% DATARESAMPLING takes the data, and resamples into a smaller size
% (specified by the user) and checks the statitics of specific pairs of
% conditions

addpath('..\statistics');

% Load data
load('..\..\data\stat_array.mat');
load('..\..\data\dyn_array.mat');

sampleSize = 12; it = 1000; 
perm_it = 10000; cmp = 7;
res_array = zeros(cmp, it);

for i = 1:it
    fprintf('%u\n', i);
    randvec = randperm(22); ind_ = randvec(1, 1:12);
%     fprintf('%u', randvec); fprintf('%u', ind_);
    p_val = [...
        stat_bootstrapping(perm_it, reshape(stat_array(1:4, 1, :), 1, 88), reshape(stat_array(1:4, 2, :), 1, 88));
        stat_bootstrapping(perm_it, reshape(dyn_array(1:4, 2, :), 1, 88), reshape(dyn_array(1:4, 4, :), 1, 88));
        stat_bootstrapping(perm_it, reshape(dyn_array(1:4, 2, :), 1, 88), reshape(dyn_array(1:4, 5, :), 1, 88));
        stat_bootstrapping(perm_it, reshape(stat_array(1:4, 1, :), 1, 88), reshape(dyn_array(1:4, 2, :), 1, 88));
        stat_bootstrapping(perm_it, reshape(stat_array(1:4, 2, :), 1, 88), reshape(dyn_array(1:4, 4, :), 1, 88));
        stat_bootstrapping(perm_it, reshape(dyn_array(7:9, 2, :), 1, 66), reshape(dyn_array(7:9, 4, :), 1, 66));
        stat_bootstrapping(perm_it, reshape(dyn_array(7:9, 2, :), 1, 66), reshape(dyn_array(7:9, 5, :), 1, 66));
    ];
   
    res_array(:, i) = p_val;
end

res_ = [...
    sum(res_array(1, :) > 0.747);
    sum(res_array(2, :) > 0.375);
    sum(res_array(3, :) > 0.05);
    sum(res_array(4, :) > 0.114);
    sum(res_array(5, :) > 0.029);
    sum(res_array(6, :) > 0.032);
    sum(res_array(7, :) > 0.05);
    ];
