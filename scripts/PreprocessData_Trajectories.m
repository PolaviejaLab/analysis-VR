addpath('analyses\trajectories');
addpath('analyses');
addpath('getData');


%% Load data
[params] = GetParameters();
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\PreprocessData_Trajectories.mat');
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\QuestionnaireOrder.mat');
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\PreprocessData_Questionnaires.mat');

fprintf('Data loaded \n');


%% Variables
order_array = OrderQuestionnaires.Used;
waves_trial = [...
    1:25;
    26:50;
    51:75];


%% Remove unused subjects
preprocess.handp.timestamps_used = preprocess.handp.timestamps(vecUsed, params.dynamicTrials);
preprocess.handp.position_used = preprocess.handp.positions(vecUsed, params.dynamicTrials);
preprocess.timestamps.trialStart_used = preprocess.timestamps.trialStart(1, vecUsed);
preprocess.timestamps.trialEnd_used = preprocess.timestamps.trialEnd(1, vecUsed);
preprocess.timestamps.waveStart_used = preprocess.timestamps.waveStart(1, vecUsed);
preprocess.timestamps.waveEnd_used = preprocess.timestamps.waveEnd(1, vecUsed);


%% Extract Trial Trajectories

for i_participant = 1:numel(vecUsed)
    for i_trial = 1:numel(params.dynamicTrials)
        fprintf('Extracting participant: %u, trial: %u \n', i_participant, i_trial);
        try
            aux_start = preprocess.timestamps.trialStart_used{1,i_participant}(i_trial, 1:21);
            fprintf('Start index: %s \n', aux_start);
            aux_end = preprocess.timestamps.trialEnd_used{1,i_participant}(i_trial, 1:21);
            fprintf('End index: %s \n', aux_end);
        catch
            aux_start = NaN;
            aux_end = NaN;
            warning('No timestamps found');
        end
        
        if (isnan(aux_start))
            ind_start = NaN;
            ind_end = NaN;
            warning('No hand positions found');
        else
            
            ind_start = strmatch(aux_start, ...
                preprocess.handp.timestamps_used{i_participant, i_trial});
            ind_end = strmatch(aux_end, ...
                preprocess.handp.timestamps_used{i_participant, i_trial});
        end
        
        if (isempty(ind_start))
            ind_start = 1;
        end
        
        if (isempty(ind_end) && i_trial == 3)
            ind_end = size(preprocess.handp.position_used{i_participant, ...
                i_trial}, 1);
        end
        
        
        if(isnan(ind_start) | isempty(ind_start) | isempty(ind_end))
            processed.hpositions.trials{i_participant, ...
                order_array(params.dynamicTrials(i_trial))} = [];
        else
            processed.hpositions.trials{i_participant, order_array(params.dynamicTrials(i_trial))} = ...
                preprocess.handp.position_used{i_participant, ...
                i_trial}(ind_start(1):ind_end(1), :);
            fprintf('Hand Positions stored \n');
        end
    end
end

processed.hpositions.trials = processed.hpositions.trials(:, [3, 4, 6]);


%% Extract Trajectories for each wave

for i_participant = 1:numel(vecUsed)
    for i_trial = 1:numel(params.dynamicTrials)
        for i_wave = 1:25
            fprintf('Extracting participant: %u, trial: %u, waving event: %u \n', ...
                i_participant, i_trial, i_wave);
            try
                aux_start = preprocess.timestamps.waveStart_used{1, i_participant}(waves_trial(i_trial, i_wave), 1:21);
                fprintf('Start index: %s \n', aux_start);
                aux_end = preprocess.timestamps.waveEnd_used{1, i_participant}(waves_trial(i_trial, i_wave), 1:21);
                fprintf('End index: %s \n', aux_end);
            catch
                aux_start = NaN;
                aux_end = NaN;
                warning('No timestamps found \n');
            end
            
            
            if (isnan(aux_start))
                ind_start = NaN;
                ind_end = NaN;
                warning('No hand positions found \n');
            else
                ind_start = strmatch(aux_start, ...
                    preprocess.handp.timestamps_used{i_participant, i_trial});
                ind_end = strmatch(aux_end, ...
                    preprocess.handp.timestamps_used{i_participant, i_trial});
            end
            
            try
                if(isnan(ind_start) | isempty(ind_start) | isempty(ind_end))
                    processed.hpositions.wave{i_participant, order_array(params.dynamicTrials(i_trial))}{i_wave} = [];
                else
                    processed.hpositions.wave{i_participant, order_array(params.dynamicTrials(i_trial))}{i_wave} = ...
                        preprocess.handp.position_used{i_participant, ...
                        i_trial}(ind_start(1):ind_end(1), :);
                    fprintf('Hand Positions stored \n');
                end
            catch
                processed.hpositions.wave{i_participant, order_array(params.dynamicTrials(i_trial))}{i_wave} = [];
                warning('No hand positions stored \n');
            end
        end
    end  
end

processed.hpositions.wave = processed.hpositions.wave(:, [3, 4, 6]);


%% Save data
save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\PreprocessData_Trajectories.mat', 'preprocess');
save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\ProcessedData_Trajectories.mat', 'processed');

