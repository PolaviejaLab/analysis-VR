dataDirectory = 'V:\Data\06. ExpRep';

filesSubjects = dir(fullfile(dataDirectory, 'Subject*'));

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
        try
            fid = fopen(fullfile(unityFolder, ...
                trajectory_files(i_trial).name));
            traject_file = textscan(fid, '%s %q %f %f %f', 'Delimiter', ',');
            
            handp_subjTrial = [...
                traject_file{1, 3}, ...
                traject_file{1, 4}, ...
                traject_file{1, 5}];
            
            handp_trials{i_subject, i_trial} = handp_subjTrial;
            timestamps_trials{i_subject, i_trial} = traject_file{1, 1};
        catch
            handp_trials{i_subject, i_trial} = NaN;
            fprintf('no trajectory file for trial %u in subject %u \n', ...
                i_trial, i_subject);
            continue;
        end
    end
    save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\Data_Trajectories.mat', ...
        'handp_trials', 'timestamps_trials'); 
end