function [] = plotBoxplots (data, figure_title)

hold on;

n_boxes = size(data, 1);

boxplot(data', 'colors', 'k');


title(figure_title);
ylim([0.5 7.5]);

end
