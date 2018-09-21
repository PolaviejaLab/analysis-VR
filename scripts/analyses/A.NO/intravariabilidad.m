load('V:\Data\04. Exp1_Frontiers\mat_poster2.mat');

c = parula;
cmap = c(10:2:42,:);

n_ind = 20;

font_title = 18;

%%

pvals_distance_bs = [...
    stat_bootstrapping(10000, distINTRA(:, 1)', distINTRA(:, 2)');
    stat_bootstrapping(10000, distINTRA(:, 1)', distINTRA(:, 3)');
    stat_bootstrapping(10000, distINTRA(:, 2)', distINTRA(:, 3)');
    ];

pvals_times_bs = [...
    stat_bootstrapping(10000, timesINTRA(:, 1)', timesINTRA(:, 2)');
    stat_bootstrapping(10000, timesINTRA(:, 1)', timesINTRA(:, 3)');
    stat_bootstrapping(10000, timesINTRA(:, 2)', timesINTRA(:, 3)');
    ];

fig1 = figure(1); clf
subplot (1, 2, 1); hold on;

distance_bar = bar(1:3, ...
    [mean(distINTRA(:, 1)), mean(distINTRA(:, 2)), mean(distINTRA(:, 3))]);
errorbar([mean(distINTRA(:, 1)), mean(distINTRA(:, 2)), mean(distINTRA(:, 3))], [ ...
    std(distINTRA(:, 1))/sqrt(n_ind), std(distINTRA(:, 2))/sqrt(n_ind), std(distINTRA(:, 3))/sqrt(n_ind)], 'k'); hold off, 

xlim([0.5 3.5]); ylim([0 1.2]);
set(gca, 'XTick', 1:3, 'XTickLabel', {'control', 'gap', 'noise'}, 'FontSize', 13);
set(distance_bar, 'FaceColor', cmap(15, :));
title('intravariability distance', 'FontSize', font_title, 'FontWeight', 'bold');
ylabel('coefficent of variance', 'FontSize', 16, 'FontWeight', 'bold');
xlabel('conditions', 'FontSize', 16, 'FontWeight', 'bold');

line([1 2], [1.05 1.05], 'Color', 'k');
text(1.5, 1.1, '*', 'FontSize', 14, 'FontWeight', 'bold');

subplot(1, 2, 2); hold on;
times_bar = bar(1:3, ...
    [mean(timesINTRA(:, 1)), mean(timesINTRA(:, 2)), mean(timesINTRA(:, 3))]);
errorbar([mean(timesINTRA(:, 1)), mean(timesINTRA(:, 2)), mean(timesINTRA(:, 3))], [ ...
    std(timesINTRA(:, 1))/sqrt(n_ind), std(timesINTRA(:, 2))/sqrt(n_ind), std(timesINTRA(:, 3))/sqrt(n_ind)], 'k'); hold off, 

set(gca, 'XTick', 1:3, 'XTickLabel', {'control', 'gap', 'noise'}, 'FontSize', 13);
set(times_bar, 'FaceColor', cmap(15, :));
xlim([0.5 3.5]); ylim([0 0.45]);
title('intravariability times', 'FontSize', font_title, 'FontWeight', 'bold');
ylabel('coefficent of variance', 'FontSize', 16, 'FontWeight', 'bold');
xlabel('conditions', 'FontSize', 16, 'FontWeight', 'bold');

set(fig1,'units','normalized', 'Position', [0.15 0 0.8 0.65]);