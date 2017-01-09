addpath('V:\Data\04. Exp1_Frontiers\');
load('mat_slopes.mat'); 

a1 = stat_bootstrapping_cv(10000, mat_slopes(:, 1)', mat_slopes(:, 2)');
a2 = stat_bootstrapping_cv(10000, mat_slopes(:, 1)', mat_slopes(:, 3)');
a3 = stat_bootstrapping_cv(10000, mat_slopes(:, 1)', mat_slopes(:, 4)');
a4 = stat_bootstrapping_cv(10000, mat_slopes(:, 2)', mat_slopes(:, 3)');
a5 = stat_bootstrapping_cv(10000, mat_slopes(:, 2)', mat_slopes(:, 4)');
a6 = stat_bootstrapping_cv(10000, mat_slopes(:, 3)', mat_slopes(:, 4)');

[~, cc1] = corrcoef(mat_slopes(:, 1)', mat_slopes(:, 2)');
[~, cc2] = corrcoef(mat_slopes(:, 1)', mat_slopes(:, 3)');
[~, cc3] = corrcoef(mat_slopes(:, 1)', mat_slopes(:, 4)');
[~, cc4] = corrcoef(mat_slopes(:, 2)', mat_slopes(:, 3)');
[~, cc5] = corrcoef(mat_slopes(:, 2)', mat_slopes(:, 4)');
[~, cc6] = corrcoef(mat_slopes(:, 3)', mat_slopes(:, 4)');