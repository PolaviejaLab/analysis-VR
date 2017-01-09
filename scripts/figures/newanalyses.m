%% Figure 2 - Basal dynamic vs basal static

% Panel A - histogram and distribution
fig2 = figure(2); clf;
set(fig2, 'units', 'centimeters', 'position', [5 5 18.0 9.0]);

subplot('Position', [0.1, 0.8, 0.37, 0.1]); hold on;
line([0 3], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 
b(1) = bar(1, mean(own_stat_gap(:)), 0.5); 
b(2) = bar(2, mean(own_dyn_gap(:)), 0.5); 

errorbar([1, 2], [mean(own_stat_gap(:)), ...
    mean(own_dyn_gap(:))], ...
    [std(own_stat_gap(:))/sqrt(numel(own_stat_gap)), ...
    std(own_dyn_gap(:))/sqrt(numel(own_dyn_gap))], '.k'); 
hold off; box on; view([90 90]);

set(b(1), 'FaceColor', c(c_o, :)); set(b(2), 'FaceColor', c(c_o - 5, :));
line([3 3], [0 8], 'color', 'k'); 
% line([1 2], [6.5 6.5], 'Color', 'black'); text(1.5, 6.65, '*', ...
%     'FontWeight', 'bold', 'FontSize', 14); 
xlim([0.5 2.5]); ylim([0.9 7.15]);
set(gca, 'XTick', [], 'XTickLabel', {'', ''}, 'YTick', 1:1:7, 'Fontsize', 9);
title('Sense of ownership', 'FontWeight', 'bold', 'fontsize', 13);

subplot('Position', [0.1, 0.15, 0.37, 0.65]); hold on;
line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':'); 
p_1(1) = plot(edge, hist(own_stat_gap(:), edge)/numel(own_stat_gap), ...
    'color', c(c_o, :), 'LineWidth', 3); 
p_1(2) = plot(edge, hist(own_dyn_gap(:), edge)/numel(own_dyn_gap), ...
    'color', c(c_o - 5, :), 'LineWidth', 3); 
line([mean(own_stat_gap(:)), mean(own_stat_gap(:))], [-0.1 1.1], ...
    'color', c(c_o, :));
line([mean(own_dyn_gap(:)), mean(own_dyn_gap(:))], [-0.1 1.1], ...
    'color', c(c_o - 5, :));
hold off; box on;

ylim([0 0.5]); xlim([0.9 7.15]); 
ylabel('Probability density', 'FontSize', ...
    12, 'FontWeight', 'bold');
xlabel('Responses to questionnaires', 'FontWeight', ...
    'bold', 'FontSize', 12); 
set(gca, 'YTick', 0.1:0.1:0.5, ...
    'YTickLabel', {'0.1', '0.2', '0.3', '0.4', ''}, ...
    'Fontsize', 9);
set(gca, 'XTick', 1:1:7, 'XTickLabel', 1:7, 'FontSize', 9); 

legend(p_1, {'Discontinuous static', 'Discontinuous dynamic'}, 'Location', 'Northwest', ...
    'Fontsize', 8, 'FontWeight', 'bold');


% Panel B - Scatter plot with the correlations. 
subplot('Position', [0.6, 0.15, 0.37, 0.75]); hold on;
plot(mean(own_stat_gap), mean(own_dyn_gap) - mean(own_stat_gap),...
    '.k', 'MarkerSize', 15);
ylim([-5 5]);
xlim([0.5 7.5]);

line([0 8], [0 0], 'LineStyle', ':');
line([3 3], [-5 5], 'LineStyle', ':');
line([5 5], [-5 5], 'LineStyle', ':');

g1_stat = find(mean(own_stat_nogap) <= 3);
g2_stat = find(mean(own_stat_nogap) > 3 & mean(own_stat_nogap) < 5);
g3_stat = find(mean(own_stat_nogap) >= 5);

plot(mean(mean(own_stat_nogap(:, g1_stat))), ...
    mean(mean(own_dyn_gap(:, g1_stat))) - ...
    mean(mean(own_stat_gap(:, g1_stat))), 'xb', ...
    'MarkerSize', 13);
plot(mean(mean(own_stat_nogap(:, g2_stat))), ...
    mean(mean(own_dyn_gap(:, g2_stat))) - ...
    mean(mean(own_stat_gap(:, g2_stat))), 'xb', ...
    'MarkerSize', 13);
plot(mean(mean(own_stat_nogap(:, g3_stat))), ...
    mean(mean(own_dyn_gap(:, g3_stat))) - ...
    mean(mean(own_stat_gap(:, g3_stat))), 'xb', ...
    'MarkerSize', 13);
hold off; box on;
set(gca, 'XTick', 1:1:7, 'XTickLabel', 1:7, 'FontSize', 9); 

xlabel('Basal static', 'FontWeight', 'bold', 'FontSize', 12);
ylabel('(Discont dynamic - Discont static)', 'FontWeight', 'bold', 'FontSize', 12);
title('Sense of ownership', 'FontWeight', 'bold', 'fontsize', 13);

