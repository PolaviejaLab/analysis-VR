function [pval_tot] = permutationGroups(iterations, group_low, group_med, ...
    group_high, array1, array2)

df_mn = abs([...
    mean(mean(array1(:, group_low))) - mean(mean(array2(:, group_low)));
    mean(mean(array1(:, group_med))) - mean(mean(array2(:, group_med)));
    mean(mean(array1(:, group_high))) - mean(mean(array2(:, group_high)));
    ]);

% Among the total sample
vec_cmp = repmat(df_mn, 1, iterations);
vec_res = zeros(size(df_mn, 1), iterations);

aux_vc = [...
        mean(array1(:, group_low)) - mean(array2(:, group_low)), ...
        mean(array1(:, group_med)) - mean(array2(:, group_med)), ...
        mean(array1(:, group_high)) - mean(array2(:, group_high))
        ];

for i = 1:iterations

    i_rand = randperm(size(aux_vc, 2));
            
    vec_perm = aux_vc(1, i_rand);    
    
    vec_res(1, i) = mean(vec_perm(:, 1:size(group_low, 2)));
    vec_res(2, i) = mean(vec_perm(:, size(group_low, 2)+1:size(group_low, 2)+size(group_med, 2)));
    vec_res(3, i) = mean(vec_perm(:, size(group_low, 2)+size(group_med, 2)+1:size(vec_perm, 2)));
    
end

pval_tot = sum(abs(vec_res) > vec_cmp, 2)/iterations;





end

% df_mn = abs([...
%     mean(mean(own_dyn_control(:, group1d))) - mean(mean(own_dyn_noise(:, group1d)));
%     mean(mean(own_dyn_control(:, group2d))) - mean(mean(own_dyn_noise(:, group2d)));
%     mean(mean(own_dyn_control(:, group3d))) - mean(mean(own_dyn_noise(:, group3d)))
%     ]);


% % within group
% vec_cmp = repmat(df_mn, 1, iterations);
% vec_res = zeros(1, iterations);
% 
% for i = 1:iterations
%     aux_vc = [...
%         mean(own_dyn_control(:, group3d)), mean(own_stat_gap(:, group3d));
%         ];
%     
%     i_rand = randperm(size(aux_vc, 2));
%             
%     vec_perm = aux_vc(1, i_rand);    
%     
%     vec_res(i) = mean(vec_perm(:, 1:5)) - mean(vec_perm(:, 6:size(vec_perm, 2)));
%     
% end
% pval_w = sum(abs(vec_res) > vec_cmp(3, :), 2)/iterations;

