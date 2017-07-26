addpath('..\statistics\');
% load('..\..\data\GSR_nocond.mat');
load('..\..\data\mat_GSR.mat');

%% Array of GSR data
d(1).raw = KOV;
d(2).raw = KOR;
d(3).raw = GAP;
d(4).raw = NOI;

clear('KOV', 'KOR', 'GAP', 'NOI');

%% Remove subjects
d(3).raw(:, 1) = [];
d(4).raw(:, 9) = [];


%% Normalize the values in each subject
for i_condition = 1:size(d, 2)
    for i_subject = 1:size(d(i_condition).raw, 2)
        d(i_condition).normalized(:, i_subject) = ...
            d(i_condition).raw(:, i_subject) - ...
            mean(d(i_condition).raw(1:50, i_subject));
    end
end

clear('data');


%% Define pre and post stimulus
pre_stimulus = 1:49;
post_stimulus = 51:100; % Armel and Ramandran use from 1 to 5 seconds


%% Measure the amplitude
for i_condition = 1:size(d, 2)
    % amplitude no normalization
    d(i_condition).amp_noNorm = ...
        max(d(i_condition).raw(post_stimulus, :)) - ...
        mean(d(i_condition).raw(pre_stimulus, :));
    
    % amplitude of each individual
    d(i_condition).amp_ind = ...
        max(d(i_condition).normalized(post_stimulus, :)) - ...
        mean(d(i_condition).normalized(pre_stimulus, :));
    
    % mean amplitude per condition
    d(i_condition).amp_tot_mean = ...
        mean(d(i_condition).amp_ind);
    
    % median amplitude per condition
    d(i_condition).amp_tot_median = ...
        median(d(i_condition).amp_ind);
end


%% Statistic Analysis

% repeat the one in analysis andres

% Difference between conditions, permutation analysis
it = 10000;

pval_mean = zeros(size(d, 2));
pval_median = zeros(size(d, 2));

for cond1 = 1:size(d, 2)
    for cond2 = 1:size(d, 2)
        
        
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
        pval_mean(cond1, cond2) = sum(abs(res_vec) > abs(cmp_vec))/10000;
        
    end
end

for cond1 = 1:size(d, 2)
    for cond2 = 1:size(d, 2)
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
        pval_median(cond1, cond2) = sum(abs(res_vec) > abs(cmp_vec))/10000;
        
    end
end


%% Using the log(amp + 1) and then calculating the means
% such as in Yuan and Steed (2010) and Ma and Hommel (2013).

for i_condition = 1:size(d, 2)
    d(i_condition).logMax = log(d(i_condition).amp_ind + 1);
end

for i_condition = 1:size(d, 2)
    % mean log amplitude
    d(i_condition).amp_log_mean = ...
        mean(d(i_condition).logMax);
    % median log amplitude
    d(i_condition).amp_log_median = ...
        median(d(i_condition).logMax);
end

% Not normalized
for i_condition = 1:size(d, 2)
    d(i_condition).logMax_noNorm = log(d(i_condition).amp_noNorm + 1);
end

for i_condition = 1:size(d, 2)
    % mean log amplitude
    d(i_condition).amp_lognoNorm_mean = ...
        mean(d(i_condition).logMax_noNorm);
    % median log amplitude
    d(i_condition).amp_lognoNorm_median = ...
        median(d(i_condition).logMax_noNorm);
end

%% Statistic analysis of logMax
for cond1 = 1:size(d, 2)
    for cond2 = 1:size(d, 2)
        
        cmp_vec = repmat(d(cond1).amp_lognoNorm_mean - d(cond2).amp_lognoNorm_mean, 1, it);
        res_vec = zeros(1, 10000);
        
        dvec = [d(cond1).logMax_noNorm, d(cond2).logMax_noNorm];
        
        for i = 1:it
            i_rand = randperm(size(dvec, 2));
            vec_perm = dvec(i_rand);
            ampMax1 = median(vec_perm(1:floor(size(vec_perm,2)/2)));
            ampMax2 = median(vec_perm(floor(size(vec_perm,2)/2)+1:end));
            res_vec(1, i) = ampMax1 - ampMax2;
            
        end
        pval_logMax_noNorm(cond1, cond2) = sum(abs(res_vec) > abs(cmp_vec))/10000;        
    end
end

for cond1 = 1:size(d, 2)
    for cond2 = 1:size(d, 2)
        
        cmp_vec = repmat(d(cond1).amp_log_mean - d(cond2).amp_log_mean, 1, it);
        res_vec = zeros(1, 10000);
        
        dvec = [d(cond1).logMax, d(cond2).logMax];
        
        for i = 1:it
            i_rand = randperm(size(dvec, 2));
            vec_perm = dvec(i_rand);
            ampMax1 = median(vec_perm(1:floor(size(vec_perm,2)/2)));
            ampMax2 = median(vec_perm(floor(size(vec_perm,2)/2)+1:end));
            res_vec(1, i) = ampMax1 - ampMax2;
            
        end
        pval_logMax(cond1, cond2) = sum(abs(res_vec) > abs(cmp_vec))/10000;        
    end
end


%%

% mean no normalized

for cond1 = 1:size(d, 2)
    for cond2 = 1:size(d, 2)
        
        cmp_vec = repmat(mean(d(cond1).amp_noNorm) - mean(d(cond2).amp_noNorm), 1, it);
        res_vec = zeros(1, 10000);
        
        dvec = [d(cond1).amp_noNorm, d(cond2).amp_noNorm];
        
        for i = 1:it
            i_rand = randperm(size(dvec, 2));
            vec_perm = dvec(i_rand);
            ampMax1 = median(vec_perm(1:floor(size(vec_perm,2)/2)));
            ampMax2 = median(vec_perm(floor(size(vec_perm,2)/2)+1:end));
            res_vec(1, i) = ampMax1 - ampMax2;
            
        end
        pval_noNorm(cond1, cond2) = sum(abs(res_vec) > abs(cmp_vec))/10000;
        
    end
end


%%  Plot the data

close all;

figure, hold on,
for i_condition = 1:size(d, 2)
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
for i_condition = 1:size(d, 2)
    h(i_condition) = bar(i_condition, d(i_condition).amp_tot_mean);
    
    errorbar(i_condition, nanmean(d(i_condition).amp_ind), ...
        nanstd(d(i_condition).amp_ind) / sqrt(size(d(i_condition).amp_ind,2)), 'k');
    
end
hold off, box on;

title('mean');
xlim([0.5, 4.5]);
set(gca, 'XTick', 1:1:4);

figure, hold on,
for i_condition = 1:size(d, 2)
    b(i_condition) = bar(i_condition, d(i_condition).amp_tot_median);
    
    errorbar(i_condition, nanmedian(d(i_condition).amp_ind), ...
        nanstd(d(i_condition).amp_ind) / sqrt(size(d(i_condition).amp_ind,2)), 'k');
    
end
hold off, box on;

title('median');
xlim([0.5, 4.5]);
set(gca, 'XTick', 1:1:4);

figure, hold on,
for i_condition = 1:size(d, 2)
    b(i_condition) = bar(i_condition, d(i_condition).amp_log_median);
    errorbar(i_condition, nanmedian(d(i_condition).logMax), ...
        nanstd(d(i_condition).logMax) / sqrt(size(d(i_condition).logMax,2)), 'k');
end
xlabel('conditions'); ylabel('log(amplitude + 1)');
xlim([0.5, 4.5]);
set(gca, 'XTick', 1:1:4)