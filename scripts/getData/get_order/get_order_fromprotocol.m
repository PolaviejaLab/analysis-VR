function [order] = get_order_fromprotocol (unityFolder)

gitFolder = 'E:\GitHub\Victoria-Discontinuity\';

% get number of protocol from the log file
file_log = dir(fullfile(unityFolder, '*.log'));
fileName_log = fullfile(unityFolder, file_log.name);

fid = fopen(fileName_log);
m_ = textscan(fid, '%q %s %s', 'Delimiter', '\t');
indx = strmatch('Protocol file', m_{3});

str_ = strsplit(char(m_{3}(indx)));
file = str_{3}

protocol_file = fullfile(gitFolder, file);

fid =protocol_file;

[~, ~, order] = tblread(fid);

end

