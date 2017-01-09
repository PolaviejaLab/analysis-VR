% FIG_SELFREP_FHN generates all the figures from the paper.
addpath('formatting\');


%% Load data (from saved matrices)
load('..\..\data\mat_stat.mat');
load('..\..\data\mat_dyn.mat');
load('..\..\data\mn_stat.mat');
load('..\..\data\mn_dyn.mat');
load('..\..\data\pval_stat_bs.mat');
% load('..\..\data\pval_dyn_bs.mat');
% load('..\..\data\cv.mat');

load('..\..\data\arrays_ownstat.mat');
load('..\..\data\arrays_owndyn.mat');
load('..\..\data\arrays_agndyn.mat');


%% Set variables
n_elem_own = size(mat_stat_own(1, :), 2);
n_elem_agn = size(mat_dyn_agn(1, :), 2);
% n_elem_loc_s = size(mat_stat_loc(1, :), 2);
% n_elem_loc_d = size(mat_dyn_loc(1, :), 2);

c = parula;
c = c(1:2:64,:);

c_o = 6;
c_a = 20;
% c_l = 18;

edge = 1:7;


%% Formatting variables
sLine = 4;
sAxis = 16;


%% Figure 1, modulation ownership and agency
figure(1);
% set up


%% Figure5. Static block, ownership
fig_stat = figure(2); clf;

positionvector1 = [0.1, 0.075, 0.75, 0.65];
positionvector2 = [...
    positionvector1(1), ...
    positionvector1(2) + positionvector1(4), ...
    positionvector1(3), ...
    0.8 - positionvector1(4)];

% SUBPLOT2 - graph bar means
subplot('Position', positionvector2); hold on;
line([0 3], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 
b_1(1) = bar(1, mn_stat_own(1), 0.5); 
b_1(2) = bar(2, mn_stat_own(2), 0.5); 
errorbar([1, 2], [mean(mat_stat_own(1, :)), ...
    mean(mat_stat_own(2, :))], ...
    [std(mat_stat_own(1, :))/sqrt(n_elem_own), ...
    std(mat_stat_own(2, :))/sqrt(n_elem_own)], '.k'); 
hold off; box on;

set(b_1(1), 'FaceColor', c(c_o, :));
set(b_1(2), 'FaceColor', c(c_o - 5, :));
view([90 90]);

title('Sense of ownership', 'FontSize', 17, 'FontWeight', 'bold');

line([3 3], [0 8], 'color', 'k'); 
line([1 2], [6.5 6.5], 'Color', 'black');
text(1.5, 6.65, '*', 'FontWeight', 'bold', 'FontSize', 14); 

xlim([0.5 2.5]); ylim([0.9 7.15]);
set(gca, 'XTick', [], 'XTickLabel', {'', ''}, 'YTick', 1:1:7, 'Fontsize', sAxis);

% SUBPLOT1 - Distributions
subplot('Position', positionvector1); hold on;
line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 
p_1(1) = plot(edge, hist(mat_stat_own(1, :), edge)/n_elem_own, ...
    'color', c(c_o, :), 'LineWidth', sLine); 
p_1(2) = plot(edge, hist(mat_stat_own(2, :), edge)/n_elem_own, ...
    'color', c(c_o - 5, :), 'LineWidth', sLine); 
line([mn_stat_own(1), mn_stat_own(1)], [-0.1 1.1], ...
    'color', c(c_o, :));
line([mn_stat_own(2), mn_stat_own(2)], [-0.1 1.1], ...
    'color', c(c_o - 5, :));
hold off; box on;

ylim([0 0.5]); xlim([0.9 7.15]); 
ylabel('Probability density', 'FontSize', ...
    sAxis, 'FontWeight', 'bold');
xlabel('Responses to questionnaires', 'FontWeight', ...
    'bold', 'FontSize', 16); 
set(gca, 'YTick', 0.1:0.1:0.5, ...
    'YTickLabel', {'0.1', '0.2', '0.3', '0.4', ''}, ...
    'Fontsize', 13);
set(gca, 'XTick', 1:1:7, 'XTickLabel', 1:7, 'FontSize', sAxis - 2); 

legend(p_1, {'Control', 'Discontinuity'}, 'Location', 'Northeast', ...
    'Fontsize', 12, 'FontWeight', 'bold');

annotation('textbox', [0 0.93 1 0.1], ... % title of the figure
    'String', 'Self-reports for the static block', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 20, 'FontWeight', 'bold');

% tGap = text(0.53, 0.7, 'Gap', 'FontWeight', 'bold', 'FontSize', sAxis); 
% text(1, 0.7, '–', 'FontSize', 12); 
% text(2, 0.7, '+', 'FontSize', 12); 
% tNoise = text(0.53, 0.4, 'Noise', 'FontWeight', 'bold', 'FontSize', sAxis); 
% text(1, 0.4, '–', 'FontSize', 12); 
% text(2, 0.4, '–', 'FontSize', 12);
% set(tGap, 'rotation', 90);
% set(tNoise, 'rotation', 90);

set(fig_stat,'units','normalized', 'Position', [0.2 0.2 0.45 0.65]);


%% Figure 2, ownership and agency - dynamic - experimental
positionvector1 = [0.075, 0.09, 0.385, 0.61];
positionvector2 = [...
    positionvector1(1), ...
    positionvector1(2) + positionvector1(4), ...
    positionvector1(3), ...
    0.785 - positionvector1(4)];
positionvector3 = positionvector1 + [0.5, 0, 0, 0];
positionvector4 = positionvector2 + [0.5, 0, 0, 0];

exCond = [2, 4, 5];

fig_exDyn = figure(3); clf;
% SUBPLOT 1
subplot('Position', positionvector1); hold on;
line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

p_2(1) = plot(edge, hist(mat_dyn_own(exCond(1), :), edge)/n_elem_own, ...
    'color', c(c_o, :), 'LineWidth', 3); 
p_2(2) = plot(edge, hist(mat_dyn_own(exCond(2), :), edge)/n_elem_own, ...
    'color', c(c_o - 5, :), 'LineWidth', 3); 
p_2(3) = plot(edge, hist(mat_dyn_own(exCond(3), :), edge)/n_elem_own, ...
    'color', c(c_o + 5, :), 'LineWidth', 3); 

line([mn_dyn_own(exCond(1)), mn_dyn_own(exCond(1))], [-0.1 1.1], ...
    'color', c(c_o, :));
line([mn_dyn_own(exCond(2)), mn_dyn_own(exCond(2))], [-0.1 1.1], ...
    'color', c(c_o - 5, :)); 
line([mn_dyn_own(exCond(3)), mn_dyn_own(exCond(3))], [-0.1 1.1], ...
    'color', c(c_o + 5, :));     
hold off; box on 

legend(p_2, {'Control', 'Discontinuity', 'Movement noise'}, ...
    'location', 'northwest', ...
    'FontSize', 12, 'FontWeight', 'bold');

xlim([0.9 7.15]); ylim([0 0.5]);
ylabel('Probability density', 'FontSize', ...
    sAxis, 'FontWeight', 'bold');
xlabel('Responses to questionnaires', 'FontSize', ...
    sAxis, 'FontWeight', 'bold');
set(gca, 'YTick', 0.1:0.1:0.5, 'YTickLabel', ...
    {'0.1', '0.2', '0.3', '0.4', '0.5'}, ...
    'Fontsize', 13);

% SUBPLOT 2
subplot('Position', positionvector2); hold on;
line([0 4], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

b_2(1) = bar(1, mn_dyn_own(exCond(1)), 0.5); 
b_2(2) = bar(2,mn_dyn_own(exCond(2)), 0.5); 
b_2(3) = bar(3, mn_dyn_own(exCond(3)), 0.5); 
errorbar([1, 2, 3], [mn_dyn_own(exCond(1)), mn_dyn_own(exCond(2)), ...
    mn_dyn_own(exCond(3))], [...
    std(mat_dyn_own(exCond(1), :))/sqrt(n_elem_own), ...
    std(mat_dyn_own(exCond(2), :))/sqrt(n_elem_own), ...
    std(mat_dyn_own(exCond(3), :))/sqrt(n_elem_own)], '.k'); 
hold off; box on;

set(b_2(1), 'FaceColor', c(c_o, :));
set(b_2(2), 'FaceColor', c(c_o - 5, :));
set(b_2(3), 'FaceColor', c(c_o + 5, :));

view([90 90]);
xlim([0.5 3.5]); ylim([0.9 7.15]);
% ylabel('Responses to questionnaires', 'FontSize', ...
%     sAxis, 'FontWeight', 'bold');
set(gca, 'XTick', [], 'XTickLabel', {'', ''});
set(gca, 'YTickLabel', {'', '', '', '', '', '', ''});
% set(gca, 'YTick', 1:1:7, ...
%     'YTickLabel', 1:7, 'FontSize', sAxis - 2);
title('Sense of ownership', 'FontWeight', 'bold', 'FontSize', 17);

% tGap = text(4.55, 0.4, 'Discont.', 'FontWeight', 'bold', 'FontSize', sAxis - 1); 
% text(1, 0.4, '–', 'FontSize', 12); 
% text(2, 0.4, '+', 'FontSize', 12); 
% text(3, 0.4, '–', 'FontSize', 12); 
% tNoise = text(4.55, 0.1, 'Noise', 'FontWeight', 'bold', 'FontSize', sAxis - 1); 
% text(1, 0.1, '–', 'FontSize', 12); 
% text(2, 0.1, '–', 'FontSize', 12);
% text(3, 0.1, '+', 'FontSize', 12);
% set(tGap, 'rotation', 90);
% set(tNoise, 'rotation', 90);

line([1 3], [6.5 6.5], 'Color', 'black');
text(2, 6.65, '*', 'FontWeight', 'bold', 'FontSize', 14); box on;

% SUBPLOT 3
subplot('Position', positionvector3); hold on;
line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

p_3(1) = plot(edge, hist(mat_dyn_agn(exCond(1), :), edge)/n_elem_agn, ...
    'color', c(c_a, :), 'LineWidth', 3); 
p_3(2) = plot(edge, hist(mat_dyn_agn(exCond(2), :), edge)/n_elem_agn, ...
    'color', c(c_a - 5, :), 'LineWidth', sLine); 
p_3(3) = plot(edge, hist(mat_dyn_agn(exCond(3), :), edge)/n_elem_agn, ...
    'color', c(c_a + 5, :), 'LineWidth', sLine); 

line([mn_dyn_agn(exCond(1)), mn_dyn_agn(exCond(1))], [-0.1 1.1], ...
    'color', c(c_a, :));
line([mn_dyn_agn(exCond(2)), mn_dyn_agn(exCond(2))], [-0.1 1.1], ...
    'color', c(c_a - 5, :)); 
line([mn_dyn_agn(exCond(3)), mn_dyn_agn(exCond(3))], [-0.1 1.1], ...
    'color', c(c_a + 5, :)); 
hold off; box on;

legend(p_3, {'Control', 'Discontinuity', 'Movement noise'}, ...
    'location', 'northwest', ...
    'FontSize', 12, 'FontWeight', 'bold');

ylim([0 0.75]); xlim([0.9 7.15]); 
set(gca, 'YTick', 0.1:0.1:0.7, 'FontSize', sAxis - 2);
xlabel('Responses to questionnaires', 'FontSize', ...
    sAxis, 'FontWeight', 'bold');
ylabel('Probability density', 'FontSize', ...
    sAxis, 'FontWeight', 'bold');

% SUBPLOT 4
subplot('Position', positionvector4); hold on;
line([0 4], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

b_3(1) = bar(1, mn_dyn_agn(exCond(1)), 0.5); 
b_3(2) = bar(2, mn_dyn_agn(exCond(2)), 0.5); 
b_3(3) = bar(3, mn_dyn_agn(exCond(3)), 0.5); 
errorbar([1, 2, 3], [mn_dyn_agn(exCond(1)), mn_dyn_agn(exCond(2)), ...
    mn_dyn_agn(exCond(3))], [...
    std(mat_dyn_agn(exCond(1), :))/sqrt(n_elem_agn), ...
    std(mat_dyn_agn(exCond(2), :))/sqrt(n_elem_agn), ...
    std(mat_dyn_agn(exCond(3), :))/sqrt(n_elem_agn)], '.k'); 
hold off; box on;

set(b_3(1), 'FaceColor', c(c_a, :));
set(b_3(2), 'FaceColor', c(c_a - 5, :));
set(b_3(3), 'FaceColor', c(c_a + 5, :));

% legend(b, {'Agency'}, 'location', 'southeast', 'FontSize', 12, ...
%     'FontWeight', 'bold');

view([90 90]);
xlim([0.5 3.5]); ylim([0.9 7.15]);
% ylabel('Responses to questionnaires', 'FontSize', ...
%     sAxis, 'FontWeight', 'bold');
% set(gca, 'XTickLabel', {'', ''}, 'YTick', 1:1:7, ...
%     'YTickLabel', 1:7, 'FontSize', sAxis - 2);
set(gca, 'XTick', [], 'XTickLabel', {'', ''});
set(gca, 'YTickLabel', {'', '', '', '', '', '', ''});
% tGap = text(4.55, 0.7, 'Discont.', 'FontWeight', 'bold', 'FontSize', sAxis - 1); 
% text(1, 0.7, '–', 'FontSize', 12); 
% text(2, 0.7, '+', 'FontSize', 12); 
% text(3, 0.7, '–', 'FontSize', 12); 
% tNoise = text(4.55, 0.4, 'Noise', 'FontWeight', 'bold', 'FontSize', sAxis - 1); 
% text(1, 0.4, '–', 'FontSize', 12); 
% text(2, 0.4, '–', 'FontSize', 12);
% text(3, 0.4, '+', 'FontSize', 12);
% set(tGap, 'rotation', 90);
% set(tNoise, 'rotation', 90);
title('Sense of agency', 'FontWeight', 'bold', 'FontSize', 17);

line([1 3], [6.8 6.75], 'Color', 'black');
text(2, 6.95, '*', 'FontWeight', 'bold', 'FontSize', 14); box on;

% Texts
annotation('textbox', [0 positionvector1(4) + positionvector2(4) + 0.14  1 0.1], ...
    'String', 'Self-reports for the dynamic block (I)', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 20, 'FontWeight', 'bold');
annotation('textbox', [0.033 positionvector1(4) + positionvector2(4) 0.1 0.1], ...
    'String', 'A', ... 
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 20, 'FontWeight', 'bold');
annotation('textbox', [0.536 positionvector1(4) + positionvector2(4) 0.1 0.1], ...
    'String', 'B', ... 
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 20, 'FontWeight', 'bold'); %     


set(fig_exDyn, 'units','normalized', 'Position', [0.1 0.1 0.9 0.75]);


%% Figure 4, ownership and agency - dynamic - control
fig_conDyn = figure(4); clf;

exCond = [1, 2, 3];

% SUBPLOT 1
subplot('Position', positionvector1); hold on;
line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

p4(1) = plot(edge, hist(mat_dyn_own(exCond(2), :), edge)/n_elem_own, ...
    'color', c(c_o, :), 'LineWidth', sLine);
p4(2) = plot(edge, hist(mat_dyn_own(exCond(1), :), edge)/n_elem_own, ...
    'color', c(c_o - 5, :), 'LineWidth', 3); 
p4(3) = plot(edge, hist(mat_dyn_own(exCond(3), :), edge)/n_elem_own, ...
    'color', c(c_o + 5, :), 'LineWidth', sLine); 

line([mn_dyn_own(exCond(2)), mn_dyn_own(exCond(2))], [-0.1 1.1], ...
    'color', c(c_o - 5, :));
line([mn_dyn_own(exCond(1)), mn_dyn_own(exCond(1))], [-0.1 1.1], ...
    'color', c(c_o , :)); 
line([mn_dyn_own(exCond(3)), mn_dyn_own(exCond(3))], [-0.1 1.1], ...
    'color', c(c_o + 5, :)); 
hold off; box on;


ylim([0 0.5]); xlim([0.9 7.15]); 
xlabel('Responses to questionnaires', 'FontSize', ...
    17, 'FontWeight', 'bold');
ylabel('Probability density', 'FontSize', ...
    12, 'FontWeight', 'bold');
set(gca, 'XTick', [], 'YTick', 0.1:0.1:0.5, ...
    'YTickLabel', {'0.1', '0.2', '0.3', '0.4', '0.5'}, ...
    'XTick', 1:1:7, ...
    'XTickLabel', 1:7, 'FontSize', sAxis - 2);

legend(p4, {'Control', 'No Hand Offset', 'Threat on real hand'}, ...
        'location', 'northwest', ...
    'FontSize', 12, 'FontWeight', 'bold');

% SUBPLOT 2
subplot('Position', positionvector2); hold on;
line([0 4], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

b_4(1) = bar(1, mn_dyn_own(exCond(2)), 0.5); 
b_4(2) = bar(2, mn_dyn_own(exCond(1)), 0.5); 
b_4(3) = bar(3, mn_dyn_own(exCond(3)), 0.5); 
errorbar([1, 2, 3], [mn_dyn_own(exCond(2)), mn_dyn_own(exCond(1)), ...
    mn_dyn_own(exCond(3))], [...
    std(mat_dyn_own(exCond(2), :))/sqrt(n_elem_own), ...
    std(mat_dyn_own(exCond(1), :))/sqrt(n_elem_own), ...
    std(mat_dyn_own(exCond(3), :))/sqrt(n_elem_own)], '.k'); 

view([90 90])
xlim([0.5 3.5]); ylim([0.9 7.15]);

set(b_4(1), 'FaceColor', c(c_o, :));
set(b_4(2), 'FaceColor', c(c_o - 5, :));
set(b_4(3), 'FaceColor', c(c_o + 5, :));
edge = 1:7;

% line([4 4], [0 8], 'color', 'k');

hold off; box on;

set(gca, 'XTickLabel', {'', ''}, 'YTick', 1:1:7, 'YTickLabel', {''});
title('Sense of ownership', 'FontWeight', 'bold', 'FontSize', 17);


% SUBPLOT 3
subplot('Position', positionvector3); hold on;
line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

p5(2) = plot(edge, hist(mat_dyn_agn(exCond(2), :), edge)/n_elem_agn, ...
    'color', c(c_a, :), 'LineWidth', sLine); 
p5(1) = plot(edge, hist(mat_dyn_agn(exCond(1), :), edge)/n_elem_agn, ...
    'color', c(c_a - 5, :), 'LineWidth', sLine); 
p5(3) = plot(edge, hist(mat_dyn_agn(exCond(3), :), edge)/n_elem_agn, ...
    'color', c(c_a + 5, :), 'LineWidth', sLine); 

line([mn_dyn_agn(exCond(2)), mn_dyn_agn(exCond(2))], [-0.1 1.1], ...
    'color', c(c_a, :));
line([mn_dyn_agn(exCond(1)), mn_dyn_agn(exCond(1))], [-0.1 1.1], ...
    'color', c(c_a - 5, :)); 
line([mn_dyn_agn(exCond(3)), mn_dyn_agn(exCond(3))], [-0.1 1.1], ...
    'color', c(c_a + 5, :)); 
hold off; box on;


ylim([0 0.75]); xlim([0.9 7.15]); 
xlabel('questionnaire responses', 'FontSize', ...
    17, 'FontWeight', 'bold');
ylabel('probability density', 'FontSize', ...
    12, 'FontWeight', 'bold');
set(gca, 'XTick', [], 'YTick', 0.1:0.1:0.7, ...
    'YTickLabel', {'0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7'}, ...
        'XTick', 1:1:7, ...
    'XTickLabel', 1:7, 'FontSize', sAxis - 2);

legend(p5, {'Control', 'No Hand Offset', 'Threat on real hand'}, ...
        'location', 'northwest', ...
    'FontSize', 12, 'FontWeight', 'bold');

%SUBPLOT 4
subplot('Position', positionvector4); hold on;
line([0 4], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 

b5(1) = bar(1, mn_dyn_agn(exCond(2)), 0.5); 
b5(2) = bar(2, mn_dyn_agn(exCond(1)), 0.5); 
b5(3) = bar(3, mn_dyn_agn(exCond(3)), 0.5); 
errorbar([1, 2, 3], [...
    mn_dyn_agn(exCond(2)), ...
    mn_dyn_agn(exCond(1)), ...
    mn_dyn_agn(exCond(3))], [...
    std(mat_dyn_agn(exCond(2), :))/sqrt(n_elem_agn), ...
    std(mat_dyn_agn(exCond(1), :))/sqrt(n_elem_agn), ...
    std(mat_dyn_agn(exCond(3), :))/sqrt(n_elem_agn)], '.k'); 

line([0 4], [0 0]);
hold off;

set(b5(1), 'FaceColor', c(c_a, :));
set(b5(2), 'FaceColor', c(c_a - 5, :));
set(b5(3), 'FaceColor', c(c_a + 5, :));

view([90 90]);
xlim([0.5 3.5]); ylim([0.9 7.15]);
set(gca, 'XTickLabel', {'', ''}, 'YTick', 1:1:7, 'YTickLabel', {''});
title('Sense of agency', 'FontWeight', 'bold', 'FontSize', 17);




% Texts
annotation('textbox', [0 positionvector1(4) + positionvector2(4) + 0.14  1 0.1], ...
    'String', 'Self-reports for the dynamic block (II)', ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 20, 'FontWeight', 'bold');
annotation('textbox', [0.033 positionvector1(4) + positionvector2(4) 0.1 0.1], ...
    'String', 'A', ... 
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 20, 'FontWeight', 'bold');
annotation('textbox', [0.536 positionvector1(4) + positionvector2(4) 0.1 0.1], ...
    'String', 'B', ... 
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 20, 'FontWeight', 'bold'); %     

set(fig_conDyn,'units','normalized', 'Position', [0.1 0.1 0.9 0.75]);





%% Figure. Correlations of static gap no gap
% define groups
group1s = find(mean(own_stat_nogap) <= 3);
group2s = find(mean(own_stat_nogap) > 3 & mean(own_stat_nogap) < 5);
group3s = find(mean(own_stat_nogap) >= 5);

mn_group1s = ...
    [mean(own_stat_nogap(:, group1s)); mean(own_stat_gap(:, group1s))];
mn_group2s = ...
    [mean(own_stat_nogap(:, group2s)); mean(own_stat_gap(:, group2s))];
mn_group3s = ...
    [mean(own_stat_nogap(:, group3s)); mean(own_stat_gap(:, group3s))];

p3 = polyfit(mean(own_stat_nogap), mean(own_stat_gap), 1);
x3 = mean(own_stat_nogap); y3 = polyval(p3, x3);

p31 = polyfit(mn_group1s(1, :), mn_group1s(2, :), 1);
p32 = polyfit(mn_group2s(1, :), mn_group2s(2, :), 1);
p33 = polyfit(mn_group3s(1, :), mn_group3s(2, :), 1);

y31 = polyval(p31, mn_group1s(1, :));
y32 = polyval(p32, mn_group2s(1, :));
y33 = polyval(p33, mn_group3s(1, :));

[R_stat, p_stat] = corrcoef(mean(own_stat_nogap), mean(own_stat_gap));

fig_corrStat = figure(6); clf; hold on;
plot(mean(own_stat_nogap), mean(own_stat_gap), '.b', 'MarkerSize', 20);
line([0 8],[0 8], 'Color', 'k', 'LineStyle', ':');
% plot(x3, y3, 'Color', 'b');
plot(mn_group1s(1, :), y31, 'k');
plot(mn_group2s(1, :), y32, 'k');
plot(mn_group3s(1, :), y33, 'k');
plot(mean(mn_group1s(1, :)), mean(mn_group1s(2, :)),'.k', 'MarkerSize', 40);
plot(mean(mn_group2s(1, :)), mean(mn_group2s(2, :)),'.k', 'MarkerSize', 40);
plot(mean(mn_group3s(1, :)), mean(mn_group3s(2, :)),'.k', 'MarkerSize', 40);
hold off; box on;

formatcorrelations(...
    [0.5 7.5], [0.5 7.5], 'responses to questionnaire control', ...
    'reponses to questionnaire gap', 17); 

set(fig_corrStat, 'units','normalized', 'Position', [0.2 0.2 0.45 0.65]);

%% Figure. Correlations dynamic (1) own gap no gap (2) noise no noise (3) agn gap no gap (4) agn noise no noise
% define groups and means

group1d = find(mean(own_dyn_control) <= 3);
group2d = find(mean(own_dyn_control) > 3 & mean(own_stat_nogap) < 5);
group3d = find(mean(own_dyn_control) >= 5);

mn_group1d = ...
    [mean(own_dyn_control(:, group1d)); mean(own_dyn_gap(:, group1d))];
mn_group2d = ...
    [mean(own_dyn_control(:, group2d)); mean(own_dyn_gap(:, group2d))];
mn_group3d = ...
    [mean(own_dyn_control(:, group3d)); mean(own_dyn_gap(:, group3d))];

p4 = polyfit(mean(own_dyn_control), mean(own_dyn_gap), 1);
p5 = polyfit(mean(own_dyn_control), mean(own_dyn_noise), 1);
p6 = polyfit(mean(own_dyn_control), mean(own_dyn_nooffset), 1);
p7 = polyfit(mean(own_dyn_control), mean(own_dyn_kor), 1);

p8 = polyfit(mean(agn_dyn_control), mean(agn_dyn_gap), 1);
p9 = polyfit(mean(agn_dyn_control), mean(agn_dyn_noise), 1);
p10 = polyfit(mean(agn_dyn_control), mean(agn_dyn_nooffset), 1);
p11 = polyfit(mean(agn_dyn_control), mean(agn_dyn_kor), 1);

x4 = mean(own_dyn_control); y4 = polyval(p4, x4);
x5 = mean(own_dyn_control); y5 = polyval(p5, x5);
x6 = mean(own_dyn_control); y6 = polyval(p6, x6);
x7 = mean(own_dyn_control); y7 = polyval(p7, x7);

x8 = mean(agn_dyn_control); y8 = polyval(p8, x8);
x9 = mean(agn_dyn_control); y9 = polyval(p9, x9);
x10 = mean(agn_dyn_control); y10 = polyval(p10, x10);
x11 = mean(agn_dyn_control); y11 = polyval(p11, x11);

[R_owDyn1, p_ownDyn1] = corrcoef(mean(agn_dyn_control), mean(own_dyn_gap));
[R_owDyn2, p_ownDyn2] = corrcoef(mean(agn_dyn_control), mean(own_dyn_noise));
[R_owDyn3, p_ownDyn3] = corrcoef(mean(agn_dyn_control), mean(own_dyn_nooffset));
[R_owDyn4, p_ownDyn4] = corrcoef(mean(agn_dyn_control), mean(own_dyn_kor));
[R_agDyn1, p_agnDyn1] = corrcoef(mean(agn_dyn_control), mean(agn_dyn_gap));
[R_agDyn2, p_agnDyn2] = corrcoef(mean(agn_dyn_control), mean(agn_dyn_noise));
[R_agDyn3, p_agnDyn3] = corrcoef(mean(agn_dyn_control), mean(agn_dyn_nooffset));
[R_agDyn4, p_agnDyn4] = corrcoef(mean(agn_dyn_control), mean(agn_dyn_kor));

fig_corrDyn = figure(7); clf;

subplot(2, 2, 1);  hold on; 
plot(mean(own_dyn_control)+(-0.011:0.001:0.01), mean(own_dyn_gap), 'ob');
plot(mean(own_dyn_control), mean(own_dyn_noise), 'or');
line([0 8],[0 8], 'Color', 'k', 'LineStyle', ':');
legend({'control vs gap', 'control vs noise'}, 'Location', 'Northwest');
plot(x4, y4, 'Color', 'b');
plot(x5, y5, 'Color', 'r');
hold off; box on;
formatcorrelations(...
    [0.5 7.5], [0.5 7.5], 'self-report responses', ...
    'self-report responses', 13);
title('correlations ownership experimental', 'FontWeight', 'bold', ...
    'fontsize', 15);

subplot(2, 2, 2); hold on;
plot(mean(own_dyn_control), mean(own_dyn_nooffset), 'ob');
plot(mean(own_dyn_control), mean(own_dyn_kor), 'or');
line([0 8],[0 8], 'Color', 'k', 'LineStyle', ':');
plot(x6, y6, 'Color', 'b');
plot(x7, y7, 'Color', 'r');
legend({'control vs no hand offset', 'control vs knife on real'}, 'Location', 'Northwest');
formatcorrelations(...
    [0.5 7.5], [0.5 7.5], 'self-report responses', ...
    'self-report responses', 13);
title('correlations ownership control', 'FontWeight', 'bold', ...
    'fontsize', 15);
hold off; box on;

subplot(2, 2, 3); hold on;
plot(mean(agn_dyn_control)+(-0.33:0.03:0.3), mean(agn_dyn_gap)+(-0.33:0.03:0.3), 'ob');
plot(mean(agn_dyn_control)+(-0.33:0.03:0.3), mean(agn_dyn_noise)+(-0.33:0.03:0.3), 'or');
line([0 8],[0 8], 'Color', 'k', 'LineStyle', ':');
plot(x8, y8, 'Color', 'b');
plot(x9, y9, 'Color', 'r');
legend({'control vs gap', 'control vs noise'}, 'Location', 'Northwest');
formatcorrelations(...
    [3.5 7.5], [3.5 7.5], 'self-report responses', ...
    'self-report responses', 13);
title('correlations agency experimental', 'FontWeight', 'bold', ...
    'fontsize', 15);
hold off; box on;

subplot(2, 2, 4); hold on;
plot(mean(agn_dyn_control)+(-0.33:0.03:0.3), mean(agn_dyn_nooffset)+(-0.33:0.03:0.3), 'ob');
plot(mean(agn_dyn_control)+(-0.33:0.03:0.3), mean(agn_dyn_kor)+(-0.33:0.03:0.3), 'or');
line([0 8],[0 8], 'Color', 'k', 'LineStyle', ':');
plot(x10, y10, 'Color', 'b');
plot(x11, y11, 'Color', 'r');
legend({'control vs no hand offset', 'control vs knife on real'}, 'Location', 'Northwest');
formatcorrelations(...
    [3.5 7.5], [3.5 7.5], 'self-report responses', ...
    'self-report responses', 13);
title('correlations agency control', 'FontWeight', 'bold', ...
    'fontsize', 15);
hold off; box on;

set(fig_corrDyn, 'units','normalized', 'Position', [0.2 0.02 0.6 0.85]);


%% Figure. Correlations of dyn stat
mn_group1sd = ...
    [mean(own_stat_nogap(:, group1s)); mean(own_dyn_control(:, group1s)); ...
    mean(own_dyn_gap(:, group1s))];
mn_group2sd = ...
    [mean(own_stat_nogap(:, group2s)); mean(own_dyn_control(:, group2s)); ...
    mean(own_dyn_gap(:, group2s))];
mn_group3sd = ...
    [mean(own_stat_nogap(:, group3s)); mean(own_dyn_control(:, group3s)); ...
    mean(own_dyn_gap(:, group3s));];

p1 = polyfit(mean(own_stat_nogap), mean(own_dyn_control), 1);
p2 = polyfit(mean(own_stat_gap), mean(own_dyn_gap), 1);

x1 = mean(own_stat_nogap); y1 = polyval(p1, x1);
x2 = mean(own_stat_gap); y2 = polyval(p2, x2);

p11 = polyfit(mn_group1sd(1, :), mn_group1sd(2, :), 1);
p12 = polyfit(mn_group2sd(1, :), mn_group2sd(2, :), 1);
p13 = polyfit(mn_group3sd(1, :), mn_group3sd(2, :), 1);

y11 = polyval(p11, mn_group1sd(1, :));
y12 = polyval(p12, mn_group2sd(1, :));
y13 = polyval(p13, mn_group3sd(1, :));


p111 = polyfit(mn_group1sd(1, :), mn_group1sd(3, :), 1);
p112 = polyfit(mn_group2sd(1, :), mn_group2sd(3, :), 1);
p113 = polyfit(mn_group3sd(1, :), mn_group3sd(3, :), 1);

y111 = polyval(p111, mn_group1sd(1, :));
y112 = polyval(p112, mn_group2sd(1, :));
y113 = polyval(p113, mn_group3sd(1, :));



[R_nogap, p_nogap] = corrcoef(mean(own_stat_nogap), mean(own_dyn_control));
[R_gap, p_gap] = corrcoef(mean(own_stat_gap), mean(own_dyn_gap));

% Figure. Correlations between the static control and the dynamic control
% conditions. 

fig_corrgapnogap = figure(5); clf; hold on;
plot(mean(own_stat_nogap), mean(own_dyn_control), '.b', 'MarkerSize', 20); 
line([0 8],[0 8], 'Color', 'k', 'LineStyle', ':');
% plot(x1, y1, 'Color', 'b');

plot(mn_group1sd(1, :), y11, 'b');
plot(mn_group2sd(1, :), y12, 'b');
plot(mn_group3sd(1, :), y13, 'b');
plot(mean(mn_group1sd(1, :)), mean(mn_group1sd(2, :)),'.b', 'MarkerSize', 40);
plot(mean(mn_group2sd(1, :)), mean(mn_group2sd(2, :)),'.b', 'MarkerSize', 40);
plot(mean(mn_group3sd(1, :)), mean(mn_group3sd(2, :)),'.b', 'MarkerSize', 40);
hold off; box on;

formatcorrelations(...
    [0.5 7.5], [0.5 7.5], 'reported answers static', ...
    'reported answers dynamic', 17); 
title('Correlations static control, dynamic control', ...
    'FontSize', 17, 'FontWeight', 'bold');

set(fig_corrgapnogap, 'units','normalized', 'Position', [0.2 0.2 0.45 0.65]);

% Figure. Correlations between the static control and the dynamic gap
% conditions. 
figsd = figure(11); clf; hold on;
plot(mean(own_stat_nogap), mean(own_dyn_gap), '.b', 'MarkerSize', 20);

line([0 8],[0 8], 'Color', 'k', 'LineStyle', ':');
plot(mn_group1sd(1, :), y111);
plot(mn_group2sd(1, :), y112);
plot(mn_group3sd(1, :), y113);
plot(mean(mn_group1sd(1, :)), mean(mn_group1sd(3, :)),'.b', 'MarkerSize', 40);
plot(mean(mn_group2sd(1, :)), mean(mn_group2sd(3, :)),'.b', 'MarkerSize', 40);
plot(mean(mn_group3sd(1, :)), mean(mn_group3sd(3, :)),'.b', 'MarkerSize', 40);
hold off; box on;

formatcorrelations(...
    [0.5 7.5], [0.5 7.5], 'reported answers static no gap', ...
    'reported answers dynamic gap', 17); 
title('Correlations static control, dynamic gap', ...
    'FontSize', 17, 'FontWeight', 'bold');

set(figsd, 'units','normalized', 'Position', [0.2 0.2 0.45 0.65]);

% Figure. Correlation dynamic control, with dynamic gap conditions. Using
% the groups for static control. 

group1d = find(mean(own_dyn_control) <= 3);
group2d = find(mean(own_dyn_control) > 3 & mean(own_dyn_control) < 5);
group3d = find(mean(own_dyn_control) >= 5);

fig_dynGC = figure(12); clf; hold on; 

mn_group1d = ...
    [mean(own_dyn_control(:, group1s)); mean(own_dyn_gap(:, group1s))];
mn_group2d = ...
    [mean(own_dyn_control(:, group2s)); mean(own_dyn_gap(:, group2s))];
mn_group3d = ...
    [mean(own_dyn_control(:, group3s)); mean(own_dyn_gap(:, group3s))];


p001 = polyfit(mn_group1d(1, :), mn_group1d(2, :), 1);
p002 = polyfit(mn_group2d(1, :), mn_group2d(2, :), 1);
p003 = polyfit(mn_group3d(1, :), mn_group3d(2, :), 1);

y001 = polyval(p001, mn_group1d(1, :));
y002 = polyval(p002, mn_group2d(1, :));
y003 = polyval(p003, mn_group3d(1, :));

plot(mean(own_dyn_control), mean(own_dyn_gap), '.b', 'MarkerSize', 20);
line([0 8],[0 8], 'Color', 'k', 'LineStyle', ':');
plot(mn_group1d(1, :), y001);
plot(mn_group2d(1, :), y002);
plot(mn_group3d(1, :), y003);
plot(mean(mn_group1d(1, :)), mean(mn_group1d(2, :)),'.b', 'MarkerSize', 40);
plot(mean(mn_group2d(1, :)), mean(mn_group2d(2, :)),'.b', 'MarkerSize', 40);
plot(mean(mn_group3d(1, :)), mean(mn_group3d(2, :)),'.b', 'MarkerSize', 40);
hold off; box on;

formatcorrelations(...
    [0.5 7.5], [0.5 7.5], 'reported answers dynamic no gap', ...
    'reported answers dynamic gap', 17); 
title('Correlations dynamic control, dynamic gap', ...
    'FontSize', 17, 'FontWeight', 'bold');

set(fig_dynGC, 'units','normalized', 'Position', [0.2 0.2 0.45 0.65]);

%% Correlaciones sobre la respuesta. 
fig20 = figure(20); clf; 

subplot(1, 3, 1);hold on;
plot(mean(own_stat_nogap), mean(own_stat_gap) - mean(own_stat_nogap),...
    '.k', 'MarkerSize', 20);
ylim([-5 5]);
xlim([0.5 7.5]);

line([0 8], [0 0], 'LineStyle', ':');
line([3 3], [-5 5], 'LineStyle', ':');
line([5 5], [-5 5], 'LineStyle', ':');
plot(mean(mn_group1s(1, :)), ...
    mean(mn_group1s(2, :)) - mean(mn_group1s(1, :)), 'xb', ...
    'MarkerSize', 20);
plot(mean(mn_group2s(1, :)), mean(mn_group2s(2, :)) - mean(mn_group2s(1, :)), ...
    'xb', 'MarkerSize', 20);
plot(mean(mn_group3s(1, :)), mean(mn_group3s(2, :)) - mean(mn_group3s(1, :)), ...
    'xb', 'MarkerSize', 20);
hold off; box on;

xlabel('Basal static', 'FontWeight', 'bold', 'FontSize', 16);
ylabel('(Discont stat - basal static)', 'FontWeight', 'bold', 'FontSize', 16);

subplot(1, 3, 2); hold on;
plot(mean(own_stat_nogap), mean(own_dyn_control) - mean(own_stat_nogap),...
    '.k', 'MarkerSize', 20);
ylim([-5 5]);
xlim([0.5 7.5]);

line([0 8], [0 0], 'LineStyle', ':');
line([3 3], [-5 5], 'LineStyle', ':');
line([5 5], [-5 5], 'LineStyle', ':');
plot(mean(mn_group1s(1, :)), ...
    mean(mn_group1sd(2, :)) - mean(mn_group1s(1, :)), 'xb', ...
    'MarkerSize', 20);
plot(mean(mn_group2s(1, :)), ...
    mean(mn_group2sd(2, :)) - mean(mn_group2s(1, :)), ...
    'xb', 'MarkerSize', 20);
plot(mean(mn_group3s(1, :)), ...
    mean(mn_group3sd(2, :)) - mean(mn_group3s(1, :)), ...
    'xb', 'MarkerSize', 20);
hold off; box on;

xlabel('Basal static', 'FontWeight', 'bold', 'FontSize', 16);
ylabel('(Basal dynamic - basal static)', 'FontWeight', 'bold', 'FontSize', 16);

subplot(1, 3, 3); hold on;
plot(mean(own_stat_nogap), mean(own_dyn_gap) - mean(own_dyn_control),...
    '.k', 'MarkerSize', 20);
ylim([-5 5]);
xlim([0.5 7.5]);

line([0 8], [0 0], 'LineStyle', ':');
line([3 3], [-5 5], 'LineStyle', ':');
line([5 5], [-5 5], 'LineStyle', ':');
plot(mean(mn_group1s(1, :)), ...
    mean(mn_group1sd(3, :)) - mean(mn_group1sd(2, :)), 'xb', ...
    'MarkerSize', 20);
plot(mean(mn_group2s(1, :)), ...
    mean(mn_group2sd(3, :)) - mean(mn_group2sd(2, :)), ...
    'xb', 'MarkerSize', 20);
plot(mean(mn_group3s(1, :)), ...
    mean(mn_group3sd(3, :)) - mean(mn_group3sd(2, :)), ...
    'xb', 'MarkerSize', 20);
hold off; box on;

xlabel('Basal static', 'FontWeight', 'bold', 'FontSize', 16);
ylabel('(Discont dynamic - basal dynamic)', 'FontWeight', 'bold', 'FontSize', 16);

set(fig20, 'units','normalized', 'Position', [0.05 0.05 0.9 0.475]);

%% 
fig21 = figure(21); clf;

subplot(1, 2, 1); hold on;
plot(mean(own_stat_nogap), mean(own_dyn_noise) - mean(own_dyn_control), ...
    '.k', 'MarkerSize', 20);
plot(mean(mean(own_stat_nogap(:, group1s))), ...
    mean(mean(own_dyn_noise(:, group1s))) - ...
    mean(mean(own_dyn_control(:, group1s))), 'xb', 'MarkerSize', 20);
plot(mean(mean(own_stat_nogap(:, group2s))), ...
    mean(mean(own_dyn_noise(:, group2s))) - ...
    mean(mean(own_dyn_control(:, group2s))), 'xb', 'MarkerSize', 20);
plot(mean(mean(own_stat_nogap(:, group3s))), ...
    mean(mean(own_dyn_noise(:, group3s))) - ...
    mean(mean(own_dyn_control(:, group3s))), 'xb', 'MarkerSize', 20);
hold off;


ylim([-5 5]);
xlim([0.5 7.5]);

line([0 8], [0 0], 'LineStyle', ':');
line([3 3], [-7 7], 'LineStyle', ':');
line([5 5], [-7 7], 'LineStyle', ':');

xlabel('Basal static', 'FontWeight', 'bold', 'FontSize', 16);
ylabel('(Noise - Basal dynamic)', 'FontWeight', 'bold', 'FontSize', 16);


subplot(1, 2, 2); hold on;

plot(mean(own_dyn_control), mean(own_dyn_noise) - mean(own_dyn_control), ...
    '.k', 'MarkerSize', 20);
plot(mean(mean(own_dyn_control(:, group1d))), ...
    mean(mean(own_dyn_noise(:, group1d))) - ...
    mean(mean(own_dyn_control(:, group1d))), 'xb', 'MarkerSize', 20);
plot(mean(mean(own_dyn_control(:, group2d))), ...
    mean(mean(own_dyn_noise(:, group2d))) - ...
    mean(mean(own_dyn_control(:, group2d))), 'xb', 'MarkerSize', 20);
plot(mean(mean(own_dyn_control(:, group3d))), ...
    mean(mean(own_dyn_noise(:, group3d))) - ...
    mean(mean(own_dyn_control(:, group3d))), 'xb', 'MarkerSize', 20);
hold off;


ylim([-5 5]);
xlim([0.5 7.5]);

line([0 8], [0 0], 'LineStyle', ':');
line([3 3], [-7 7], 'LineStyle', ':');
line([5 5], [-7 7], 'LineStyle', ':');

xlabel('Basal dynamic', 'FontWeight', 'bold', 'FontSize', 16);
ylabel('(Noise dynamic - Basal dynamic)', 'FontWeight', 'bold', 'FontSize', 16);

set(fig21, 'units','normalized', 'Position', [0.05 0.05 0.7 0.475]);


%% 
fig22 = figure(22); clf;

subplot(1, 2, 1); hold on;
plot(mean(own_stat_nogap), mean(agn_dyn_control), '.k', 'MarkerSize', 20);
xlim([0.5 7.5]);
ylim([0.5 7.5]); 
xlabel('own\_stat\_control');
ylabel('agn\_dyn\_control');
hold off;

subplot(1, 2, 2);hold on;
plot(mean(own_dyn_control), mean(agn_dyn_control), '.k', 'MarkerSize', 20);
xlabel('own\_dyn\_control');
ylabel('agn\_dyn\_control');
xlim([0.5 7.5]);
ylim([0.5 7.5]);
hold off;

%% Agency
fig23 = figure(23); clf;

plot(mean(agn_dyn_control), mean(agn_dyn_noise) - mean(agn_dyn_control), ...
    '.k', 'MarkerSize', 20);
xlim([3.5 7.5]);
ylim([-5 5]);

xlabel('dynamic\_control');
ylabel('dynamic\_noise - dynamic\_control');


%%
fig24 = figure(23); clf;

plot(mean(agn_dyn_control), mean(agn_dyn_gap) - mean(agn_dyn_control), ...
    '.k', 'MarkerSize', 20);
xlim([3.5 7.5]);
ylim([-5 5]);

xlabel('dynamic\_control');
ylabel('dynamic\_gap - dynamic\_control');

