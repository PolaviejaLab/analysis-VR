function [] = formatcorrelations (PlotTitle, XLabel, YLabel)
line([0, 8],[0, 8], ...
    'LineStyle', ':', 'Color', [212/255 212/255 212/255]); hold on;
line([0, 8],[4, 4], ...
    'LineStyle', ':', 'Color', [197/255 153/255 153/255]); hold on;
line([4, 4],[0, 8], ...
    'LineStyle', ':', 'Color', [197/255 153/255 153/255]); hold on;
title(PlotTitle);
xlim([0.5 7.5]);
ylim([0.5 7.5]);
set(gca, 'XTickLabel', (1:1:7), 'FontSize', 12);
set(gca, 'YTickLabel', (1:1:7), 'FontSize', 12);
xlabel(XLabel, 'FontWeight', 'bold');
ylabel(YLabel, 'FontWeight', 'bold');
end 