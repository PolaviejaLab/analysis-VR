function [QuestionnaireData] = GetDataFromQuestionnaires (dataDirectory)

orderArray = getOrderFromLog(dataDirectory);

filesSubjects = dir(fullfile(dataDirectory, 'pilot_num*'));
nSubjects = length(filesSubjects);

for i_subject = 1:nSubjects
    % subject folder
    questionnaireFolder = fullfile(dataDirectory, filesSubjects(i_subject).name, '\Questionnaires\');
    
    % get questionnaire file
    filesResponses = dir(fullfile(questionnaireFolder, 'Responses Trial*.csv'));
    nFilesResponses = length(filesResponses);
    
    
    for j = 1:nFilesResponses
        fileName = ...
            fullfile(questionnaireFolder, filesResponses(j).name);
        responseTable = csvread(fileName);
        
    end
    
    
    
    
    
    
    
    order_ = orderArray(:, i_subject);
    
    responseTable = [responseTable(:, order_(1:2)), responseTable(:,3)];
    dynamic_table = [dynamic_table(:, order_(3:4)-2), dynamic_table(:,3)];
    
    static_array(:,:, i_subject) = responseTable;
    dynamic_array(:,:, i_subject) = dynamic_table;
    
end
QuestionnaireData.static = static_array;
QuestionnaireData.dynamic = dynamic_array;

end