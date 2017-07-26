%% Load data
load('E:\GitHub\analysis-VR\data\1. IndividualityInOwnership\handp.mat')
load('E:\GitHub\analysis-VR\data\1. IndividualityInOwnership\drift.mat')

%% Significance
it = 10000;



pval_mean_drift = zeros(size(drift, 2));

for cond1 = 1:size(drift, 2)
    for cond2 = 1:size(drift, 2)
        
        cmp_vec = ...
            repmat(nanmean(drift(:, cond1))/10 - nanmean(drift(:, cond2))/10, 1, it);
        res_vec = zeros(1, 10000);
        
        dvec = [(drift(:, cond1)/10)', (drift(:, cond2)/10)'];
        
        for i = 1:it
            i_rand = randperm(size(dvec, 2));
            vec_perm = dvec(i_rand);
            res_vec(1, i) = ...
                nanmean(vec_perm(1:floor(size(vec_perm,2)/2))) - ...
                nanmean(vec_perm(floor(size(vec_perm,2)/2)+1:end));
        end
        pval_mean_drift(cond1, cond2) = sum(abs(res_vec) < cmp_vec, 2)/it;
        
    end
end



pval_mean_handp = zeros(size(handp, 2));

for cond1 = 1:size(handp, 2)
    for cond2 = 1:size(handp, 2)
        
        cmp_vec = ...
            repmat(nanmean(handp(:, cond1)) * 100 - ...
            nanmean(handp(:, cond2)) * 100, 1, it);
        res_vec = zeros(1, 10000);
        
        dvec = [(handp(:, cond1) * 100)', (handp(:, cond2) * 100)'];
        
        for i = 1:it
            i_rand = randperm(size(dvec, 2));
            vec_perm = dvec(i_rand);
            res_vec(1, i) = ...
                nanmean(vec_perm(1:floor(size(vec_perm,2)/2))) - ...
                nanmean(vec_perm(floor(size(vec_perm,2)/2)+1:end));
        end
        pval_mean_handp(cond1, cond2) = sum(abs(res_vec) > cmp_vec, 2)/it;
        
    end
end

%%
diffp = handp - drift;
pval_diffp = nan(6); 

for cond1 = 1:size(diffp, 2)
    for cond2 = 1:size(diffp, 2)
        
        cmp_vec = ...
            repmat(nanmean(diffp(:, cond1)) - ...
            nanmean(diffp(:, cond2)), 1, it);
        res_vec = zeros(1, 10000);
        
        dvec = [diffp(:, cond1)', diffp(:, cond2)'];
        
        for i = 1:it
            i_rand = randperm(size(dvec, 2));
            vec_perm = dvec(i_rand);
            res_vec(1, i) = ...
                nanmean(vec_perm(1:floor(size(vec_perm,2)/2))) - ...
                nanmean(vec_perm(floor(size(vec_perm,2)/2)+1:end));
        end
        pval_diffp(cond1, cond2) = sum(abs(res_vec) > cmp_vec, 2)/it;
        
    end
end








