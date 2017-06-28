%% Common variables
dataDirectory = 'V:\Data\05. Experiment2_PilotsOfNoise';
gitDirectory = 'E:\GitHub\Victoria-Discontinuity\'
filesSubjects = dir(fullfile(dataDirectory, 'Subject*'));

n_subjects = size(filesSubjects, 1);

orderMatrix = nan(10, n_subjects);
%%

for i_subject = 1:n_subjects
    % subject folder
    subjectFolder = fullfile(dataDirectory, filesSubjects(i_subject).name, '\');
    
    fileName = filesSubjects(i_subject).name;
    
    fprintf('Reading data for %s\n', fileName);
    
    unityFolder = fullfile(dataDirectory, filesSubjects(i_subject).name, '\Unity_Files\');
    
    try
        % Log_File
        file_log = dir(fullfile(unityFolder, '*.log'));
        fileName_log = fullfile(unityFolder, file_log(1).name);
        
        fileID = fopen(fileName_log);
        table_ = textscan(fileID, '%q %q %q', 'Delimiter', '\t');
        
        protocol_number = strmatch('Protocol file', table_{1,3});
        txtFile = char(table_{1,3}(protocol_number));
        txt_ = strsplit(txtFile);
        protocolName = char(txt_{1,3});
        
        fprintf('Protocol file %s\n', protocolName);
        
        protocolID = fopen(strcat(gitDirectory, protocolName));
        table_ = textscan(protocolID, '%s %s %s %s %s %s %s %s %s %s %s %s');
        protocolOrder = str2num(char(table_{1,1}(2:11)));
        
        orderMatrix(:, i_subject) = protocolOrder;
    catch
        orderMatrix(:, i_subject) = nan;
    end
end
save('E:\GitHub\analysis-VR\data\Exp_PilotsNoise\order.mat', 'orderMatrix');