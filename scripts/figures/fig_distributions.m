function [] = fig_distributions (vector1, vector2, color1, color2, ...
    n_participants, mean1, mean2, axis_fontsize, p_val, p_val_ks)
% FIG_DISTRIBUTIONS plots the distributions (histograms) with a defined
% line and color. It takes the vectors and defines de histogram values and
% plots it
%   vector1 and vector2, raw vector
%   color1 and color2, colors of the lines from the parula colormap
%   n_participants
%   mean1 and mean2
%   axis_fontsize
%   pval, is p-val of the diferences of the means
%   pval_ks, p-val from the KS test

c = parula;
c =  c([1 6 11 16 21 26 31 36 41 46 51 56 61], :);

fig = figure,
set(fig, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);

edge = 1:7;

plot(edge, hist(vector1, edge)/n_participants, ...
    'color', c(color1, :), 'LineWidth', 5); hold on,
plot(edge, hist(vector2, edge)/n_participants, ...
    'color', c(color2, :), 'LineWidth', 5); hold on,

line([mean1, mean1], [-0.1 1.1], ...
    'LineStyle', '-', 'color', c(color1, :));
line([mean2, mean2], [-0.1 1.1], ...
    'LineStyle', '-', 'color', c(color2, :));
line([0 8],[0 0], 'LineStyle', ':', 'color', [211/256 211/256 211/256]);

xlim([1 7]);
ylim([-0.05 1]);

xlabel('questionnaire responses', 'FontSize', ...
    axis_fontsize, 'FontWeight', 'bold');
ylabel('probability density', 'FontSize', ...
    axis_fontsize, 'FontWeight', 'bold');

text(1.25, 0.75, strcat('p =', num2str(p_val, '%.3f')), 'FontSize', 12, 'color', c(color2, :));
text(1.25, 0.65, strcat('p =', num2str(p_val_ks, '%.3f')), 'FontSize', 12, 'color', 'k');

end