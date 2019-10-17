function [trialInformation, waves] = GetVariablesFromTrials ...
    (params, experimentType, subjectData, orderTrials)

for i = 1:subjectData.nParticipants
    filesVariables = dir(fullfile(params.dataDirectory, ...
        experimentType, subjectData.subjectID{i}, 'Trials', '*.csv'));
    
    nFilesVariables = length(filesVariables);
    
    for j = 1:nFilesVariables
        
        fileName = ...
            fullfile(params.dataDirectory, experimentType, ...
            subjectData.subjectID{i}, 'Trials', filesVariables(j).name);
         
        variablesID = fopen(fileName);
        
        table_(orderTrials(j, i), :) = ...
            textscan(variablesID, ...
            '%u %s %s %s %s %s %u32 %f %d32 %d32 %d32 %d32', ...
            'Delimiter', ',');
        fclose(variablesID);
    end
    
    trialInformation{i, :} = table_;
    
    waves.correctWaves(:, i) = ...
        cell2mat(table_(:, params.trialInformation.correctWaves));
    waves.incorrectWaves(:, i) = ...
        cell2mat(table_(:, params.trialInformation.incorrectWaves)) + ...
        cell2mat(table_(:, params.trialInformation.lateWaves));
    
end

end