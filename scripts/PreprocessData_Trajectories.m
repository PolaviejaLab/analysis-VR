addpath('analyses\trajectories');
addpath('analyses');
addpath('getData');
[params] = GetParameters();
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\Data.mat');
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\QuestionnaireOrder.mat');


save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\Data_Trajectories.mat', ...
    'handp_trials', 'handp_waves');

    % Get conditions order
    order_array = OrderQuestionnaires.Used(:, i_subject);
    
      % Log_File
    file_log = dir(fullfile(unityFolder, '*.log'));
    logFile_name = fullfile(unityFolder, file_log(1).name);
  

    % Extract Timestamps
    %% Find Timestamps  
    try
        % Start and end of the trials
        [t_tStart] = get_timestamps (logFile_name, 'TrialController', ...
            'Started');
        [t_tEnd] = get_timestamps (logFile_name, 'TrialController', ...
            'Entering state TrialFinished');
        if (size(t_tStart, 1) == numel(params.dynamicTrials) ||...
                size(t_tEnd, 1) == numel(params.dynamicTrials))
            fprintf('%u and %u trials of %u found for %s \n', ...
                size(t_tStart, 1), size(t_tEnd, 1), ...
                numel(params.dynamicTrials), filesSubjects(vecUsed(i_subject)).name);
            
            %% Each wave from Initial to Target (Timestamps)
            try
                % Start and end of the trials
                [t_wStart] = get_timestamps (logFile_name, 'WaveController', ...
                    'Entering state Target');
                [t_wEnd] = get_timestamps (logFile_name, 'WaveController', ...
                    'Entering state Waved');
                
                fprintf('%u and %u waving events timestamps found for %s \n', ...
                    size(t_wStart, 1), size(t_wEnd, 1), ...
                    filesSubjects(vecUsed(i_subject)).name);
            catch
                fprintf('no waving events data available for %s \n', ...
                    filesSubjects(vecUsed(i_subject)).name);
            end
        else
            fprintf('%u and %u trials of %u found for %s \n', ...
                size(t_tStart, 1), size(t_tEnd, 1), ...
                numel(params.dynamicTrials), filesSubjects(vecUsed(i_subject)).name);
            fprintf('Active trials missing for %s \n', ...
                filesSubjects(vecUsed(i_subject)).name);
        end
    catch
        fprintf('no data available for %s \n', filesSubjects(vecUsed(i_subject)).name);

    end
    
    
    
              %% Get the trajectories for the whole task
            try
                ind_start = strmatch(t_tStart(i_trial, 1:21), traject_file{1});
                ind_end = strmatch(t_tEnd(i_trial, 1:21), traject_file{1});
                
                handp_subjTrial = [...
                    traject_file{1, 3}, ...
                    traject_file{1, 4}, ...
                    traject_file{1, 5}];
                
                if (~isempty(ind_start))
                    handp_subjTask = handp_subjTrial(ind_start(1):ind_end(1), :);
                else
                    handp_subjTask = handp_subjTrial(1:ind_end(1), :);
                end
                
               
            catch
                handp_trials{i_subject, order_array(params.dynamicTrials(i_trial))} = NaN;
                fprintf('no coincident timestamps in trial %u of subject %u \n', i_trial, vecUsed(i_subject));
            end

        

        %% Get the waves within each trial
        timestamps_waves = [...
            1:25;
            26:50;
            51:75
            ];
        
        for i_wave = 1:25 
            
            try
                ind_wStart = strmatch(t_wStart(timestamps_waves(i_trial, i_wave), 1:21), ...
                    traject_file{1});
                ind_wEnd = strmatch(t_wEnd(timestamps_waves(i_trial, i_wave), 1:21), ...
                    traject_file{1});
                
                handp_wave = handp_subjTrial(ind_wStart(1):ind_wEnd(1), :);
                
                handp_subjWaves{i_trial, i_wave} = handp_wave;
                handp_waves{i_subject, order_array(params.dynamicTrials(i_trial))} = handp_subjWaves;
            catch
                handp_subjWaves{i_trial, i_wave} = NaN;
                handp_waves{i_subject, order_array(params.dynamicTrials(i_trial))} = NaN;
                
            continue;
            end
        end
    end

    