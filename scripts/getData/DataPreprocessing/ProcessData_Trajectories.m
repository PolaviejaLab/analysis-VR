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
    preprocessed.timestamps.waves(vecUsed, :);

fprintf('Unused subjects removed \n');


%% Clear Timestamps Waving Evens

[preprocessed.timestamps.waves_processed, preprocessed.timestamps.waves_processed2] = ...
    cutWavesPerTrial(preprocessed.timestamps.waves_used, ...
    preprocessed.timestamps.trials_used, params);


%% Extract Trial Trajectories

for i_participant = 1:numel(vecUsed)
    for i_trial = 1:numel(params.dynamicTrials)
        fprintf('Extracting participant: %u, trial: %u \n', i_participant, i_trial);
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
        
        %% Wave Hand Position in each Trial
        if (isempty(processed.hpositions.trials{i_participant, ...
                order_array(params.dynamicTrials(i_trial))}))
            processed.hpositions.trials{i_participant, ...
                order_array(params.dynamicTrials(i_trial))} = [];
        else
            for i_wave = 1:25
                fprintf('Extracting participant: %u, trial: %u, waving event: %u \n', ...
                    i_participant, i_trial, i_wave);
                
                try
                    aux_start = ...
                        preprocessed.timestamps.waves_processed{i_participant, i_trial}{1}(i_wave, 1:21);
                    fprintf('Wave start timestamp: %s \n', aux_start);
                    aux_end = ...
                        preprocessed.timestamps.waves_processed{i_participant, i_trial}{2}(i_wave, 1:21);
                    fprintf('Wave end timestamp: %s \n', aux_end);
                catch
                    aux_start = NaN;
                    aux_end = NaN;
                    warning('No timestamps for wave %u in trial %u found', ...
                        i_wave, i_trial);
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
                
                if(isnan(ind_start) | isempty(ind_start) | isempty(ind_end))
                    processed.hpositions.trials{i_participant, ...
                        order_array(params.dynamicTrials(i_trial))} = [];
                    warning('did not find hand positions');
                else
                    processed.hpositions.waves{i_participant, order_array(params.dynamicTrials(i_trial))}{i_wave} = ...
                        preprocessed.handp.position_used{i_participant, ...
                        i_trial}(ind_start(1):ind_end(1), :);
                    fprintf('Hand Positions stored \n');
                end
            end
        end
    end
end

processed.hpositions.trials = processed.hpositions.trials(:, [3, 4, 6]);
processed.hpositions.waves = processed.hpositions.waves(:, [3, 4, 6]);











% %% Transform TS into duration of the task
%
% for i_participant = 1:numel(vecUsed)
%     for i_trial = 1:numel(params.dynamicTrials)
%         fprintf('Extracting time of participant: %u, trial: %u \n', i_participant, i_trial);
%         try
%             aux_start = preprocessed.timestamps.trialStart_used{1,i_participant}(i_trial, 12:23);
%             fprintf('Starting time: %s \n', aux_start);
%             aux_end = preprocessed.timestamps.trialEnd_used{1,i_participant}(i_trial, 12:23);
%             fprintf('Finishing time: %s \n', aux_end);
%         catch
%             aux_start = NaN;
%             aux_end = NaN;
%             warning('No time found');
%         end
%
%
%         try
%             msStart = str2num(aux_start(10:12));
%             [sStart] = TransformToSeconds(aux_start(1:8));
%
%             msEnd = str2num(aux_end(10:12));
%             [sEnd] = TransformToSeconds(aux_end(1:8));
%
%             processed.timestamps.taskDuration{i_participant, ...
%                 order_array(params.dynamicTrials(i_trial))} = ...
%                 ((sEnd * 1000) + msEnd) - ((sStart * 1000) + msStart);
%             fprintf('Duration: %u \n', processed.timestamps.taskDuration{i_participant, ...
%                 order_array(params.dynamicTrials(i_trial))})
%         catch
%             processed.timestamps.taskDuration{i_participant, ...
%                 order_array(params.dynamicTrials(i_trial))} = NaN;
%             fprintf('Durantion: not found \n')
%         end
%     end
% end
%
% processed.timestamps.taskDuration = ...
%     processed.timestamps.taskDuration(:, params.dynamicTrials);
%
% % another way to do it to generate struct with both,and then substract all
% % at the same time while creating the new variable. - extra Points
%
%
% %% Transform TS into the duration of each individual waving event
%
% for i_participant = 2:numel(vecUsed)
%     for i_trial = 1:numel(params.dynamicTrials)
%         for i_wave = 1:25
%             fprintf('Extracting wave time for participant %u, trial %u, waving event %u \n', ...
%                 i_participant, i_trial, i_wave);
%
%             try
%                 aux_start = preprocessed.timestamps.waveStart_used{1, i_participant}(params.waves_trial(i_trial, i_wave), 12:23);
%                 fprintf('Start index: %s \n', aux_start);
%                 aux_end = preprocessed.timestamps.waveEnd_used{1, i_participant}(params.waves_trial(i_trial, i_wave), 12:23);
%                 fprintf('End index: %s \n', aux_end);
%             catch
%                 aux_start = NaN;
%                 aux_end = NaN;
%                 warning('No timestamps found');
%             end
%
%             try
%                 msStart = str2num(aux_start(10:12));
%                 [sStart] = TransformToSeconds(aux_start(1:8));
%
%                 msEnd = str2num(aux_end(10:12));
%                 [sEnd] = TransformToSeconds(aux_end(1:8));
%
%                 processed.timestamps.waveDuration{i_participant, ...
%                     order_array(params.dynamicTrials(i_trial))}(i_wave) = ...
%                     ((sEnd * 1000) + msEnd) - ((sStart * 1000) + msStart);
%                 fprintf('wave duration found \n');
%                 %                 fprintf('wave %u duration: %u \n', i_wave, processed.timestamps.waveDuration{i_participant, ...
%                 %                     order_array(params.dynamicTrials(i_trial))})
%             catch
%                 processed.timestamps.waveDuration{i_participant, ...
%                     i_participant, order_array(params.dynamicTrials(i_trial))}(i_wave) = NaN;
%                 warning('Wave duration: not found')
%             end
%         end
%     end
% end
%
% processed.timestamps.waveDuration = ...
%     processed.timestamps.waveDuration(:, params.dynamicTrials);
%

%% Save data
save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\preprocessedData_Trajectories.mat', 'preprocessed');
save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\ProcessedData_Trajectories.mat', 'processed');

