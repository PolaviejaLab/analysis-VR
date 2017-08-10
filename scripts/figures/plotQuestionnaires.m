function [fig1, fig2] = plotQuestionnaires (data1, data2, ...
    plot_title, cond1, cond2, pboxplot)

edge = 1:7;

fig1 = figure(1); clf
hold on;
boxplot([data1(:) data2(:)], 'colors', 'k');
title(plot_title, 'fontname', 'arial');
xlabel('Responses to questionnaires', 'fontname', 'arial');
% ylabel(plot_ylabel, 'fontname', 'arial');

if (pboxplot < 0.05)
    ylim([0.5 8])
    line([1 2], [7.5 7.5], 'color', 'k');
    text(1.5, 7.65, '*', 'fontname', 'arial');
else
    ylim([0.5 7.5]); 
end

set(gca, 'YTick', 1:1:7);
hold off; box on;

fig2 = figure(2); clf
hold on;

% h1 = hist(data1(:), edge)/numel(data1);
% h2 = hist(data2(:), edge)/numel(data2);
% maxlim = max(max(h1), max(h2));
% maxlim = ceil(maxlim * 10)/10;
maxlim = 0.5;

line([mean(data1(:)), mean(data1(:))], [-0.1 1.1], ...
    'color', [70/255, 70/255, 70/255], 'LineWidth', 1.5);
line([mean(data2(:)), mean(data2(:))], [-0.1 1.1], ...
    'color', [145/255, 145/255, 145/255], 'LineWidth', 1.5);
p(1) = plot(edge, hist(data1(:), edge)/numel(data1), ...
    'color', [70/255, 70/255, 70/255], 'LineWidth', 4);
p(2) = plot(edge, hist(data2(:), edge)/numel(data2), ...
    'color', [145/255, 145/255, 145/255], 'LineWidth', 4);

xlim([0.5 7.5]);
ylim([0 maxlim]);
legend(p, {cond1, cond2}, 'location', 'northwest', 'fontname', 'arial');
title(plot_title, 'fontname', 'arial');
ylabel('Probabilty density', 'fontname', 'arial');
xlabel('Responses to questionnaire', 'fontname', 'arial');
hold off; box on;

end