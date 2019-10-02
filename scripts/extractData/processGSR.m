function [processedData, var] = processGSR (params, preprocessedData, participants, var)


var.orderGSR.visuomotorInformation = ...
    var.orderTrials.visuomotorInformation(:, participants.usedGSR);
var.orderGSR.outcomeOwnership = ...
    var.orderTrials.outcomeOwnership(:, participants.usedGSR);

for i = 1:size(preprocessedData.preprocessed.GSR, 2)
    
    
    
    
    %% Crop the trials
    params.tags.Event.Start;
    params.tags.Event.trialEnd;
    
    getTimestampsFromLog()
    
end


%
%     
%
%     get the timestamps - Entering threat following
%     addpath('..\getData\');
%     [tsThreat_] = get_timestamps(subjectFolder);
%
%     order timestamps
%     [tsThreat] = order_data(tsThreat_, i_subj);




end