addpath('..\statistics\');
% load('..\..\data\GSR_nocond.mat');
load('..\..\data\mat_GSR.mat');

%% Array of GSR data
data_raw = [];

data_raw(:,:,1) = KOV;
data_raw(:,:,2) = KOR;
data_raw(:,:,3) = GAP;
data_raw(:,:,4) = NOI;

clear('KOV', 'KOR', 'GAP', 'NOI');


%% Normalize the values
for i_condition = 1:size(data_raw, 3)
    for i_subject = 1:size(data_raw, 2)
        data(:, i_subject) = ...
            data_raw(:,i_subject, i_condition) - ...
            mean(data_raw(1:50, i_subject, i_condition));
        d(i_condition).normalized = data;
    end
    
end


%% Remove subjects
d(3).normalized(:, 1) = [];
d(4).normalized(:, 9) = [];


%% Define pre and post stimulus

pre_stimulus = 1:49;
post_stimulus = 51:100;



%% Measure the amplitude

for i_condition = 1:size(data_raw, 3)
    data = d(i_condition).normalized;
    
    % amplitude of each individual
    d(i_condition).amp_ind = ...
        max(data(post_stimulus, :)) - ...
        mean(data(pre_stimulus, :));
  
    
    
    % mean amplitude per condition
    d(i_condition).amp_tot_mean = mean( ...
        max(data(post_stimulus, :)) - ...
        mean(data(pre_stimulus, :)));
    
        % median amplitude per condition
    d(i_condition).amp_tot_median = median( ...
        max(data(post_stimulus, :)) - ...
        mean(data(pre_stimulus, :)));
    
end

%% Statistic Analysis

% repeat the one in analysis andres

% Difference between conditions, permutation analysis
it = 10000;

pval_mean = zeros(size(data_raw, 3));
pval_median = zeros(size(data_raw, 3));

for cond1 = 1:size(data_raw, 3)
    for cond2 = 1:size(data_raw, 3)


cmp_vec = repmat(d(cond1).amp_tot_mean - d(cond2).amp_tot_mean, 1, it);
res_vec = zeros(1, 10000);

dvec = [d(cond1).amp_ind, d(cond2).amp_ind];

for i = 1:it
    i_rand = randperm(size(dvec, 2));
    vec_perm = dvec(i_rand);
    res_vec(1, i) = ...
        mean(vec_perm(1:floor(size(vec_perm,2)/2))) - ...
        mean(vec_perm(floor(size(vec_perm,2)/2)+1:end));
end
pval_mean(cond1, cond2) = sum(abs(res_vec) > cmp_vec, 2)/10000;

    end
end

for cond1 = 1:size(data_raw, 3)
    for cond2 = 1:size(data_raw, 3)


cmp_vec = repmat(d(cond1).amp_tot_median - d(cond2).amp_tot_median, 1, it);
res_vec = zeros(1, 10000);

dvec = [d(cond1).amp_ind, d(cond2).amp_ind];

for i = 1:it
    i_rand = randperm(size(dvec, 2));
    vec_perm = dvec(i_rand);
    res_vec(1, i) = ...
        median(vec_perm(1:floor(size(vec_perm,2)/2))) - ...
        median(vec_perm(floor(size(vec_perm,2)/2)+1:end));
end
pval_mean(cond1, cond2) = sum(abs(res_vec) > cmp_vec, 2)/10000;

    end
end


%%  Plot the data

figure, hold on,
for i_condition = 1:size(data_raw, 3)
    p(1, i_condition) = ...
        plot(mean(d(i_condition).normalized, 2), 'linewidth', 2);
    p(2, i_condition) = ...
        plot(std(d(i_condition).normalized, 1, 2)/sqrt(size(d(i_condition).normalized, 2)) + ...
        mean(d(i_condition).normalized, 2), 'linewidth', 1);
    p(3, i_condition) = ...
        plot(-std(d(i_condition).normalized, 1, 2)/sqrt(size(d(i_condition).normalized, 2)) + ...
        mean(d(i_condition).normalized, 2), 'linewidth', 1);
end

hold off, box on;

figure, hold on,
for i_condition = 1:size(data_raw, 3)
    b(i_condition) = bar(i_condition, d(i_condition).amp_tot_median);
 
    errorbar(i_condition, nanmedian(d(i_condition).amp_ind), ...
        nanstd(d(i_condition).amp_ind) / sqrt(size(d(i_condition).amp_ind,2)), 'k');

end
hold off, box on;

xlim([0.5, 4.5]);
set(gca, 'XTick', 1:1:4)


