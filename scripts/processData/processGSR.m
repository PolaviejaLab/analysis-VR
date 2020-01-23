function [processedData] = processGSR (preprocessedData, participants, var)


order_blockA = ...
    var.orderTrials.visuomotorInformation(:, participants);
order_blockB = ...
    var.orderTrials.outcomeOwnership(:, participants);

for i = 1:size(preprocessedData.GSR, 1)
    for j = 1:size(preprocessedData.GSR, 2)
        
        if j == 1 % Block A
            
            timestampsLog = preprocessedData.timestampsLog{i, j};
            
            [timestampsLog_ordered] = orderTimestamps ...
                (timestampsLog, order_blockA(:, i));
            
            if isempty(preprocessedData.timestamps{i, j})
                processedData.blockA{j, i} = [];
                break,
            else
                for k = 1:size(timestampsLog_ordered, 1)
                    ind_timestampsGSR(k, :) = findTimestamps (...
                        timestampsLog_ordered(k, :), ...
                        preprocessedData.timestamps{i, j});
                    
                    gsr_mat{k, :} = preprocessedData.GSR{i, j}...
                        (cell2mat(ind_timestampsGSR(k, 1)):cell2mat(ind_timestampsGSR(k, 2)));
                end
                processedData.blockA{i} = gsr_mat;
            end
            
        elseif j == 2 % Block A
            timestampsLog = preprocessedData.timestampsLog{i, j};
            
            [timestampsLog_ordered] = orderTimestamps ...
                (timestampsLog, order_blockB(:, i));
            
            if isempty(preprocessedData.timestamps{i, j})
                processedData.blockB{j, i} = [];
                break,
            else
                for k = 1:size(timestampsLog_ordered, 1)
                    ind_timestampsGSR(k, :) = findTimestamps (...
                        timestampsLog_ordered(k, :), ...
                        preprocessedData.timestamps{i, j});
                    
                    gsr_mat{k, :} = preprocessedData.GSR{i, j}...
                        (cell2mat(ind_timestampsGSR(k, 1)):cell2mat(ind_timestampsGSR(k, 2)));
                end
                processedData.blockB{i} = gsr_mat;
            end
            
        end
        
    end
end
end