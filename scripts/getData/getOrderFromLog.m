function [orderArray] = getOrderFromLog (dataDirectory)

% Common variables
gitDirectory = 'E:\GitHub\GenericExperimentMaster\Protocol';
filesSubjects = dir(fullfile(dataDirectory, 'pilot_num*'));

nSubjects = size(filesSubjects, 1);

orderArray = nan(4, nSubjects);

for i_subject = 1:nSubjects
    % subject folder
    subjectFolder = fullfile(dataDirectory, filesSubjects(i_subject).name, '\');
    fileName = filesSubjects(i_subject).name;
    
    fprintf('Reading data for %s\n', fileName);
    
    try
        % Log_File
        file_log = dir(fullfile(subjectFolder, '*.log'));
        fileName_log = fullfile(subjectFolder, file_log(1).name);
        
        fileID = fopen(fileName_log);
        table_ = textscan(fileID, '%q %q %q', 'Delimiter', '\t');
        
        protocol_number = strmatch('Protocol file', table_{1,3});
        txtFile = char(table_{1,3}(protocol_number));
        txt_ = strsplit(txtFile, '/');
        protocolName = char(txt_{1,3});
        
        fprintf('Protocol file %s\n', protocolName);
        
        protocolID = ...
            fopen(strcat(gitDirectory, '\', char(txt_{1,2}), '\', protocolName));
        table_ = textscan(protocolID, '%s %s %s %s %s %s %s %s %s %s');
        protocolOrder = str2num(char(table_{1,1}(2:5)));
        
        orderArray(:, i_subject) = protocolOrder;
    catch
        orderArray(:, i_subject) = nan;
    end
    
    save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\QuestionnaireOrder.mat', 'orderArray');
end

