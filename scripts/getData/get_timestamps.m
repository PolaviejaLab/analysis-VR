function [ts_array] = get_timestamps (subjectFolder)
% GET_TIMESTAMPS outputs an array of the timestamps of start and end of
% each of the session

unityFiles = fullfile(subjectFolder, 'Unity_Files\');
logFile = dir(fullfile(unityFiles, '*.log'));

fid = fopen(fullfile(unityFiles, logFile(1).name));
mat_ = textscan(fid, '%s %s %s', 'Delimiter', '\t');

indx_ts = find(strcmp(mat_{3}, 'Entering state Following'))';

ts_array = mat_{1}(indx_ts);

end