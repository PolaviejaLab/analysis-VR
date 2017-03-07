function [indx] = get_order_fromprotocol (unityFolder)

% get number of protocol from the log file
file_log = dir(fullfile(unityFolder, '*.log'));
fileName_log = fullfile(unityFolder, file_log.name);

fid = fopen(fileName_log);
m_ = textscan(fid, '%q %s %s');
indx = strcmp('Protocol file*', m_{3});



% get the number of trial 
% fid = '\GitHub\Victoria-Discontinuity\Protocol\Exp2_Experiment\prueba_77.txt'

% [~, ~, order] = tblread(fid);
% order = str2double(order)';
end

