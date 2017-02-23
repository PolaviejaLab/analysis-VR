load('..\data\arrays_ownstat.mat');
load('..\data\arrays_owndyn.mat');
load('..\data\arrays_agndyn.mat');

group1s = find(mean(own_stat_nogap) <= 3);
group2s = find(mean(own_stat_nogap) > 3 & mean(own_stat_nogap) < 5);
group3s = find(mean(own_stat_nogap) >= 5);

group1d = find(mean(own_dyn_control) <= 3);
group2d = find(mean(own_dyn_control) > 3 & mean(own_dyn_control) < 5);
group3d = find(mean(own_dyn_control) >= 5);
% 
% group1a = find(mean(agn_dyn_noise) <= 3);
% group2a = find(mean(agn_dyn_noise) > 3 & mean(agn_dyn_noise) < 5);
% group3a = find(mean(agn_dyn_noise) >= 5);

% vector1c = mean(own_stat_nogap(:, group1s));
% vector2c = mean(own_stat_nogap(:, group2s));
% vector3c = mean(own_stat_nogap(:, group3s));
% 
% vector1d = mean(own_stat_gap(:, group1s));
% vector2d = mean(own_stat_gap(:, group2s));
% vector3d = mean(own_stat_gap(:, group3s));

ii = 10000;
 
df_mn = abs([...
    mean(mean(own_dyn_control(:, group1d))) - mean(mean(own_dyn_noise(:, group1d)));
    mean(mean(own_dyn_control(:, group2d))) - mean(mean(own_dyn_noise(:, group2d)));
    mean(mean(own_dyn_control(:, group3d))) - mean(mean(own_dyn_noise(:, group3d)))
    ]);

% within group
vec_cmp = repmat(df_mn, 1, ii);
vec_res = zeros(1, ii);

for i = 1:ii
    aux_vc = [...
        mean(own_dyn_control(:, group3d)), mean(own_stat_gap(:, group3d));
        ];
    
    i_rand = randperm(size(aux_vc, 2));
            
    vec_perm = aux_vc(1, i_rand);    
    
    vec_res(i) = mean(vec_perm(:, 1:5)) - mean(vec_perm(:, 6:size(vec_perm, 2)));
    
end
pval_w = sum(abs(vec_res) > vec_cmp(3, :), 2)/ii;


% Among the total sample
vec_cmp = repmat(df_mn, 1, ii);
vec_res = zeros(3, ii);

aux_vc = [...
        mean(own_dyn_control(:, group1d)) - mean(own_dyn_noise(:, group1d)), ...
        mean(own_dyn_control(:, group2d)) - mean(own_dyn_noise(:, group2d)), ...
        mean(own_dyn_control(:, group3d)) - mean(own_dyn_noise(:, group3d))
        ];

for i = 1:ii

    i_rand = randperm(size(aux_vc, 2));
            
    vec_perm = aux_vc(1, i_rand);    
    
    vec_res(1, i) = mean(vec_perm(:, 1:5));
    vec_res(2, i) = mean(vec_perm(:, 6:9));
    vec_res(3, i) = mean(vec_perm(:, 10:size(vec_perm, 2)));
    
end
pval_tot = sum(abs(vec_res) > vec_cmp, 2)/ii;
