addpath('..\getData');

%% Variables
[params] = GetParameters();


%% Load trajectory Data
fprintf('Loading data \n');
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\ProcessedData_Trajectories.mat');

fprintf('Data loaded \n');

%% Duration of the task
results.taskTimeSubject = [...
    cell2mat(processed.timestamps.taskDuration(:, 1))/1000, ...
    cell2mat(processed.timestamps.taskDuration(:, 2))/1000, ...
    cell2mat(processed.timestamps.taskDuration(:, 3))/1000, ...
    ];

results.meanTaskDuration = nanmean(results.taskTimeSubject);
results.stdTaskDuration = nanstd(results.taskTimeSubject);


%% Mean duration of the waving event / condition / participant

for i_participant = 1:size(processed.timestamps.waveDuration, 1)
    for i_condition = 1:numel(params.dynamicTrials)
        results.meanWaveDurationParticipant{i_condition, i_participant} = ...
            nanmean(cell2mat(processed.timestamps.waveDuration(i_participant, i_condition)), 2)/1000;
        
        results.meanWaveDuration(i_condition, i_participant) = ...
            nanmean(cell2mat(results.meanWaveDurationParticipant(i_condition)));
        results.stdWaveDuration(i_condition, i_participant) = nanstd(cell2mat(results.meanWaveDurationParticipant(i_condition)));
        results.nWave(i_condition, i_participant) = size(results.meanWaveDurationParticipant{i_condition}, 1);
    end
end


%% Save results
save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\Results_Trajectories.mat', 'results');

