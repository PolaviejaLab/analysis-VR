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
waves_trial1 = 1:25;
waves_trial2 = 26:50;
waves_trial3 = 51:75;


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
            try
                ind_start = strmatch(aux_start, ...
                    preprocess.handp.timestamps_used{i_participant, i_trial});
                ind_end = strmatch(aux_end, ...
                    preprocess.handp.timestamps_used{i_participant, i_trial});
            catch
                ind_start = 1;
                warning('No matching timestamps for start of the trial');
                ind_end = strmatch(aux_end, ...
                    preprocess.handp.timestamps_used{i_participant, i_trial});
            end
            
        end
        
        if(isnan(ind_start))
            processed.handp.position{i_participant, i_trial} = [];
        else
            processed.handp.position{i_participant, i_trial} = ...
                preprocess.handp.position_used{i_participant, i_trial}(ind_start:ind_end, :);
            fprintf('Hand Positions stored \n');          
        end
    end 
end

save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\PreprocessData_Trajectories.mat', 'preprocess');
save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\ProcessedData_Trajectories.mat', 'processed');











% for i_wave = 1:25
%
%     try
%         ind_wStart = strmatch(t_wStart(timestamps_waves(i_trial, i_wave), 1:21), ...
%             traject_file{1});
%         ind_wEnd = strmatch(t_wEnd(timestamps_waves(i_trial, i_wave), 1:21), ...
%             traject_file{1});
%
%         handp_wave = handp_subjTrial(ind_wStart(1):ind_wEnd(1), :);
%
%         handp_subjWaves{i_trial, i_wave} = handp_wave;
%         handp_waves{i_subject, order_array(params.dynamicTrials(i_trial))} = handp_subjWaves;
%     catch
%         handp_subjWaves{i_trial, i_wave} = NaN;
%         handp_waves{i_subject, order_array(params.dynamicTrials(i_trial))} = NaN;
%
%         continue;
%     end
% end
%
%
