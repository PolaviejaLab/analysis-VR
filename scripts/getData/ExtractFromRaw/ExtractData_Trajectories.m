addpath('..\');

%% Variables
[params] = GetParameters();

filesSubjects = dir(fullfile(params.dataDirectory, 'Subject*'));


%% Extract Trajectories
for s = 1:numel(filesSubjects)
    subjectFolder = fullfile(params.dataDirectory, ...
        filesSubjects(s).name, '\');
    unityFolder = fullfile(params.dataDirectory, ...
        filesSubjects(s).name, '\Unity_Files\');
    fileName = filesSubjects(s).name;
    
    fprintf('Reading data for %s\n', fileName);
    
    %% Get trajectories files
    trajectory_files = dir(fullfile(unityFolder, '* Trial *.csv'));
    for t = 1:numel(trajectory_files)
        fprintf('Reading data for trial %u \n', t);
        
        fid = fopen(fullfile(unityFolder, trajectory_files(t).name));
        try
            traject_file = textscan(fid, '%s %q %f %f %f', 'Delimiter', ',');
            
            handp_subjTrial = [...
                traject_file{1, 3}, ...
                traject_file{1, 4}, ...
                traject_file{1, 5}];
            
            handp_trials{s, t} = handp_subjTrial;
            timestamps_trials{s, t} = traject_file{1, 1};
            fprintf('Trajectories for subject %s extracted \n', fileName);
        catch
            handp_trials{s, t} = NaN;
            timestamps_trials{s, t} = NaN;
            fprintf('no trajectory file for trial %u in subject %u \n', ...
                t, s);
        end
        fclose(fid);
        
    end
    %% Extract trial timestamps
    % Log_File
    file_log = dir(fullfile(unityFolder, '*.log'));
    logFile_name = fullfile(unityFolder, file_log(1).name);
    try
        % Start and end of the trials
        [indicesStart, trialTimestamps{s, 1}] = get_timestamps (logFile_name, 'TrialController', ...
            'Started');
        [~, trialTimestamps{s, 2}] = get_timestamps (logFile_name, 'TrialController', ...
            'Entering state TrialFinished');
        fprintf('Trial timestamps data extracted \n');
    catch
        trialTimestamps{s, 1} = NaN;
        trialTimestamps{s, 2} = NaN;
        fprintf('No trial timestamps data available \n');
    end
    
    %% Extract waves timestamps
    [allWaves] = wave_timestamps (logFile_name, params, indicesStart);
    waveTimestamps{s} = allWaves;
    
end

preprocessed.handp.positions = handp_trials;
preprocessed.handp.timestamps = timestamps_trials;
preprocessed.timestamps.trials = trialTimestamps;
preprocessed.timestamps.waves = waveTimestamps;


save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\PreprocessedData_Trajectories.mat', ...
    'preprocessed');
