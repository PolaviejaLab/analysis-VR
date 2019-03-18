addpath('..\');

%% Variables
[params] = GetParameters();

filesSubjects = dir(fullfile(params.dataDirectory, 'Subject*'));


%% Extract Trajectories
for i_participant = 1:numel(filesSubjects)
    subjectFolder = fullfile(params.dataDirectory, ...
        filesSubjects(i_participant).name, '\');
    unityFolder = fullfile(params.dataDirectory, ...
        filesSubjects(i_participant).name, '\Unity_Files\');
    fileName = filesSubjects(i_participant).name;
    
    fprintf('Reading data for %s\n', fileName);
    
    %% Get trajectories files
    trajectory_files = dir(fullfile(unityFolder, '* Trial *.csv'));
    for i_trial = 1:numel(trajectory_files)
        fprintf('Reading data for trial %u \n', i_trial);
        
        fid = fopen(fullfile(unityFolder, trajectory_files(i_trial).name));
        try
            traject_file = textscan(fid, '%s %q %f %f %f', 'Delimiter', ',');
            
            handp_subjTrial = [...
                traject_file{1, 3}, ...
                traject_file{1, 4}, ...
                traject_file{1, 5}];
            
            handp_trials{i_participant, i_trial} = handp_subjTrial;
            timestamps_trials{i_participant, i_trial} = traject_file{1, 1};
            fprintf('Trajectories for subject %s extracted \n', fileName);
        catch
            handp_trials{i_participant, i_trial} = NaN;
            timestamps_trials{i_participant, i_trial} = NaN;
            fprintf('no trajectory file for trial %u in subject %u \n', ...
                i_trial, i_participant);
        end
        fclose(fid);
        
    end
    %% Extract trial timestamps
    % Log_File
    file_log = dir(fullfile(unityFolder, '*.log'));
    logFile_name = fullfile(unityFolder, file_log(1).name);
    try
        % Start and end of the trials
        trialTimestamps{i_participant, 1} = get_timestamps (logFile_name, 'TrialController', ...
            'Started');
        trialTimestamps{i_participant, 2} = get_timestamps (logFile_name, 'TrialController', ...
            'Entering state TrialFinished');
        fprintf('Trial timestamps dat extracted \n');
    catch
        trialTimestamps{i_participant, 1} = NaN;
        trialTimestamps{i_participant, 2} = NaN;
        fprintf('No trial timestamps data available \n');
    end
    
    %% Extract waves timestamps
    
    try
        % Start and end of the trials
        waveTimestamps{i_participant, 1} = get_timestamps (logFile_name, ...
            params.tags.Controller.wave, params.tags.Event.waveStart);
        waveTimestamps{i_participant, 2} = get_timestamps (logFile_name, ...
            params.tags.Controller.wave, params.tags.Event.waveEnd{1});
        fprintf('Waving events timestamps data extracted \n');
    catch
        waveTimestamps{i_participant, 1} = NaN;
        waveTimestamps{i_participant, 2} = NaN;
        fprintf('No waving events timestamp data available \n');
    end
end

preprocessed.handp.positions = handp_trials;
preprocessed.handp.timestamps = timestamps_trials;
preprocessed.timestamps.trials = trialTimestamps;
preprocessed.timestamps.waves = waveTimestamps;


save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\PreprocessedData_Trajectories.mat', ...
    'preprocessed');
