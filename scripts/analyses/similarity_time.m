%% Get Data
addpath('..\getData\');
[stat_array, dyn_array] = get_data (0);

%% Set the variables
nSimilar = 5;

%% Get the Arrays
stat_similar = squeeze(stat_array(nSimilar, :, :))';
dyn_similar = squeeze(dyn_array(nSimilar, :, :))';

%% 
mean_stat = mean (stat_similar);
std_stat = std(stat_similar);
mean_dyn = mean(dyn_similar);
std_dyn = std(dyn_similar);

figure(1), clf; hold on,
errorbar(mean_stat, std_stat, 'k'); 
plot(1:2, mean_stat, 'or', 'MarkerSize', 10, 'MarkerFace', 'r');
errorbar(3:7, mean_dyn, std_dyn, 'k');
plot(3:7, mean_dyn, 'or', 'MarkerSize', 10, 'MarkerFace', 'r');
ylim([0.5 7.5]); xlim([0.5 7.5]);
set(gca,'XTickLabel',{'S1', 'S2', 'D1', 'D2', 'D3', 'D4', 'D5'});
title('Similarity over time');
xlabel('Trial');
hold off, 

%% Mean normalized by divding by the first trial of each block
normal_div_stat = zeros (22, 2);
normal_div_dyn = zeros(22, 5);

normal_div_stat(:, 1) = stat_similar(:, 1) ./ stat_similar(:, 1);
normal_div_stat(:, 2) = stat_similar(:, 2) ./ stat_similar(:, 1);

normal_div_dyn(:, 1) = dyn_similar(:, 1) ./ dyn_similar(:, 1);
normal_div_dyn(:, 2) = dyn_similar(:, 2) ./ dyn_similar(:, 1);
normal_div_dyn(:, 3) = dyn_similar(:, 3) ./ dyn_similar(:, 1);
normal_div_dyn(:, 4) = dyn_similar(:, 4) ./ dyn_similar(:, 1);
normal_div_dyn(:, 5) = dyn_similar(:, 5) ./ dyn_similar(:, 1);

mn_norm_div_stat = mean(normal_div_stat);
std_norm_div_stat = std(normal_div_stat);

mn_norm_div_dyn = mean(normal_div_dyn);
std_norm_div_dyn = std(normal_div_dyn);

figure(2), clf; hold on,
errorbar(1:2, mn_norm_div_stat, std_norm_div_stat, 'k'); 
plot(1:2, mn_norm_div_stat, 'or', 'MarkerSize', 10, 'MarkerFace', 'r');
errorbar(3:7, mn_norm_div_dyn, std_norm_div_dyn, 'k'); 
plot(3:7, mn_norm_div_dyn, 'or', 'MarkerSize', 10, 'MarkerFace', 'r');
hold off;
ylim([0 2]); xlim([0.5 7.5]);
set(gca,'XTickLabel',{'S1', 'S2', 'D1', 'D2', 'D3', 'D4', 'D5'});
title('Similarity over time');
xlabel('Trial');


%% Mean normalized by substracting by the first trial of each block
normal_sub_stat = zeros(22, 2);
normal_sub_dyn = zeros(22, 5);

normal_sub_stat(:, 1) = stat_similar(:, 1) - stat_similar(:, 1);
normal_sub_stat(:, 2) = stat_similar(:, 2) - stat_similar(:, 1);

normal_sub_dyn(:, 1) = dyn_similar(:, 1) - dyn_similar(:, 1);
normal_sub_dyn(:, 2) = dyn_similar(:, 2) - dyn_similar(:, 1);
normal_sub_dyn(:, 3) = dyn_similar(:, 3) - dyn_similar(:, 1);
normal_sub_dyn(:, 4) = dyn_similar(:, 4) - dyn_similar(:, 1);
normal_sub_dyn(:, 5) = dyn_similar(:, 5) - dyn_similar(:, 1);

mn_norm_sub_stat = mean(normal_sub_stat);
std_norm_sub_stat = std(normal_sub_stat);

mn_norm_res_dyn = mean(normal_sub_dyn);
std_norm_res_dyn = std(normal_sub_dyn);

figure(3), clf; hold on,
errorbar(1:2, mn_norm_sub_stat, std_norm_sub_stat, 'k'); 
plot(1:2, mn_norm_sub_stat, 'or', 'MarkerSize', 10, 'MarkerFace', 'r');
errorbar(3:7, mn_norm_res_dyn, std_norm_res_dyn, 'k'); 
plot(3:7, mn_norm_res_dyn, 'or', 'MarkerSize', 10, 'MarkerFace', 'r');
hold off;
ylim([-3 3]); xlim([0.5 7.5]);
set(gca,'XTickLabel',{'S1', 'S2', 'D1', 'D2', 'D3', 'D4', 'D5'});
title('Similarity over time');
xlabel('Trial');