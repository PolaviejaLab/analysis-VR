function [processedData] = processGSR (preprocessedData, participants, var)


orderVisuomotorInformation = ...
    var.orderTrials.visuomotorInformation(:, participants.usedGSR);
orderOutcomeOwnership = ...
    var.orderTrials.outcomeOwnership(:, participants.usedGSR);

for i = 1:size(preprocessedData.GSR, 1)
    for j = 1:size(preprocessedData.GSR, 2)
        
        if j == 1 % Visumotor Information
            timestampsLog = preprocessedData.timestampsLog{i, j};
            
            [timestampsLog_ordered] = orderTimestamps ...
                (timestampsLog, orderVisuomotorInformation(:, i));
            
            if isempty(preprocessedData.timestamps{i, j})
                processedData.GSR.visuomotorInformation{j, i} = [];
                break,
            else
                for k = 1:size(timestampsLog_ordered, 1)
                    ind_timestampsGSR(k, :) = findTimestamps (...
                        timestampsLog_ordered(k, :), ...
                        preprocessedData.timestamps{i, j});
                    
                    gsr_mat{k, :} = preprocessedData.GSR{i, j}...
                        (cell2mat(ind_timestampsGSR(k, 1)):cell2mat(ind_timestampsGSR(k, 2)));
                end
                processedData.GSR.visuomotorInformation{i} = gsr_mat;
            end
            
        elseif j == 2 % Outcome Ownership
            timestampsLog = preprocessedData.timestampsLog{i, j};
            
            [timestampsLog_ordered] = orderTimestamps ...
                (timestampsLog, orderOutcomeOwnership(:, i));
            
            if isempty(preprocessedData.timestamps{i, j})
                processedData.GSR.outcomeOwnership{j, i} = [];
                break,
            else
                for k = 1:size(timestampsLog_ordered, 1)
                    ind_timestampsGSR(k, :) = findTimestamps (...
                        timestampsLog_ordered(k, :), ...
                        preprocessedData.timestamps{i, j});
                    
                    gsr_mat{k, :} = preprocessedData.GSR{i, j}...
                        (cell2mat(ind_timestampsGSR(k, 1)):cell2mat(ind_timestampsGSR(k, 2)));
                end
                processedData.GSR.outcomeOwnership{i} = gsr_mat;
            end
            
        end
        
    end
end
end