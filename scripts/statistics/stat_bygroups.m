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

aux_vc = [mean(array1), mean(array2)];

for i = 1:iterations

    i_rand = randperm(size(aux_vc, 2));
            
    vec_perm = aux_vc(1, i_rand);
    
    sample1 = vec_perm(:, 1:floor(size(vec_perm, 2)/2));
    sample2 = vec_perm(:, floor(size(vec_perm, 2)/2)+1:end);
    
    vec_res(:,i) = [...
        nanmean(sample1(:, group_low)) - nanmean(sample2(:, group_low));
        nanmean(sample1(:, group_med)) - nanmean(sample2(:, group_med));
        nanmean(sample1(:, group_high)) - nanmean(sample2(:, group_high));
        ];

% vec_res(:,i) = [...
%     nanmean(sample1(:, 1:size(group_low,2))) - nanmean(sample2(:, 1:size(group_low,2))); ...
%     nanmean(sample1(:,size(group_low,2)+1:size(group_low,2)+size(group_med,2))) - ...
%         nanmean(sample2(:,size(group_low,2)+1:size(group_low,2)+size(group_med,2))); ...
%     nanmean(sample1(:,size(group_low,2)+size(group_med,2)+1:size(vec_perm,2)/2)) - ...
%         nanmean(sample2(:,size(group_low,2)+size(group_med,2)+1:size(vec_perm,2)/2));
% 
%     ];
    

    
    
end

pval_tot = sum(abs(vec_res) > vec_cmp, 2)/iterations;

end

