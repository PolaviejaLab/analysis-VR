% script for the figures as told as antonia
owner_stat_1 = median(squeeze(static_data(1:4, 1, :)));
owner_stat_2 = median(squeeze(static_data(1:4, 2, :)));
owner_stat_3 = median(squeeze(static_data(1:4, 3, :)));

mat_stat = [owner_stat_1', owner_stat_2', owner_stat_3'];

mat_plot = [-0.18:0.01:0.18];
mat_plot = mat_plot';
mat_plot = repmat(mat_plot, 1, 3);
mat_plot2 = repmat([1, 2, 3], 37, 1);
mat_plot = mat_plot + mat_plot2;

figure, hold on
plot(mat_plot, mat_stat, 'ok')
plot(mat_plot', mat_stat', '-b')
ylim([0.5 7.5]), xlim([0.5 3.5])
hold off, box on
title('Sense of ownership in Static conditions');
ylabel('Questionnaire responses');
set(gca, 'XTick', 1:1:3, 'XTickLabel', ...
    {'Full arm static','Detached hand static','Full arm static - post'});


%% Dynamic conditions
owner_dyn_1 = mean(squeeze(dynamic_data(1:4, 1, :)));
owner_dyn_2 = mean(squeeze(dynamic_data(1:4, 2, :)));
owner_dyn_3 = mean(squeeze(dynamic_data(1:4, 3, :)));

mat_dyn = [owner_dyn_1', owner_dyn_2', owner_dyn_3'];

figure, hold on
plot(mat_plot, mat_dyn, 'ok')
plot(mat_plot', mat_dyn', '-b')
ylim([0.5 7.5]), xlim([0.5 3.5]);
hold off, box on

title('Sense of ownership in Dynamic conditions');
ylabel('Questionnaire responses');
set(gca, 'XTick', 1:1:3, 'XTickLabel', ...
    {'Full arm dynamic','Detached hand dynamic','Noisy movement'});


%% All together now

mat_all = [...
    owner_stat_1', owner_stat_2', ...
    owner_dyn_1', owner_dyn_2', ...
    owner_stat_3', ...
    owner_dyn_3'];

mat_plot = [-0.09:0.005:0.09];
mat_plot = mat_plot';
mat_plot = repmat(mat_plot, 1, 6);
mat_plot2 = repmat([1:6], 37, 1);
mat_plot = mat_plot + mat_plot2;

figure, hold on
rectangle('Position', [0.5, 0.5, 2, 7],...
    'FaceColor', [225/255 225/255 225/255], 'LineStyle', 'none');
rectangle('Position', [2.5, 0.5, 2, 7],...
    'FaceColor', [245/255 245/255 245/255], 'LineStyle', 'none');
rectangle('Position', [4.5, 0.5, 1, 7],...
    'FaceColor', [225/255 225/255 225/255], 'LineStyle', 'none');
rectangle('Position', [5.5, 0.5, 1, 7],...
    'FaceColor', [245/255 245/255 245/255], 'LineStyle', 'none');

line([0, 8], [5, 5])
line([0, 8], [3, 3])

plot(mat_plot, mat_all, 'ok')
plot(mat_plot', mat_all', '-b')
ylim([0.5 7.5]), xlim([0.5 6.5])
hold off, box on

title('Sense of ownership in all conditions');
ylabel('Questionnaire responses');
set(gca, 'XTick', 1:1:6, 'XTickLabel', ...
    {'Full arm static','Detached hand static', ...
    'Full arm dynamic','Detached hand dynamic', ...
    'Full arm static - post', 'Noisy movement'});