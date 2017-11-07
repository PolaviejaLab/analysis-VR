addpath('..\readFiles');

dataDirectory = 'V:\Data\04. Exp1_Frontiers\';

subjectFolder = dir(fullfile(dataDirectory, 'Subject*'));
nSubjects = length(subjectFolder);

load('V:\Data\04. Exp1_Frontiers\type_trial_participant.txt');
% Transform the order
type_trial_participant = orderFromTxt(type_trial_participant);


for i_subject = 1:nSubjects
    
    fprintf('Data for subject %s \n', subjectFolder(i_subject).name);
    
    subjectNum = str2num(subjectFolder(i_subject).name(8:9));
    
    % Subject Folders
    bonsaiFolder = fullfile(dataDirectory, subjectFolder(i_subject).name, '\Bonsai_Files\');
    unityFolder = fullfile(dataDirectory, subjectFolder(i_subject).name, '\Unity_Files\');
    
    % Get the GSR raw data from the .bin file
    mat_file = dir(fullfile(bonsaiFolder, '*.bin'));
    fileName = fopen(fullfile(bonsaiFolder, mat_file.name));
    
    try
        mat_values = fread(fileName);
        mat_values = mat_values(1:1200:end);
    catch
        error('Failed to read log file for subject %s', subjectFolder(i_subject).name);
    end
    
    % Get Timestamps from Log
    ts_file = dir(fullfile(bonsaiFolder, 'bitalino_timestamps*'));
    
    log_file = dir(fullfile(unityFolder, '*.log'));
    
    % get timestamps
        [startTS] = getTimestampsFromLog(fullfile(unityFolder, log_file.name),...
            'Entering state Trial');
        [endTS] = getTimestampsFromLog(fullfile(unityFolder, log_file.name),...
            'Event TrialFinished');
    [stimulusTS] = getTimestampsFromLog(fullfile(unityFolder, log_file.name), ...
        'Entering state Falling');
    
    % Get Position in the .bin file
        [i_start] = getIndexBinFile (fullfile(bonsaiFolder, ts_file.name), startTS);
        [i_end] = getIndexBinFile (fullfile(bonsaiFolder, ts_file.name), endTS);
    [i_stimulus] = getIndexBinFile(fullfile(bonsaiFolder, ts_file.name), stimulusTS);
    
        i_start = unique(i_start); i_end = unique(i_end);
    i_stimulus = unique(i_stimulus);
     
    
    
    % Get GSRvalues
    for i_trial = 1:numel(i_stimulus)
        GSR_stim(type_trial_participant(1, i_trial+3)-3).([subjectFolder(i_subject).name]) = ...
            mat_values((i_stimulus(i_trial)-49):(i_stimulus(i_trial)+50));
    end 
   
    
    
    substractedValue = (min(i_start)) -1; % this value will need to be substracted
%     % so that it does not misaligned now that the mat_values is cut
%     
%     % Cut the bin file to adapt it to the end and begging of the experiment
    mat_values = mat_values(min(i_start):max(i_end));
%     
%     % Recalculate all values
    i_start = i_start - substractedValue;
    i_end = i_end - substractedValue;
    
    % Check whether there is an extra number
    if (numel(i_start) > 8)
        [i_start] = removeCloseNumbers (i_start);
    end
    
    if (numel(i_end) > 8)
        [i_end] = removeCloseNumbers (i_end);
    end
    
%     % Separate trials
    for i_trial = 1:numel(i_start)
        fprintf('Reading trial %u: ', i_trial);
        try
            GSRstruct(type_trial_participant(1, i_trial)).([subjectFolder(i_subject).name]) = mat_values(i_start(i_trial):i_end(i_trial));
            fprintf('trial read successfully \n');
        catch
            GSRstruct(type_trial_participant(1, i_trial)).([subjectFolder(i_subject).name]) = [];
            warning('Failed to read trial');
        end
    end
    
% 
end