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
    
    order_ = orderArray(:, i_subject);
    
    for j = 1:nFilesResponses
        fileName = ...
            fullfile(questionnaireFolder, filesResponses(j).name);
              
        protocolID = fopen(fileName);
        table_ = textscan(protocolID, '%s %s');
        
        [responseArray] = getResponsesFromFile (table_)
    
        responseMat(:, order_(j)) = responseArray;
    end
    
    QuestionnaireData
    

    
end

end