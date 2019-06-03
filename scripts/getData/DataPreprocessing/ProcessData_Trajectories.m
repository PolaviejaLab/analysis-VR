addpath('..\');


%% Load data
[params] = GetParameters();

fprintf('Loading Data \n');
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\PreprocessedData_Trajectories.mat');
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\QuestionnaireOrder.mat');
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\PreprocessData_Questionnaires.mat');

fprintf('Data loaded \n');


%% Variables
order_array = OrderQuestionnaires.Used;


%% Remove unused subjects
fprintf('Removing unused participants \n');

preprocessed.handp.timestamps_used = ...
    preprocessed.handp.timestamps(vecUsed, params.dynamicTrials);
preprocessed.handp.position_used = ...
    preprocessed.handp.positions(vecUsed, params.dynamicTrials);
preprocessed.timestamps.trials_used = ...
    preprocessed.timestamps.trials(vecUsed, :);
preprocessed.timestamps.waves_used = ...
    preprocessed.timestamps.waves(:, vecUsed);

fprintf('Unused subjects removed \n');


%% Divide the waves for each trial

[preprocessed.timestamps.wavesCutByTrial] = cutWavesPerTrial(...
    preprocessed.timestamps.waves_used, ...
    preprocessed.timestamps.trials_used, ...
    params);


%% Get the handp
for i_participant = 1:numel(vecUsed)
    fprintf('Extracting handp data for participant %u \n', i_participant);
    
    for i_trial = 1:numel(params.dynamicTrials)
        fprintf('Extracting handp data for trial %u \n', i_trial);
        
        try
            aux_start = preprocessed.timestamps.trials_used{i_participant, 1}(i_trial, 1:21);
            fprintf('Start timestamp: %s \n', aux_start);
            aux_end = preprocessed.timestamps.trials_used{i_participant, 2}(i_trial, 1:21);
            fprintf('End timestamp: %s \n', aux_end);
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
                preprocessed.handp.timestamps_used{i_participant, i_trial});
            ind_end = strmatch(aux_end, ...
                preprocessed.handp.timestamps_used{i_participant, i_trial});
        end
        
        if (isempty(ind_start))
            ind_start = 1;
        end
        
        if (isempty(ind_end) && i_trial == 3)
            ind_end = size(preprocessed.handp.position_used{i_participant, ...
                i_trial}, 1);
        end
        
        if(isnan(ind_start) | isempty(ind_start) | isempty(ind_end))
            processed.hpositions.trials{i_participant, ...
                order_array(params.dynamicTrials(i_trial))} = [];
        else
            processed.hpositions.trials{i_participant, order_array(params.dynamicTrials(i_trial))} = ...
                preprocessed.handp.position_used{i_participant, ...
                i_trial}(ind_start(1):ind_end(1), :);
            fprintf('Hand Positions stored \n');
        end
    end
end


%% Extract Wave Trajectories

for i_participant = 1:numel(vecUsed)
    fprintf('Extracting handp data for participant %u \n', i_participant);
    for i_trial = 1:numel(params.dynamicTrials)
        fprintf('Extracting handp data for trial %u \n', i_trial);
        
        if (isempty(processed.hpositions.trials{i_participant, ...
                order_array(params.dynamicTrials(i_trial))}))
            processed.hpositions.trials{i_participant, ...
                order_array(params.dynamicTrials(i_trial))} = [];
            continue,
        else
            for i_wave = 1:size(preprocessed.timestamps.wavesCutByTrial{...
                    i_participant, i_trial}{1,1}, 1)
                fprintf('Extracting handp data for wave %u \n', i_wave);
                wavesStart_ = preprocessed.timestamps.wavesCutByTrial{ ...
                    i_participant, i_trial}(1);
                wavesEnd_ = preprocessed.timestamps.wavesCutByTrial{ ...
                    i_participant, i_trial}(2);
                
                try
                    ind_start = strmatch(wavesStart_{1}(i_wave, 1:22), ...
                        preprocessed.handp.timestamps_used{i_participant, i_trial});
                    ind_end = strmatch(wavesEnd_{1}(i_wave, 1:22), ...
                        preprocessed.handp.timestamps_used{i_participant, i_trial});
                    
                    processed.hpositions.waves{i_participant, order_array(params.dynamicTrials(i_trial))}{i_wave} = ...
                        preprocessed.handp.position_used{i_participant, ...
                        i_trial}(ind_start(1):ind_end(1), :);
                    fprintf('Hand Positions stored \n');

                    
                catch
                    processed.hpositions.waves{i_participant, order_array(params.dynamicTrials(i_trial))}{i_wave} = NaN;
                    warning('No hand positions found');
                end
                
            end
        end
    end
end


%% Wave Hand Position in each Trial
processed.hpositions.trials = processed.hpositions.trials(:, [3, 4, 6]);
processed.hpositions.waves = processed.hpositions.waves(:, [3, 4, 6]);


%% Save data
save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\preprocessedData_Trajectories.mat', 'preprocessed');
save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\ProcessedData_Trajectories.mat', 'processed');

