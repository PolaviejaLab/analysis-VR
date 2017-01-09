%% Get Data
addpath('..\getData\');
[stat_array, dyn_array] = get_data (0);

%% Set the variables
nOwnership = 1:4;

%% Arrays
owner_stat = stat_array(nOwnership, :, :);
owner_dyn = dyn_array(nOwnership, :, :);

qmean_s = squeeze(mean(owner_stat));
qmean_d = squeeze(mean(owner_dyn));
tmean_s = mean(qmean_s, 2);
tmean_d = mean(qmean_d, 2); 

std_s = std(qmean_s');
sdt_d = std(qmean_d');


%% Plot 
legend_font = 12;
axis_font = 16;
title_font = 18;

fig1 = figure(1); clf; hold on,
errorbar(tmean_s, std_s, 'k'); 
plot(1:2, tmean_s, 'or', 'MarkerSize', 10, 'MarkerFace', 'r');
errorbar(3:7, tmean_d, sdt_d, 'k');
plot(3:7, tmean_d, 'or', 'MarkerSize', 10, 'MarkerFace', 'r');
ylim([0.5 7.5]); xlim([0.5 7.5]);
set(gca,'XTickLabel',{'S1', 'S2', 'D1', 'D2', 'D3', 'D4', 'D5'}, 'FontSize', legend_font);
title('Sense of ownership over time', 'FontWeight', 'bold', 'FontSize', title_font);
xlabel('Trial', 'FontSize', axis_font, 'FontWeight', 'bold');
hold off, 
set(fig1,'units','normalized', 'Position', [0.15 0 0.48 0.75]);


%% Normalizing
norm_div_stat = zeros (22, 2);
norm_div_dyn = zeros (22, 5);

norm_div_stat(:, 1) = qmean_s(1, :) ./ qmean_s(1, :);
norm_div_stat(:, 2) = qmean_s(2, :) ./ qmean_s(1, :);


norm_div_dyn(:, 1) = qmean_d(1, :) ./ qmean_d(1, :);
norm_div_dyn(:, 2) = qmean_d(2, :) ./ qmean_d(1, :);
norm_div_dyn(:, 3) = qmean_d(3, :) ./ qmean_d(1, :);
norm_div_dyn(:, 4) = qmean_d(4, :) ./ qmean_d(1, :);
norm_div_dyn(:, 5) = qmean_d(5, :) ./ qmean_d(1, :);

mn_normdiv = mean(norm_div_stat);
std_normdiv = std(norm_div_stat);

mn_normdiv_d = mean(norm_div_dyn);
std_normdiv_d = std(norm_div_dyn);

fig2 = figure(2); clf; hold on,
legend_font = 12;
axis_font = 16;
title_font = 18;
errorbar(1:2, mn_normdiv, std_normdiv, 'k'); 
plot(1:2, mn_normdiv, 'or', 'MarkerSize', 10, 'MarkerFace', 'r');
errorbar(3:7, mn_normdiv_d, std_normdiv_d, 'k'); 
plot(3:7, mn_normdiv_d, 'or', 'MarkerSize', 10, 'MarkerFace', 'r');
ylim([0 2]); xlim([0.5 7.5]);
set(gca,'XTickLabel',{'S1', 'S2', 'D1', 'D2', 'D3', 'D4', 'D5'}, 'FontSize', legend_font);
title('Similarity over time', 'FontWeight', 'bold', 'FontSize', title_font);
xlabel('Trial', 'FontSize', axis_font, 'FontWeight', 'bold');
hold off, 
set(fig2,'units','normalized', 'Position', [0.15 0 0.48 0.75]);


%% Normalizing
norm_res_stat = zeros (22, 2);
norm_res_dyn = zeros(22, 5);

norm_res_stat(:, 1) = qmean_s(1, :) - qmean_s(1, :);
norm_res_stat(:, 2) = qmean_s(2, :) - qmean_s(1, :);

norm_res_dyn(:, 1) = qmean_d(1, :) - qmean_d(1, :);
norm_res_dyn(:, 2) = qmean_d(2, :) - qmean_d(1, :);
norm_res_dyn(:, 3) = qmean_d(3, :) - qmean_d(1, :);
norm_res_dyn(:, 4) = qmean_d(4, :) - qmean_d(1, :);
norm_res_dyn(:, 5) = qmean_d(5, :) - qmean_d(1, :);

mn_normres = mean(norm_res_stat);
std_normres = std(norm_res_stat);

mn_normres_d = mean(norm_res_dyn);
std_normres_d = std(norm_res_dyn);

fig3 = figure(3); clf; hold on,
errorbar(1:2, mn_normres, std_normres, 'k'); 
plot(1:2, mn_normres, 'or', 'MarkerSize', 10, 'MarkerFace', 'r');
errorbar(3:7, mn_normres_d, std_normres_d, 'k'); 
plot(3:7, mn_normres_d, 'or', 'MarkerSize', 10, 'MarkerFace', 'r');
hold off;
ylim([-3 3]); xlim([0.5 7.5]);
set(gca,'XTickLabel',{'S1', 'S2', 'D1', 'D2', 'D3', 'D4', 'D5'}, 'FontSize', legend_font);
title('Similarity over time', 'FontWeight', 'bold', 'FontSize', title_font);
xlabel('Trial', 'FontSize', axis_font, 'FontWeight', 'bold');
hold off, 
set(fig3,'units','normalized', 'Position', [0.15 0 0.48 0.75]);