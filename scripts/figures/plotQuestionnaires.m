function [] = plotQuestionnaires (data1, data2, ...
    plot_title, plot_xlabel, plot_ylabel, cond1, cond2, pboxplot)

edge = 1:7;

figure(1), clf
hold on;
boxplot([data1(:) data2(:)], 'colors', 'k');
title(plot_title, 'fontname', 'arial');
xlabel(plot_xlabel, 'fontname', 'arial');
ylabel(plot_ylabel, 'fontname', 'arial');

if (pboxplot < 0.05)
    ylim([0.5 8])
    line([1 2], [7.5 7.5], 'color', 'k');
    text(1.5, 7.65, '*', 'fontname', 'arial');
else
    ylim([0.5 7.5]); 
end

hold off; box on;

figure(2), clf
hold on;
h1 = hist(data1(:), edge)/numel(data1);
h2 = hist(data2(:), edge)/numel(data2);

p(1) = plot(edge, hist(data1(:), edge)/numel(data1), ...
    'color', 'k', 'LineWidth', 3);
p(2) = plot(edge, hist(data2(:), edge)/numel(data2), ...
    'color', 'r', 'LineWidth', 3);
line([mean(data1(:)), mean(data1(:))], [-0.1 1.1], 'color', 'k');
line([mean(data2(:)), mean(data2(:))], [-0.1 1.1], 'color', 'r');

maxlim = max(max(h1), max(h2));
maxlim = ceil(maxlim * 10)/10;

xlim([0.5 7.5]);
ylim([0 maxlim]);
legend(p, {cond1, cond2}, 'location', 'northwest', 'fontname', 'arial');
ylabel('Probabilty density', 'fontname', 'arial');
xlabel('Responses to questionnaire', 'fontname', 'arial');
hold off; box on;

end