function [responses, order_matrix] = GetDataFromQuestionnaires ...
    (dataDirectory, experimentType, participants)

for iParticipant = 1:size(participants, 1)
    
    filesResponses = dir(fullfile(dataDirectory, experimentType, ...
        participants{iParticipant}, 'Responses Trial*'));
    nFilesResponses = length(filesResponses);
    
    % orderArray for an individual    
    order_ = getOrderFromLog(dataDirectory, experimentType, ...
        participants{iParticipant});
    order_matrix(:, iParticipant) = order_;
    
    if (isnan(order_(1)))
        warning('Could not order participant %s, skipping responses', ...
            participants{iParticipant});
        responses(:, :, iParticipant) = nan(20, 4);
        continue, 
    end
        
    for j = 1:nFilesResponses
        fileName = ...
            fullfile(dataDirectory, experimentType, ...
            participants{iParticipant}, filesResponses(j).name);
        
        responsesID = fopen(fileName);
        table_ = textscan(responsesID, '%s %s');
        
        [responseArray] = getResponsesFromFile (table_);
        
        responseMat(:, order_(j)) = responseArray;
    end
    
    responses(:, :, iParticipant) = responseMat;
    
end

fclose('all');
end