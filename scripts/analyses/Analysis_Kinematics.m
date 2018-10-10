addpath('..\getData');

%% Variables
[params] = GetParameters();


%% Load trajectory Data
fprintf('Loading data \n');
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\ProcessedData_Trajectories.mat');

fprintf('Data loaded \n');

%% Duration of the task
timeSubject = [...
    cell2mat(processed.timestamps.taskDuration(:, 1))/1000, ...
    cell2mat(processed.timestamps.taskDuration(:, 2))/1000, ...
    cell2mat(processed.timestamps.taskDuration(:, 3))/1000, ...
    ];

results.meanTimeCondition = nanmean(timeSubject);
results.stdTimeCondition = nanstd(timeSubject);


%% Mean duration of the waving event / condition / participant
for i_condition = 1:numel(params.dynamicTrials)
    results.meanTimeWave{i_condition} = nanmean(cell2mat(processed.timestamps.waveDuration(:, i_condition)), 2)/1000;
    
    results.meanWaveTime(i_condition) = nanmean(cell2mat(results.meanTimeWave(i_condition)));
    results.stdWaveTime(i_condition) = nanstd(cell2mat(results.meanTimeWave(i_condition)));
    results.nWave(i_condition) = size(results.meanTimeWave{i_condition}, 1);
end


%% 





%% Save results
save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\Results_Trajectories.mat', 'results');

