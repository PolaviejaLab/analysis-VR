function [static_array, dynamic_array] = get_data (order)

dataDirectory = 'V:\Data\05. Experiment2_PilotsOfNoise';

filesSubjects = dir(fullfile(dataDirectory, 'Subject*'));

% declare variables
nSubjects = length(filesSubjects);

static_array = zeros (8, 2, nSubjects);     % 2 static conditions
dynamic_array = zeros (14, 7, nSubjects);   % 7 dynamic conditions

for i_s = 1:1 %nSubjects
    
    % folders
    subjectFolder = fullfile(dataDirectory, filesSubjects(i_s).name, '\');
    questionnaireFolder = fullfile(subjectFolder, '\Questionnaires\');
    unityFolder = fullfile(subjectFolder, '\UnityFiles\');
    
    % get questionnaire file
    files_static = dir(fullfile(questionnaireFolder, 'staticblock.csv'));
    files_dynamic = dir(fullfile(questionnaireFolder, 'dynamicblock.csv'));
    
    fileName_static = fullfile(questionnaireFolder, files_static(1).name);
    fileName_dynamic = fullfile(questionnaireFolder, files_dynamic(1).name);
    
    m_static = csvread(fileName_static);
    m_dynamic = csvread(fileName_dynamic);
    
    % get order
    addpath('get_order');
    [order] = get_order_fromprotocol(unityFolder);
%     
%     % order tables
%     m_static = m_static(order(:, 1:2));
%     m_dynamic = m_dynamic(order(:, 4:10));
%     
%     static_array(:, :, i_s) = m_static;
%     dynamic_array(:, :, i_s) = m_dynamic;
%     
end

end
