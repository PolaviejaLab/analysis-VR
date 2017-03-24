function [] = fig_mean_distributions(figNum, vect1, vect2, color, legend)

c = parula;
c = c(1:2:64,:);

edge = 1:7;

fig = figure(figNum); clf;
set(fig, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);

subplot('Position', [0.13, 0.8, 0.77, 0.1]); hold on;
line([0 3], [4 4], 'color', [220/255 220/255 220/255], 'LineStyle', ':', ...
    'LineWidth', 1.5); 
b(1) = bar(1, mean(vect1), 0.5); 
b(2) = bar(2, mean(vect2), 0.5); 

errorbar([1, 2], [mean(vect1), mean(vect2)], [...
    std(vect1)/sqrt(numel(vect1)), ...
    std(vect2)/sqrt(numel(vect2))], '.k'); 
hold off; box on; view([90 90]);

set(b(1), 'FaceColor', c(color, :)); set(b(2), 'FaceColor', c(color - 5, :));
line([3 3], [0 8], 'color', 'k'); 
% line([1 2], [6.5 6.5], 'Color', 'black'); text(1.5, 6.65, '*', ...
%     'FontWeight', 'bold', 'FontSize', 14); 
xlim([0.5 2.5]); ylim([0.9 7.15]);
set(gca, 'XTick', [], 'XTickLabel', {'', ''}, 'YTick', 1:1:7, 'Fontsize', 9);
% title('Sense of ownership', 'FontWeight', 'bold');

subplot('Position', [0.13, 0.15, 0.77, 0.65]); hold on;
line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':', ...
    'LineWidth', 1.5); 
p_1(1) = plot(edge, hist(vect1(:), edge)/numel(vect1), ...
    'color', c(color, :), 'LineWidth', 3); 
p_1(2) = plot(edge, hist(vect2(:), edge)/numel(vect2), ...
    'color', c(color - 5, :), 'LineWidth', 3); 
line([mean(vect1), mean(vect1)], [-0.1 1.1], ...
    'color', c(color, :));
line([mean(vect2), mean(vect2)], [-0.1 1.1], ...
    'color', c(color - 5, :));
hold off; box on;

ylim([0 0.5]); xlim([0.9 7.15]); 
ylabel('Probability density');
xlabel('Responses to questionnaires'); 
set(gca, 'YTick', 0.1:0.1:0.6, ...
    'YTickLabel', {'0.1', '0.2', '0.3', '0.4', '0.5', ''}, ...
    'Fontsize', 8);
set(gca, 'XTick', 1:1:7, 'XTickLabel', 1:7, 'FontSize', 8); 

% legend(p_1, legend, 'Location', 'Northwest', ...
%     'Fontsize', 8, 'FontWeight', 'bold');

end