%% Data
nomov_nogap = own_stat_nogap;
nomov_gap = own_stat_gap;

mov_nogap = own_dyn_control;
mov_gap = own_dyn_gap;

c = parula;
c = c(1:2:64,:);

c_o = 6;
edge = 1:7;

% % Movement effect
% vecA = [nomov_nogap, nomov_gap];
% vecB = [mov_nogap, mov_gap];

% Gap effect
vecA = [nomov_nogap, mov_nogap];
vecB = [nomov_gap, mov_gap];


fig2 = figure(2); clf;
set(fig2, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);

subplot('Position', [0.13, 0.8, 0.77, 0.1]); hold on;
line([0 3], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':', ...
    'LineWidth', 1.5); 
b(1) = bar(1, mean(vecA(:)), 0.5); 
b(2) = bar(2, mean(vecB(:)), 0.5); 

errorbar([1, 2], [mean(vecA(:)), ...
    mean(vecB(:))], ...
    [std(vecA(:))/sqrt(numel(vecA)), ...
    std(vecB(:))/sqrt(numel(vecB))], '.k'); 
hold off; box on; view([90 90]);

line([1 2], [5.5 5.5], 'Color', 'black');
text(1.5, 5.65, '*', 'FontWeight', 'bold', 'FontSize', 12);

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
p_1(1) = plot(edge, hist(vecA(:), edge)/numel(vecA), ...
    'color', c(c_o, :), 'LineWidth', 3); 
p_1(2) = plot(edge, hist(vecB(:), edge)/numel(vecB), ...
    'color', c(c_o - 5, :), 'LineWidth', 3); 
line([mean(vecA(:)), mean(vecA(:))], [-0.1 1.1], ...
    'color', c(c_o, :));
line([mean(vecB(:)), mean(vecB(:))], [-0.1 1.1], ...
    'color', c(c_o - 5, :));
hold off; box on;

ylim([0 0.5]); xlim([0.9 7.15]); 
ylabel('Probability density');
xlabel('Responses to questionnaires'); 
set(gca, 'YTick', 0.1:0.1:0.5, ...
    'YTickLabel', {'0.1', '0.2', '0.3', '0.4', ''}, ...
    'Fontsize', 8);
set(gca, 'XTick', 1:1:7, 'XTickLabel', 1:7, 'FontSize', 8); 

legend(p_1, {'no-gap', 'gap'}, 'Location', 'Northwest', ...
    'Fontsize', 8, 'FontWeight', 'bold');

addpath('..\statistics\');
pvl = stat_bootstrapping(10000, vecA(:)', vecB(:)')
[h, p] = kstest2 (vecA(:), vecB(:))