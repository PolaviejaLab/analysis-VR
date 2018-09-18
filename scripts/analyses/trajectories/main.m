% TRAJECTORIES is used for the analysis of the trajectories of the task.
addpath('..\..\getData\');


%% Variables
% Common variables
dataDirectory = 'V:\Data\06. ExpRep';
filesSubjects = dir(fullfile(dataDirectory, 'Subject*'));

active_trials = [3, 4, 6];

load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\sociodem.mat')


%% Get the trajectories

for i_subject = 2:numel(vecUsed)
    
    subjectFolder = fullfile(dataDirectory, ...
        filesSubjects(vecUsed(i_subject)).name, '\');
    unityFolder = fullfile(dataDirectory, ...
        filesSubjects(vecUsed(i_subject)).name, '\Unity_Files\');
    fileName = filesSubjects(vecUsed(i_subject)).name;
    
    fprintf('Reading data for %s\n', fileName);
    
    % Log_File
    file_log = dir(fullfile(unityFolder, '*.log'));
    logFile_name = fullfile(unityFolder, file_log(1).name);
    
    % Get conditions order
    protocol_file = get_protocol_file (logFile_name);
    order_array = get_order_from_protocol (protocol_file);
    
    %% Find Timestamps
    
    try
        % Start and end of the trials
        [t_tStart] = get_timestamps (logFile_name, 'TrialController', ...
            'Started');
        [t_tEnd] = get_timestamps (logFile_name, 'TrialController', ...
            'Entering state TrialFinished');
        if (size(t_tStart, 1) == numel(active_trials) ||...
                size(t_tEnd, 1) == numel(active_trials))
            fprintf('%u and %u trials of %u found for %s \n', ...
                size(t_tStart, 1), size(t_tEnd, 1), ...
                numel(active_trials), filesSubjects(vecUsed(i_subject)).name);
            
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
                numel(active_trials), filesSubjects(vecUsed(i_subject)).name);
            fprintf('Active trials missing for %s \n', ...
                filesSubjects(vecUsed(i_subject)).name);
        end
    catch
        fprintf('no data available for %s \n', filesSubjects(vecUsed(i_subject)).name);
        continue;
    end
    
    
    %% Get trajectories files
    trajectory_files = dir(fullfile(unityFolder, '* Trial *.csv'));
    
    for i_trial = 1:numel(active_trials)
        try
            fid = fopen(fullfile(unityFolder, ...
                trajectory_files(active_trials(i_trial)).name));
            traject_file = textscan(fid, '%s %q %f %f %f', 'Delimiter', ',');
            
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
                
                handp_trials{i_subject, order_array(active_trials(i_trial))} = handp_subjTask;
            catch
                handp_trials{i_subject, order_array(active_trials(i_trial))} = NaN;
                fprintf('no coincident timestamps in trial %u of subject %u \n', i_trial, vecUsed(i_subject));
            end
        catch
            handp_trials{i_subject, order_array(active_trials(i_trial))} = NaN;
            fprintf('no trajectory file for trial %u in subject %u \n', ...
                i_trial, vecUsed(i_subject));
            continue;
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
                handp_waves{i_subject, order_array(active_trials(i_trial))} = handp_subjWaves;
            catch
                handp_subjWaves{i_trial, i_wave} = NaN;
                handp_waves{i_subject, order_array(active_trials(i_trial))} = NaN;
                
            continue;
            end
        end
    end
end 
    
    
% %% plot the three together
% for i_plot = 2:numel(vecUsed)
%     traj1 = handp_trials{i_plot,3}; traj2 = handp_trials{i_plot,4}; traj3 = handp_trials{i_plot,6};
%     try
%         figure, plot(traj1(:,1), traj1(:,3), 'k'), hold on, plot(traj2(:,1), traj2(:,3), 'b'), plot(traj3(:,1), traj3(:,3), 'r')
%     catch
%         continue;
%     end
%     xlim([-200 200]); ylim([-150 200]);
% end
%     
% 
% %% Plot the only the waves
% 
% colors = ['k', 'b', 'r'];
% 
% for i_plot = 2:numel(vecUsed)
%   
%     try
%     for i_trial = 1:3
%         figure,
%         for i_wave = 1:25
%             currentWave = handp_waves{i_plot,active_trials(i_trial)}{i_wave};
%             plot(currentWave(:,1), currentWave(:,3), 'color' , colors(i_trial)); hold on;
%         end
%     end
%     catch
%         continue;
%     end
%     
%     xlim([-200 200]); ylim([-150 200]);
% end
