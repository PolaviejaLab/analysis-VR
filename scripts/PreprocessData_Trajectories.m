addpath('analyses\trajectories');
addpath('analyses');
addpath('getData');

%% Load data
[params] = GetParameters();
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\Data.mat');
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\QuestionnaireOrder.mat');
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\Data_Trajectories.mat');

%% Variables
order_array = OrderQuestionnaires.Used(:, i_subject);


%% Remove unused subjects
timestamps_used = timestamps_trials(vecUsed, :);
handp_used = handp_trials(vecUsed, :);




%% Extract Timestamps

for i_subject = 1:numel(vecUsed)
   
    
    
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

