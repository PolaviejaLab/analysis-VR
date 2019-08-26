function [orderArray] = getOrderFromLog (dataDirectory, experimentType, participant)

gitDirectory = strcat('E:\GitHub\GenericExperimentMaster\Protocol', ...
    experimentType);
subjectFiles = dir(fullfile(dataDirectory, experimentType, participant));

orderArray = nan(4, 1);

try
    % Log File
    file_log = dir(fullfile(dataDirectory, experimentType, participant, '*.log'));
    fileName_log = fullfile(file_log(1).name);
    fileID = fopen(fullfile(dataDirectory, experimentType, participant, fileName_log));
    table_ = textscan(fileID, '%q %q %q', 'Delimiter', '\t');
    
    protocol_number = strmatch('Protocol file', table_{1,3});
    txtFile = char(table_{1,3}(protocol_number));
    txt_ = strsplit(txtFile, '/');
    protocolName = char(txt_{1,3});
    fclose(fileID);
catch
    warning('No Protocol File found for Participant %s', participant);
    orderArray = NaN;
    return, 
end


protocolID = ...
    fopen(strcat(gitDirectory, '\', protocolName));
table_ = textscan(protocolID, '%s %s %s %s %s %s %s %s %s %s');
orderArray = str2num(char(table_{1,1}(2:5)));

end

