


%% Load trajectory Data
fprintf('Loading data \n');
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\Results_Trajectories.mat');

fprintf('Data loaded \n');

%% total duration of the task / condtion * participant

figure, hold on

bar(1:3, [results.meanTimeCondition]);
errorbar(1:3, [results.meanTimeCondition], [results.stdTimeCondition], 'k');

set(gca, 'XTick', [1:3], 'XTickLabel', params.conditionDynamic);
title('Task duration in dynamic trials', 'fontsize', 12, 'fontweight', 'bold');
ylabel('Task duration in seconds');
xlabel('');


%% wave duration 
figure, hold on
bar(1:3, [results.meanWaveTime]);
errorbar(1:3, [results.meanWaveTime], [results.meanWaveTime], 'k');
text(1.1, 1, num2str(results.nWave(:, 1)), 'color', 'r')
text(2.1, 1, num2str(results.nWave(:, 2)), 'color', 'r')
text(3.1, 1, num2str(results.nWave(:, 3)), 'color', 'r')

hold off, box on, 

set(gca, 'XTick', [1:3], 'XTickLabel', params.conditionDynamic);
title('Mean waving event duration in dynamic trials', 'fontsize', 12, 'fontweight', 'bold');
ylabel('Duration in seconds');
xlabel('');