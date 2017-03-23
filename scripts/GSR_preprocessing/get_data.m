dataDirectory = ...
    'C:\Users\vbrugada\Google Drive\Data\Data_Frontiers_Exp1\';
filesSubjects = dir(fullfile(dataDirectory, 'Subject*'));

nSubjects = length(filesSubjects); % two subjects don't have GSR recordings
% file, array that will save the values. 

% for i_subj = 1:nSubjects
for i_subj = 1:1
    
    % define folders
    subjectFolder = fullfile(dataDirectory, filesSubjects(i_subj).name, '\');
    bonsaiFolder = fullfile(dataDirectory, filesSubjects(i_subj).name, '\Bonsai_Files\');
    name_ = filesSubjects(i_subj).name;
      
    % get bitalino data for the subject
    bit_file = dir(fullfile(bonsaiFolder, 'bitalino_valuemat*.bin'));
    if size(bit_file, 1) ~= 1      
        warning(strcat('Skipped bitalino data for ', name_));
        continue
    end
    bit_fileName = fullfile(bonsaiFolder, bit_file.name);
    
    % read the file 
    fid = fopen(bit_fileName);
    bit_valuemat = fread(fid);
    
    % correct for sampling rate
    bit_valuemat = bit_valuemat(1:1200:size(bit_valuemat, 1)); 
    
    % get the bitalino timestamps for i_subj
    bit_timestamps = ...
        dir(fullfile(bonsaiFolder, 'bitalino_timestamps*.csv'));
    if size(bit_timestamps, 1) ~= 1
        warning(strcat('Skipped bitalino_timestamps for ', name_));
        continue
    end
    bit_tsFileName = fullfile(bonsaiFolder, bit_timestamps.name);
    
    % read the timestamps file 
    fid = fopen(bit_tsFileName);
    bit_timestamps = textscan(fid, '%q');
  
    % get the timestamps - Entering threat following
    addpath('..\getData\');
    [tsThreat_] = get_timestamps(subjectFolder);
    
    % order timestamps
    [tsThreat] = order_data(tsThreat_, i_subj);
    
    
end
