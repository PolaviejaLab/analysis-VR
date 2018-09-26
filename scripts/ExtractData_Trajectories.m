dataDirectory = 'V:\Data\06. ExpRep';
addpath('getData');

filesSubjects = dir(fullfile(dataDirectory, 'Subject*'));

%% Extract Trajectories
for i_subject = 1:numel(filesSubjects)
    subjectFolder = fullfile(dataDirectory, ...
        filesSubjects(i_subject).name, '\');
    unityFolder = fullfile(dataDirectory, ...
        filesSubjects(i_subject).name, '\Unity_Files\');
    fileName = filesSubjects(i_subject).name;
    
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
            
            handp_trials{i_subject, i_trial} = handp_subjTrial;
            timestamps_trials{i_subject, i_trial} = traject_file{1, 1};
            fprintf('Trajectories for subject %s extracted \n', fileName);
        catch
            handp_trials{i_subject, i_trial} = NaN;
            timestamps_trials{i_subject, i_trial} = NaN;
            fprintf('no trajectory file for trial %u in subject %u \n', ...
                i_trial, i_subject);
        end
        fclose(fid);
        
    end
    %% Extract trial timestamps
    % Log_File
    file_log = dir(fullfile(unityFolder, '*.log'));
    logFile_name = fullfile(unityFolder, file_log(1).name);
    try
        % Start and end of the trials
        [t_tStart] = get_timestamps (logFile_name, 'TrialController', ...
            'Started');
        [t_tEnd] = get_timestamps (logFile_name, 'TrialController', ...
            'Entering state TrialFinished');
        
        fprintf('%u and %u trials found for %s \n', ...
            size(t_tStart, 1), size(t_tEnd, 1), ...
            filesSubjects(i_subject).name);
        
        startTrial_timestamps{i_subject} = t_tStart;
        endTrial_timestamps{i_subject} = t_tEnd;
    catch
        fprintf('no trial timestamp data available for %s \n', filesSubjects(i_subject).name);
        startTrial_timestamps{i_subject} = NaN;
        endTrial_timestamps{i_subject} = NaN;
    end
    
    %% Extract waves timestamps
    try
        % Start and end of the trials
        [t_wStart] = get_timestamps (logFile_name, 'WaveController', ...
            'Entering state Target');
        [t_wEnd] = get_timestamps (logFile_name, 'WaveController', ...
            'Entering state Waved');
        
        startWave_timestamps{i_subject} = t_wStart;
        endWave_timestamps{i_subject} = t_wEnd;        
        
        fprintf('%u and %u waving events timestamps found for %s \n', ...
            size(t_wStart, 1), size(t_wEnd, 1), ...
            filesSubjects(i_subject).name);
    catch
        fprintf('no wave timestamp data available for %s \n', ...
            filesSubjects(i_subject).name);
        startWave_timestamps{i_subject} = NaN;
        endWave_timestamps{i_subject} = NaN;
    end
    
end

preprocess.handp.positions = handp_trials;
preprocess.handp.timestamps = timestamps_trials;
preprocess.timestamps.trialStart = startTrial_timestamps;
preprocess.timestamps.trialEnd = endTrial_timestamps;
preprocess.timestamps.waveStart = startWave_timestamps;
preprocess.timestamps.waveEnd = endWave_timestamps;


save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\PreprocessData_Trajectories.mat', ...
    'preprocess');
