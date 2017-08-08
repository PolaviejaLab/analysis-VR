function [pval_tot] = stat_bygroups (iterations, group_low, group_med, ...
    group_high, array1, array2)

df_mn = abs([...
    nanmean(nanmean(array1(:, group_low))) - nanmean(nanmean(array2(:, group_low)));
    nanmean(nanmean(array1(:, group_med))) - nanmean(nanmean(array2(:, group_med)));
    nanmean(nanmean(array1(:, group_high))) - nanmean(nanmean(array2(:, group_high)));
    ]);

% Among the total sample
vec_cmp = repmat(df_mn, 1, iterations);
vec_res = zeros(size(df_mn, 1), iterations);

aux_vc = [...
        nanmean(array1(:, group_low)) - nanmean(array2(:, group_low)), ...
        nanmean(array1(:, group_med)) - nanmean(array2(:, group_med)), ...
        nanmean(array1(:, group_high)) - nanmean(array2(:, group_high))
        ];

for i = 1:iterations

    i_rand = randperm(size(aux_vc, 2));
            
    vec_perm = aux_vc(1, i_rand);    
    
    vec_res(1, i) = nanmean(vec_perm(:, 1:size(group_low, 2)));
    vec_res(2, i) = nanmean(vec_perm(:, size(group_low, 2)+1:size(group_low, 2)+size(group_med, 2)));
    vec_res(3, i) = nanmean(vec_perm(:, size(group_low, 2)+size(group_med, 2)+1:size(vec_perm, 2)));
    
end

pval_tot = sum(abs(vec_res) > vec_cmp, 2)/iterations;





end


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

