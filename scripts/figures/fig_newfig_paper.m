addpath('formatting\');


%% Loading data
load('..\..\data\arrays_ownstat.mat');
load('..\..\data\arrays_owndyn.mat');
load('..\..\data\arrays_agndyn.mat');
load('..\..\data\arrays_locdyn.mat');
load('..\..\data\arrays_locstat.mat');

load('..\..\data\bit_for_Frontiers.mat');

load('..\..\data\drift.mat');

c = parula;
c = c(1:2:64,:);

c_o = 6;
c_a = 20;
c_l = 18;

edge = 1:7;


%% Figure 2 - Basal dynamic vs basal static

% Panel A - histogram and distribution
fig2 = figure(2); clf;
set(fig2, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);

subplot('Position', [0.13, 0.8, 0.77, 0.1]); hold on;
line([0 3], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':', ...
    'LineWidth', 1.5); 
b(1) = bar(1, mean(own_stat_nogap(:)), 0.5); 
b(2) = bar(2, mean(own_dyn_control(:)), 0.5); 

errorbar([1, 2], [mean(own_stat_nogap(:)), ...
    mean(own_dyn_control(:))], ...
    [std(own_stat_nogap(:))/sqrt(numel(own_stat_nogap)), ...
    std(own_dyn_control(:))/sqrt(numel(own_dyn_control))], '.k'); 
hold off; box on; view([90 90]);

set(b(1), 'FaceColor', c(c_o, :)); set(b(2), 'FaceColor', c(c_o - 5, :));
line([3 3], [0 8], 'color', 'k'); 
% line([1 2], [6.5 6.5], 'Color', 'black'); text(1.5, 6.65, '*', ...
%     'FontWeight', 'bold', 'FontSize', 14); 
xlim([0.5 2.5]); ylim([0.9 7.15]);
set(gca, 'XTick', [], 'XTickLabel', {'', ''}, 'YTick', 1:1:7, 'Fontsize', 9);
title('Sense of ownership', 'FontWeight', 'bold');

subplot('Position', [0.13, 0.15, 0.77, 0.65]); hold on;
line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':', ...
    'LineWidth', 1.5); 
p_1(1) = plot(edge, hist(own_stat_nogap(:), edge)/numel(own_stat_nogap), ...
    'color', c(c_o, :), 'LineWidth', 3); 
p_1(2) = plot(edge, hist(own_dyn_control(:), edge)/numel(own_dyn_control), ...
    'color', c(c_o - 5, :), 'LineWidth', 3); 
line([mean(own_stat_nogap(:)), mean(own_stat_nogap(:))], [-0.1 1.1], ...
    'color', c(c_o, :));
line([mean(own_dyn_control(:)), mean(own_dyn_control(:))], [-0.1 1.1], ...
    'color', c(c_o - 5, :));
hold off; box on;

ylim([0 0.5]); xlim([0.9 7.15]); 
ylabel('Probability density');
xlabel('Responses to questionnaires'); 
set(gca, 'YTick', 0.1:0.1:0.5, ...
    'YTickLabel', {'0.1', '0.2', '0.3', '0.4', ''}, ...
    'Fontsize', 8);
set(gca, 'XTick', 1:1:7, 'XTickLabel', 1:7, 'FontSize', 8); 

legend(p_1, {'Basal static', 'Basal dynamic'}, 'Location', 'Northwest', ...
    'Fontsize', 8, 'FontWeight', 'bold');

%%

% Panel B - Scatter plot with the correlations. 
fig2 = figure(2); clf;
set(fig2, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);

subplot('Position', [0.13, 0.15, 0.77, 0.75]); hold on;

ylim([0.5 7.5]); xlim([0.5 7.5]);

line([0 8], [0 8], 'LineStyle', ':', 'color', [220/255 220/255 220/255]);
line([3 3], [0 3], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1); line([0 3], [3 3], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1);
line([5 5], [0 5], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1); line([0 5], [5 5], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1);

plot(mean(own_stat_nogap), mean(own_dyn_control),...
    '.k', 'MarkerSize', 15);

% g1_stat = find(mean(own_stat_nogap) <= 3);
% g2_stat = find(mean(own_stat_nogap) > 3 & mean(own_stat_nogap) < 5);
% g3_stat = find(mean(own_stat_nogap) >= 5);

% plot(mean(mean(own_stat_nogap(:, g1_stat))), ...
%     mean(mean(own_dyn_control(:, g1_stat))) - ...
%     mean(mean(own_stat_nogap(:, g1_stat))), '^b', ...
%     'MarkerSize', 13);
% plot(mean(mean(own_stat_nogap(:, g2_stat))), ...
%     mean(mean(own_dyn_control(:, g2_stat))) - ...
%     mean(mean(own_stat_nogap(:, g2_stat))), 'xb', ...
%     'MarkerSize', 13);
% plot(mean(mean(own_stat_nogap(:, g3_stat))), ...
%     mean(mean(own_dyn_control(:, g3_stat))) - ...
%     mean(mean(own_stat_nogap(:, g3_stat))), 'xb', ...
%     'MarkerSize', 13);
hold off; box on;

xlabel('Basal static');
ylabel('Basal dynamic');

title('Sense of ownership', 'FontWeight', 'bold');
set(gca, 'XTick', 1:1:7, 'XTickLabel', 1:7, 'FontSize', 8); 

%%
% Annotatations
annotation('textbox', [0.53, 0.575 + 0.325, 0.05, 0.05], ...
    'String', 'B', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 15, 'FontWeight', 'bold');

annotation('textbox', [0.03, 0.575 + 0.325, 0.05, 0.05], ...
    'String', 'A', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 15, 'FontWeight', 'bold');


%% Figure 3 - 

fig3 = figure(3); clf;
set(fig3, 'units', 'centimeters', 'position', [5 5 18.0 20.0]);

diff_position = handp_ - drift_;
diff_position(6,2) = NaN;

% Panel 1 - Proprioceptive drift
subplot('Position', [0.075, 0.575, 0.37, 0.35]); hold on;

plot(nanmean(diff_position(:, 1:6)) * 100, '.', 'Color', ...
    c(15, :), 'MarkerSize', 15);

% plot([1 2],[0 0], 'LineStyle', ':', 'color', ...
%     [150/256 150/256 150/256], 'LineWidth', 2.5);
% plot([3 6],[10 10], 'LineStyle', ':', 'color', ...
%     [150/256 150/256 150/256], 'LineWidth', 2.5);

legend ({'perceived difference', 'real difference'}, ...
    'location', 'northwest', 'FontSize', 8);

for i = 1:6  
    errorbar(i, nanmean(diff_position(:, i)) * 100, ...
        nanstd(diff_position(:, i) * 100)/sqrt(20), ...
        'Color', c(15, :));
end

hold off; box on;

ylim([-3 11]); xlim([0.5 6.5]);
xlabel('Condition', 'fontsize', 11, 'FontWeight', 'bold');
ylabel('Real - Perceived Position [cm]', 'fontsize', 11, 'FontWeight', 'bold');
set(gca, 'XTick', 1:6, 'XTickLabel', {'T' 'N-O' 'Bsl' 'OnR' 'Dsc' 'Ns'}, ...
    'FontSize', 9);
% line([5 6], [7 7], 'Color', 'black'); text(5.5, 7.25, '*', 'FontSize', 13, 'FontWeight', 'bold'); 

set(gca, 'XTick', 1:6, 'XTickLabel', {'T' 'N-O' 'Bsl' 'OnR' 'Dsc' 'Ns'}, ...
    'FontSize', 9);
title('Proprioceptive Drift', 'fontsize', 13, 'fontweight', 'bold');

%% 
fig3 = figure(3); clf;
set(fig3, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);

%%%
% Panel B - Reported  Sense of location
%%%
subplot('Position', [0.13, 0.8, 0.77, 0.1]);cla; hold on;

line([0 3], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

b(1) = bar(1, mean(loc_dyn_control(:)), 0.5); 
b(2) = bar(2, mean(loc_dyn_nooffset(:)), 0.5); 

errorbar([1, 2], [mean(loc_dyn_control(:)), ...
    mean(loc_dyn_nooffset(:))], ...
    [std(loc_dyn_control(:))/sqrt(numel(loc_dyn_control)), ...
    std(loc_dyn_nooffset(:))/sqrt(numel(loc_dyn_nooffset))], '.k'); 
hold off; box on; view([90 90]);

set(b(1), 'FaceColor', c(c_l, :)); set(b(2), 'FaceColor', c(c_l - 5, :));
line([3 3], [0 8], 'color', 'k'); 
line([1 2], [6.75 6.75], 'Color', 'black'); text(1.5, 6.85, '*', ...
    'FontWeight', 'bold', 'FontSize', 14); 
xlim([0.5 2.5]); ylim([0.9 7.15]);
set(gca, 'XTick', [], 'XTickLabel', {'', ''}, 'YTick', 1:1:7, 'Fontsize', 9);
hold off; box on;
title('Sense of Location', 'fontsize', 13, 'fontweight', 'bold');

subplot('Position', [0.13, 0.15, 0.77, 0.65]); hold on;
line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 
p_1(1) = plot(edge, hist(loc_dyn_control(:), edge)/numel(loc_dyn_control), ...
    'color', c(c_l, :), 'LineWidth', 3); 
p_1(2) = plot(edge, hist(loc_dyn_nooffset(:), edge)/numel(loc_dyn_nooffset), ...
    'color', c(c_l - 5, :), 'LineWidth', 3); 
line([mean(loc_dyn_control(:)), mean(loc_dyn_control(:))], [-0.1 1.1], ...
    'color', c(c_l, :));
line([mean(loc_dyn_nooffset(:)), mean(loc_dyn_nooffset(:))], [-0.1 1.1], ...
    'color', c(c_l - 5, :));
hold off; box on;
ylim([0 0.75]); xlim([0.9 7.15]); 
legend(p_1, {'basal', 'no-offset'}, 'location', 'northwest', ...
    'fontsize', 8);
set(gca, 'fontsize', 9);
xlabel('Responses to questionnaires', 'FontWeight', 'bold', 'FontSize', 11); 
ylabel('Probability distribution', 'fontsize', 11, 'fontweight', 'bold');


%% 
%%%
% PANEL 3 - Self-reports location
%%%
subplot('Position', [0.075, 0.1, 0.37, 0.35]); hold on;
line([50 50], [0.5 1.5], 'Color', [225/255 75/255 50/255], ...
    'LineStyle', :, 'LineWidth', 1); 
p(1) = plot(1:100, res_frame(2, :), ... % basal
    'linewidth', 3, 'color', c(5, :));
p(2) = plot(1:100, res_frame(1, :), ... % knife on real
    'linewidth', 3, 'color', c(18, :));
hold off; box on;

ylim([0.95 1.25]);
legend(p, {'basal dynamic', 'on-real'}, 'location', 'northwest', 'FontSize', 8);
set(gca, 'XTick', 0:10:100, 'XTickLabel', -5:1:5, 'fontsize', 9);

xlabel('Time to threat', 'fontsize', 11, 'FontWeight', 'bold');
ylabel('Normalization', 'fontsize', 12, 'FontWeight', 'bold');
title('Reaction to threat', 'fontsize', 13, 'fontweight', 'bold');


%%

fig3 = figure(3); clf;
set(fig3, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);
%%%
% PANEL D - - Self-reports knife-on-real
%%%
subplot('Position', [0.13, 0.8, 0.77, 0.1]); hold on;
line([0 3], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

b(1) = bar(1, mean(own_dyn_control(:)), 0.5); 
b(2) = bar(2, mean(own_dyn_kor(:)), 0.5); 

errorbar([1, 2], [mean(own_dyn_control(:)), ...
    mean(own_dyn_kor(:))], ...
    [std(own_dyn_control(:))/sqrt(numel(own_dyn_control)), ...
    std(own_dyn_kor(:))/sqrt(numel(own_dyn_kor))], '.k'); 
hold off; box on; view([90 90]);

set(b(1), 'FaceColor', c(c_o, :)); set(b(2), 'FaceColor', c(c_o - 5, :));
line([3 3], [0 8], 'color', 'k'); 
xlim([0.5 2.5]); ylim([0.9 7.15]);
set(gca, 'XTick', [], 'XTickLabel', {'', ''}, 'YTick', 1:1:7, 'Fontsize', 9);
hold off; box on;
set(gca, 'fontsize', 8);
title('Sense of Ownership', 'fontsize', 13, 'fontweight', 'bold');


subplot('Position', [0.13, 0.15, 0.77, 0.65]); hold on;
line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 
p_1(1) = plot(edge, hist(own_dyn_control(:), edge)/numel(own_dyn_control), ...
    'color', c(c_o, :), 'LineWidth', 3); 
p_1(2) = plot(edge, hist(own_dyn_kor(:), edge)/numel(own_dyn_kor), ...
    'color', c(c_o - 5, :), 'LineWidth', 3); 
line([mean(own_dyn_control(:)), mean(own_dyn_control(:))], [-0.1 1.1], ...
    'color', c(c_o, :));
line([mean(own_dyn_kor(:)), mean(own_dyn_kor(:))], [-0.1 1.1], ...
    'color', c(c_o - 5, :));
hold off; box on;
ylim([0 0.75]); xlim([0.9 7.15]); 

legend(p_1, {'basal dynamic', 'on-real'}, 'location', 'northwest', ...
    'fontsize', 8);
set(gca, 'fontsize', 9);

xlabel('Responses to questionnaires', 'FontWeight', 'bold', 'FontSize', 11); 
ylabel('Probability distribution', 'fontsize', 11, 'fontweight', 'bold');

%%

% Annotatations
annotation('textbox', [0, 0.925, 0.05, 0.05], ...
    'String', 'A', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 15, 'FontWeight', 'bold');

annotation('textbox', [0.475, 0.925, 0.05, 0.05], ...
    'String', 'B', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 15, 'FontWeight', 'bold');

annotation('textbox', [0, 0.45, 0.05, 0.05], ...
    'String', 'C', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 15, 'FontWeight', 'bold');

annotation('textbox', [0.475, 0.45, 0.05, 0.05], ...
    'String', 'D', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 15, 'FontWeight', 'bold');



%% Figure 4 - Noise
fig4 = figure(4); clf;
set(fig4, 'units', 'centimeters', 'position', [5 5 18.0 20.0]);


%%
%%%
% Panel A - Sense of agency
%%%
fig2 = figure(2); clf;
set(fig2, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);

subplot('Position', [0.13, 0.15, 0.77, 0.65]); hold on;

line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

p(1) = plot(edge, hist(agn_dyn_control(:), edge)/numel(agn_dyn_control), ...
    'color', c(c_a, :), 'LineWidth', 3); 
p(2) = plot(edge, hist(agn_dyn_noise(:), edge)/numel(agn_dyn_noise), ...
    'color', c(c_a - 5, :), 'LineWidth', 3); 

line([mean(agn_dyn_control(:)), mean(agn_dyn_control(:))], [-0.1 1.1], ...
    'color', c(c_a, :));
line([mean(agn_dyn_noise(:)), mean(agn_dyn_noise(:))], [-0.1 1.1], ...
    'color', c(c_a - 5, :)); 
hold off; box on;

legend(p, {'Basal dynamic', 'Noise'}, ...
    'location', 'northwest', ...
    'FontSize', 8, 'FontWeight', 'bold');

ylim([0 0.85]); xlim([0.9 7.15]); 
set(gca, 'YTick', 0.1:0.1:0.8, 'FontSize', 9);
xlabel('Responses to questionnaires', 'FontSize', ...
    11, 'FontWeight', 'bold');
ylabel('Probability density', 'FontSize', ...
    11, 'FontWeight', 'bold');



subplot('Position', [0.13, 0.8, 0.77, 0.1]); hold on;
line([0 4], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

b(1) = bar(1, mean(agn_dyn_control(:)), 0.5); 
b(2) = bar(2, mean(agn_dyn_noise(:)), 0.5); 

errorbar([1, 2], [mean(agn_dyn_control(:)), mean(agn_dyn_noise(:))], [...
    std(agn_dyn_control(:))/sqrt(numel(agn_dyn_control)), ...
    std(agn_dyn_noise(:))/sqrt(numel(agn_dyn_noise))], '.k'); 
hold off; box on;

set(b(1), 'FaceColor', c(c_a, :));
set(b(2), 'FaceColor', c(c_a - 5, :));

view([90 90]);
xlim([0.5 2.5]); ylim([0.9 7.15]);

set(gca, 'XTick', [], 'XTickLabel', {'', ''});
set(gca, 'YTickLabel', {'', '', '', '', '', '', ''}); 
title('Sense of agency', 'FontWeight', 'bold', 'FontSize', 13);

line([1 2], [6.8 6.8], 'Color', 'black');
text(1.5, 6.95, '*', 'FontWeight', 'bold', 'FontSize', 12);

%%
%%%
% PANEL B - Sense of ownership
%%%
fig2 = figure(2); clf;
set(fig2, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);
subplot('Position', [0.13, 0.15, 0.77, 0.65]); hold on;
line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

p(1) = plot(edge, hist(own_dyn_control(:), edge)/numel(own_dyn_control), ...
    'color', c(c_o, :), 'LineWidth', 3); 
p(2) = plot(edge, hist(own_dyn_noise(:), edge)/numel(own_dyn_noise), ...
    'color', c(c_o - 5, :), 'LineWidth', 3); 
line([mean(own_dyn_control(:)), mean(own_dyn_control(:))], [-0.1 1.1], ...
    'color', c(c_o, :));
line([mean(own_dyn_noise(:)), mean(own_dyn_noise(:))], [-0.1 1.1], ...
    'color', c(c_o - 5, :)); 
hold off; box on 

xlim([0.9 7.15]); ylim([0 0.5]);
legend(p, {'Basal dynamic', 'Noise'}, 'location', 'northwest', ...
    'FontSize', 8, 'FontWeight', 'bold');
ylabel('Probability density', 'FontSize', ...
    11, 'FontWeight', 'bold');
xlabel('Responses to questionnaires', 'FontSize', ...
    11, 'FontWeight', 'bold');
set(gca, 'YTick', 0.1:0.1:0.5, 'YTickLabel', ...
    {'0.1', '0.2', '0.3', '0.4', '0.5'}, ...
    'Fontsize', 9);


subplot('Position', [0.13, 0.8, 0.77, 0.1]); hold on;
line([0 4], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 
b(1) = bar(1, mean(own_dyn_control(:)), 0.5); 
b(2) = bar(2, mean(own_dyn_noise(:)), 0.5); 
errorbar([1, 2], [mean(own_dyn_control(:)), mean(own_dyn_noise(:))], [...
    std(own_dyn_control(:))/sqrt(numel(own_dyn_control)), ...
    std(own_dyn_noise(:))/sqrt(numel(own_dyn_noise))], '.k'); 
hold off; box on;

set(b(1), 'FaceColor', c(c_o, :));
set(b(2), 'FaceColor', c(c_o - 5, :));
view([90 90]);

xlim([0.5 2.5]); ylim([0.9 7.15]);
set(gca, 'XTick', [], 'XTickLabel', {'', ''}, ...
    'YTickLabel', {'', '', '', '', '', '', ''}, ... 
    'fontsize', 9);
title('Sense of ownership', 'FontWeight', 'bold', 'FontSize', 13);

line([1 2], [6.5 6.5], 'Color', 'black');
text(1.5, 6.65, '*', 'FontWeight', 'bold', 'FontSize', 12); box on;


%%
%%%
% PANEL C - Correlations sense of ownership
%%%
% g1_dyn = find(mean(own_dyn_control) <= 3);
% g2_dyn = find(mean(own_dyn_control) > 3 & mean(own_dyn_control) < 5);
% g3_dyn = find(mean(own_dyn_control) >= 5);


fig2 = figure(2); clf;
set(fig2, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);
subplot('Position', [0.13, 0.15, 0.77, 0.75]); hold on;

ylim([0.5 7.5]); xlim([0.5 7.5]);

line([0 8], [0 8], 'LineStyle', ':', 'color', [220/255 220/255 220/255]);
line([3 3], [0 3], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1); line([0 3], [3 3], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1);
line([5 5], [0 5], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1); line([0 5], [5 5], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1);

plot(mean(own_dyn_control), mean(own_dyn_noise), ...
    '.k', 'MarkerSize', 15);
% plot(mean(mean(own_dyn_control(:, g1_dyn))), ...
%     mean(mean(own_dyn_noise(:, g1_dyn))) - ...
%     mean(mean(own_dyn_control(:, g1_dyn))), 'xb', 'MarkerSize', 15);
% plot(mean(mean(own_dyn_control(:, g2_dyn))), ...
%     mean(mean(own_dyn_noise(:, g2_dyn))) - ...
%     mean(mean(own_dyn_control(:, g2_dyn))), 'xb', 'MarkerSize', 15);
% plot(mean(mean(own_dyn_control(:, g3_dyn))), ...
%     mean(mean(own_dyn_noise(:, g3_dyn))) - ...
%     mean(mean(own_dyn_control(:, g3_dyn))), 'vb', 'MarkerSize', 12);

hold on; box on;

xlabel('Basal dynamic');
ylabel('Noise dynamic');
set(gca, 'XTick', 1:1:7, 'XTickLabel', 1:1:7);
title('Sense of ownership', 'FontWeight', 'bold');

%%
%%%
% Panel D - GSR
%%%
subplot('Position', [0.55 0.1 0.37 0.35]); hold on;
line([50 50], [0.5 1.5], 'Color', [225/255 75/255 50/255], ...
    'LineStyle', :, 'LineWidth', 1); 
p(1) = plot(1:100, res_frame(2, :), ... % basal
    'linewidth', 3, 'color', c(5, :));
p(2) = plot(1:100, res_frame(3, :), ... % knife on real
    'linewidth', 3, 'color', c(18, :));
hold off; box on;

ylim([0.95 1.25]);
legend(p, {'Basal dynamic', 'Noise'}, 'location', ...
    'northwest', 'FontSize', 8, 'fontweight', 'bold');
set(gca, 'XTick', 0:10:100, 'XTickLabel', -5:1:5, 'fontsize', 9);

xlabel('Time to threat', 'fontsize', 11, 'FontWeight', 'bold');
ylabel('Normalization', 'fontsize', 12, 'FontWeight', 'bold');
title('Reaction to threat', 'fontsize', 13, 'fontweight', 'bold');

% Annotatations
annotation('textbox', [0, 0.925, 0.05, 0.05], ...
    'String', 'A', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 15, 'FontWeight', 'bold');

annotation('textbox', [0.475, 0.925, 0.05, 0.05], ...
    'String', 'B', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 15, 'FontWeight', 'bold');

annotation('textbox', [0, 0.45, 0.05, 0.05], ...
    'String', 'C', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 15, 'FontWeight', 'bold');

annotation('textbox', [0.475, 0.45, 0.05, 0.05], ...
    'String', 'D', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 15, 'FontWeight', 'bold');


%% Figure 5 - Effect of discontinuity
fig5 = figure(5); clf;
set(fig5, 'units', 'centimeters', 'position', [5 0.2 18.0 30.0]);

%%%
% PANEL A - Sense of ownership - static
%%%
fig2 = figure(5); clf;
set(fig2, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);

subplot('Position', [0.13, 0.15, 0.77, 0.65]); hold on;
line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

p(1) = plot(edge, hist(own_stat_nogap(:), edge)/numel(own_stat_nogap), ...
    'color', c(c_o, :), 'LineWidth', 3); 
p(2) = plot(edge, hist(own_stat_gap(:), edge)/numel(own_stat_gap), ...
    'color', c(c_o - 5, :), 'LineWidth', 3); 
line([mean(own_stat_nogap(:)), mean(own_stat_nogap(:))], [-0.1 1.1], ...
    'color', c(c_o, :));
line([mean(own_stat_gap(:)), mean(own_stat_gap(:))], [-0.1 1.1], ...
    'color', c(c_o - 5, :)); 
hold off; box on 

xlim([0.9 7.15]); ylim([0 0.45]);
legend(p, {'Basal static', 'Discontinuous static'}, 'location', 'northwest', ...
    'FontSize', 8, 'FontWeight', 'bold');
ylabel('Probability density', 'FontSize', ...
    11, 'FontWeight', 'bold');
xlabel('Responses to questionnaires', 'FontSize', ...
    11, 'FontWeight', 'bold');
set(gca, 'YTick', 0.1:0.1:0.4, 'YTickLabel', ...
    {'0.1', '0.2', '0.3', '0.4'}, ...
    'Fontsize', 9);

subplot('Position', [0.13, 0.8, 0.77, 0.1]); hold on;
line([0 4], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 
b(1) = bar(1, mean(own_stat_nogap(:)), 0.5); 
b(2) = bar(2, mean(own_stat_gap(:)), 0.5); 
errorbar([1, 2], [mean(own_stat_nogap(:)), mean(own_stat_gap(:))], [...
    std(own_stat_nogap(:))/sqrt(numel(own_stat_nogap)), ...
    std(own_stat_gap(:))/sqrt(numel(own_stat_gap))], '.k'); 
hold off; box on;

set(b(1), 'FaceColor', c(c_o, :));
set(b(2), 'FaceColor', c(c_o - 5, :));
view([90 90]);

xlim([0.5 2.5]); ylim([0.9 7.15]);
set(gca, 'XTick', [], 'XTickLabel', {'', ''}, ...
    'YTickLabel', {'', '', '', '', '', '', ''}, ... 
    'fontsize', 9);
title('Sense of ownership', 'FontWeight', 'bold', 'FontSize', 13);

line([1 2], [6.5 6.5], 'Color', 'black');
text(1.5, 6.65, '*', 'FontWeight', 'bold', 'FontSize', 12); box on;

%%
%%%%
% PANEL B - Correlations
%%%%
fig2 = figure(5); clf;
set(fig2, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);
subplot('Position', [0.13, 0.15, 0.77, 0.75]); hold on;
ylim([0.5 7.5]); xlim([0.5 7.5]);

line([0 8], [0 8], 'LineStyle', ':', 'color', [220/255 220/255 220/255]);
line([3 3], [0 3], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1); line([0 3], [3 3], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1);
line([5 5], [0 5], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1); line([0 5], [5 5], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1);

plot(mean(own_stat_nogap), mean(own_stat_gap), ...
    '.k', 'MarkerSize', 15);
% plot(mean(mean(own_stat_nogap(:, g1_stat))), ...
%     mean(mean(own_stat_gap(:, g1_stat))) - ...
%     mean(mean(own_stat_nogap(:, g1_stat))), 'xb', 'MarkerSize', 15);
% plot(mean(mean(own_stat_nogap(:, g2_stat))), ...
%     mean(mean(own_stat_gap(:, g2_stat))) - ...
%     mean(mean(own_stat_nogap(:, g2_stat))), 'xb', 'MarkerSize', 15);
% plot(mean(mean(own_stat_nogap(:, g3_stat))), ...
%     mean(mean(own_stat_gap(:, g3_stat))) - ...
%     mean(mean(own_stat_nogap(:, g3_stat))), 'vb', 'MarkerSize', 12);

hold on; box on;
set(gca, 'XTick', 1:1:7, 'XTickLabel', 1:1:7);
xlabel('Basal static');
ylabel('Discontinuity static');
title('Sense of ownership', 'FontWeight', 'bold');

%%
%%%%
% PANEL C - sense of ownership dynamic
%%%%
fig2 = figure(5); clf;
set(fig2, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);

subplot('Position', [0.13, 0.15, 0.77, 0.65]); hold on;
line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

p(1) = plot(edge, hist(own_dyn_control(:), edge)/numel(own_dyn_control), ...
    'color', c(c_o, :), 'LineWidth', 3); 
p(2) = plot(edge, hist(own_dyn_gap(:), edge)/numel(own_dyn_gap), ...
    'color', c(c_o - 5, :), 'LineWidth', 3); 
line([mean(own_dyn_control(:)), mean(own_dyn_control(:))], [-0.1 1.1], ...
    'color', c(c_o, :));
line([mean(own_dyn_gap(:)), mean(own_dyn_gap(:))], [-0.1 1.1], ...
    'color', c(c_o - 5, :)); 
hold off; box on 

xlim([0.9 7.15]); ylim([0 0.45]);
legend(p, {'Basal dynamic', 'Discontinuous dynamic'}, 'location', 'northwest', ...
    'FontSize', 8, 'FontWeight', 'bold');
ylabel('Probability density', 'FontSize', ...
    11, 'FontWeight', 'bold');
xlabel('Responses to questionnaires', 'FontSize', ...
    11, 'FontWeight', 'bold');
set(gca, 'YTick', 0.1:0.1:0.4, 'YTickLabel', ...
    {'0.1', '0.2', '0.3', '0.4'}, ...
    'Fontsize', 9);

subplot('Position', [0.13, 0.8, 0.77, 0.1]); hold on;
line([0 4], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 
b(1) = bar(1, mean(own_dyn_control(:)), 0.5); 
b(2) = bar(2, mean(own_dyn_gap(:)), 0.5); 
errorbar([1, 2], [mean(own_dyn_control(:)), mean(own_dyn_gap(:))], [...
    std(own_dyn_control(:))/sqrt(numel(own_dyn_control)), ...
    std(own_dyn_gap(:))/sqrt(numel(own_dyn_gap))], '.k'); 
hold off; box on;

set(b(1), 'FaceColor', c(c_o, :));
set(b(2), 'FaceColor', c(c_o - 5, :));
view([90 90]);

xlim([0.5 2.5]); ylim([0.9 7.15]);
set(gca, 'XTick', [], 'XTickLabel', {'', ''}, ...
    'YTickLabel', {'', '', '', '', '', '', ''}, ... 
    'fontsize', 9);
title('Sense of ownership', 'FontWeight', 'bold');

%%
%%%
% Panel D - Correlation dynamic
%%%
fig2 = figure(5); clf;
set(fig2, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);

subplot('Position', [0.13, 0.15, 0.77, 0.75]); hold on;
ylim([0.5 7.5]); xlim([0.5 7.5]);

line([0 8], [0 8], 'LineStyle', ':', 'color', [220/255 220/255 220/255]);
line([3 3], [0 3], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1); line([0 3], [3 3], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1);
line([5 5], [0 5], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1); line([0 5], [5 5], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1);

plot(mean(own_dyn_control), mean(own_dyn_gap), ...
    '.k', 'MarkerSize', 15);
% plot(mean(mean(own_dyn_control(:, g1_dyn))), ...
%     mean(mean(own_dyn_gap(:, g1_dyn))) - ...
%     mean(mean(own_dyn_control(:, g1_dyn))), 'xb', 'MarkerSize', 15);
% plot(mean(mean(own_dyn_control(:, g2_dyn))), ...
%     mean(mean(own_dyn_gap(:, g2_dyn))) - ...
%     mean(mean(own_dyn_control(:, g2_dyn))), 'xb', 'MarkerSize', 15);
% plot(mean(mean(own_dyn_control(:, g3_dyn))), ...
%     mean(mean(own_dyn_gap(:, g3_dyn))) - ...
%     mean(mean(own_dyn_control(:, g3_dyn))), 'vb', 'MarkerSize', 12);

hold on; box on;
set(gca, 'XTick', 1:1:7, 'XTickLabel', 1:1:7);
xlabel('Basal dynamic');
ylabel('Discontinuity dynamic');
title('Sense of ownership', 'FontWeight', 'bold');

%%
%%%
% Panel E - Sense of agency
%%%
fig2 = figure(5); clf;
set(fig2, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);

subplot('Position', [0.13, 0.15, 0.77, 0.65]); hold on;
line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

p(1) = plot(edge, hist(agn_dyn_control(:), edge)/numel(agn_dyn_control), ...
    'color', c(c_a, :), 'LineWidth', 3); 
p(2) = plot(edge, hist(agn_dyn_gap(:), edge)/numel(agn_dyn_gap), ...
    'color', c(c_a - 5, :), 'LineWidth', 3); 
line([mean(agn_dyn_control(:)), mean(agn_dyn_control(:))], [-0.1 1.1], ...
    'color', c(c_a, :));
line([mean(agn_dyn_gap(:)), mean(agn_dyn_gap(:))], [-0.1 1.1], ...
    'color', c(c_a - 5, :)); 
hold off; box on 

xlim([0.9 7.15]); ylim([0 0.84]);
legend(p, {'Basal dynamic', 'Discontinuous dynamic'}, 'location', 'northwest', ...
    'FontSize', 8, 'FontWeight', 'bold');
ylabel('Probability density', 'FontSize', ...
    11, 'FontWeight', 'bold');
xlabel('Responses to questionnaires', 'FontSize', ...
    11, 'FontWeight', 'bold');
set(gca, 'YTick', 0.1:0.1:0.8, 'YTickLabel', ...
    {'0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8'}, ...
    'Fontsize', 9);

subplot('Position', [0.13, 0.8, 0.77, 0.1]); hold on;
line([0 4], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 
b(1) = bar(1, mean(agn_dyn_control(:)), 0.5); 
b(2) = bar(2, mean(agn_dyn_gap(:)), 0.5); 
errorbar([1, 2], [mean(agn_dyn_control(:)), mean(agn_dyn_gap(:))], [...
    std(agn_dyn_control(:))/sqrt(numel(agn_dyn_control)), ...
    std(agn_dyn_gap(:))/sqrt(numel(agn_dyn_gap))], '.k'); 
hold off; box on;

set(b(1), 'FaceColor', c(c_a, :));
set(b(2), 'FaceColor', c(c_a - 5, :));
view([90 90]);

xlim([0.5 2.5]); ylim([0.9 7.15]);
set(gca, 'XTick', [], 'XTickLabel', {'', ''}, ...
    'YTickLabel', {'', '', '', '', '', '', ''}, ... 
    'fontsize', 9);
title('Sense of agency', 'FontWeight', 'bold', 'FontSize', 13);

%%
%%%
% Panel F - GSR
%%%
subplot('Position', [0.55 0.05 0.37 0.25]); hold on;
line([50 50], [0.5 1.5], 'Color', [225/255 75/255 50/255], ...
    'LineStyle', :, 'LineWidth', 1); 
p(1) = plot(1:100, res_frame(2, :), ... % basal
    'linewidth', 3, 'color', c(5, :));
p(2) = plot(1:100, res_frame(4, :), ... % knife on real
    'linewidth', 3, 'color', c(18, :));
hold off; box on;

ylim([0.95 1.25]);
legend(p, {'Basal dynamic', 'Discontinuos dynamic'}, 'location', ...
    'northwest', 'FontSize', 8, 'fontweight', 'bold');
set(gca, 'XTick', 0:10:100, 'XTickLabel', -5:1:5, 'fontsize', 9);

xlabel('Time to threat', 'fontsize', 11, 'FontWeight', 'bold');
ylabel('Normalization', 'fontsize', 12, 'FontWeight', 'bold');
title('Reaction to threat', 'fontsize', 13, 'fontweight', 'bold');




% Annotatations
annotation('textbox', [0, 0.935, 0.05, 0.05], ...
    'String', 'A', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 15, 'FontWeight', 'bold');

annotation('textbox', [0.45, 0.935, 0.05, 0.05], ...
    'String', 'B', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 15, 'FontWeight', 'bold');

annotation('textbox', [0, 0.61, 0.05, 0.05], ...
    'String', 'C', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 15, 'FontWeight', 'bold');

annotation('textbox', [0.45, 0.61, 0.05, 0.05], ...
    'String', 'D', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 15, 'FontWeight', 'bold');

annotation('textbox', [0, 0.27, 0.05, 0.05], ...
    'String', 'E', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 15, 'FontWeight', 'bold');

annotation('textbox', [0.45, 0.27, 0.05, 0.05], ...
    'String', 'F', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 15, 'FontWeight', 'bold');

%%

%% Figure 6 - Effect of discontinuity
fig5 = figure(5); clf;
set(fig5, 'units', 'centimeters', 'position', [5 0.2 18.0 30.0]);

%%%
% PANEL A - Sense of ownership - static
%%%
fig = figure(6); clf;
set(fig, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);

subplot('Position', [0.13, 0.15, 0.77, 0.65]); hold on;
line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

p(1) = plot(edge, hist(own_stat_gap(:), edge)/numel(own_stat_gap), ...
    'color', c(c_o, :), 'LineWidth', 3); 
p(2) = plot(edge, hist(own_dyn_gap(:), edge)/numel(own_dyn_gap), ...
    'color', c(c_o - 5, :), 'LineWidth', 3); 
line([mean(own_stat_gap(:)), mean(own_stat_gap(:))], [-0.1 1.1], ...
    'color', c(c_o, :));
line([mean(own_dyn_gap(:)), mean(own_dyn_gap(:))], [-0.1 1.1], ...
    'color', c(c_o - 5, :)); 
hold off; box on 

xlim([0.9 7.15]); ylim([0 0.45]);
legend(p, {'Discontinuous static', 'Discontinuous dynamic'}, 'location', 'northwest', ...
    'FontSize', 8, 'FontWeight', 'bold');
ylabel('Probability density', 'FontSize', ...
    11, 'FontWeight', 'bold');
xlabel('Responses to questionnaires', 'FontSize', ...
    11, 'FontWeight', 'bold');
set(gca, 'YTick', 0.1:0.1:0.4, 'YTickLabel', ...
    {'0.1', '0.2', '0.3', '0.4'}, ...
    'Fontsize', 9);

subplot('Position', [0.13, 0.8, 0.77, 0.1]); hold on;
line([0 4], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 
b(1) = bar(1, mean(own_stat_gap(:)), 0.5); 
b(2) = bar(2, mean(own_dyn_gap(:)), 0.5); 
errorbar([1, 2], [mean(own_stat_gap(:)), mean(own_dyn_gap(:))], [...
    std(own_dyn_gap(:))/sqrt(numel(own_dyn_gap)), ...
    std(own_dyn_gap(:))/sqrt(numel(own_dyn_gap))], '.k'); 
hold off; box on;

set(b(1), 'FaceColor', c(c_o, :));
set(b(2), 'FaceColor', c(c_o - 5, :));
view([90 90]);

xlim([0.5 2.5]); ylim([0.9 7.15]);
set(gca, 'XTick', [], 'XTickLabel', {'', ''}, ...
    'YTickLabel', {'', '', '', '', '', '', ''}, ... 
    'fontsize', 9);
title('Sense of ownership', 'FontWeight', 'bold', 'FontSize', 13);

line([1 2], [6.5 6.5], 'Color', 'black');
text(1.5, 6.65, '*', 'FontWeight', 'bold', 'FontSize', 12); box on;

%%
%%%%
% PANEL B - Correlations
%%%%
fig = figure(6); clf;
set(fig, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);
subplot('Position', [0.13, 0.15, 0.77, 0.75]); hold on;
ylim([0.5 7.5]); xlim([0.5 7.5]);

line([0 8], [0 8], 'LineStyle', ':', 'color', [220/255 220/255 220/255]);
line([3 3], [0 3], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1); line([0 3], [3 3], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1);
line([5 5], [0 5], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1); line([0 5], [5 5], 'LineStyle', ':', 'color', [220/255 220/255 220/255], ...
    'LineWidth', 1);

plot(mean(own_stat_gap), mean(own_dyn_gap), ...
    '.k', 'MarkerSize', 15);
% plot(mean(mean(own_stat_nogap(:, g1_stat))), ...
%     mean(mean(own_stat_gap(:, g1_stat))) - ...
%     mean(mean(own_stat_nogap(:, g1_stat))), 'xb', 'MarkerSize', 15);
% plot(mean(mean(own_stat_nogap(:, g2_stat))), ...
%     mean(mean(own_stat_gap(:, g2_stat))) - ...
%     mean(mean(own_stat_nogap(:, g2_stat))), 'xb', 'MarkerSize', 15);
% plot(mean(mean(own_stat_nogap(:, g3_stat))), ...
%     mean(mean(own_stat_gap(:, g3_stat))) - ...
%     mean(mean(own_stat_nogap(:, g3_stat))), 'vb', 'MarkerSize', 12);

hold on; box on;

set(gca, 'XTick', 1:1:7, 'XTickLabel', 1:1:7);
xlabel('Discontinuity static');
ylabel('Discontinuity dynamic');
title('Sense of ownership', 'FontWeight', 'bold');
