% Load the data or run main. 
% This is only for the visuomotor informaiton. since the outcome ownership
% trials do not have the incongruent movement conditions. 

visuomotorInformationOrder = var.orderTrials.visuomotorInformation;



%% Get the participants depending on the order
% 1 - full arm - congruent 
% 2 - full arm - incongruent movement
% 3 - full arm - incongruent outcome
% 4 - full arm - incongruent

for i = 1:size(visuomotorInformationOrder, 2)
    for j = 1:size(visuomotorInformationOrder, 1)-1
        if visuomotorInformationOrder(j, i) == 1 && visuomotorInformationOrder(j+1, i) == 2
            var.orderTrials.congruentMovementFirst(i) = i;
        elseif visuomotorInformationOrder(j, i) == 2 && visuomotorInformationOrder(j+1, i) == 1
            var.orderTrials.incongruentMovementFirst(i) = i;
        end
    end
end

var.orderTrials.congruentMovementFirst = var.orderTrials.congruentMovementFirst(var.orderTrials.congruentMovementFirst ~= 0);
var.orderTrials.incongruentMovementFirst = var.orderTrials.incongruentMovementFirst(var.orderTrials.incongruentMovementFirst ~= 0);

%% Analyze the conditions
visuomotorInformationQuestionnaire = ...
    questionnaireData.preprocessed.visuomotorInformation;

questionnaireData.processed.ownership.congruentMovementFirst = [...
    squeeze(nanmean(squeeze(visuomotorInformationQuestionnaire(params.quest.owner, 1, var.orderTrials.congruentMovementFirst))));
    squeeze(nanmean(squeeze(visuomotorInformationQuestionnaire(params.quest.owner, 2, var.orderTrials.congruentMovementFirst))))];

questionnaireData.processed.ownership.incongruentMovementFirst = [...
    squeeze(nanmean(squeeze(visuomotorInformationQuestionnaire(params.quest.owner, 1, var.orderTrials.incongruentMovementFirst))));
    squeeze(nanmean(squeeze(visuomotorInformationQuestionnaire(params.quest.owner, 2, var.orderTrials.incongruentMovementFirst))))];


[results.ownership.visuomotor.congruentMovementFirst] = statisticsQuestionnaires(...
    questionnaireData.processed.ownership.congruentMovementFirst(1, :), ...
    questionnaireData.processed.ownership.congruentMovementFirst(2, :));

[results.ownership.visuomotor.incongruentMovementFirst] = statisticsQuestionnaires(...
    questionnaireData.processed.ownership.incongruentMovementFirst(1, :), ...
    questionnaireData.processed.ownership.incongruentMovementFirst(2, :));



questionnaireData.processed.agency.congruentMovementFirst = [...
    squeeze(nanmean(squeeze(visuomotorInformationQuestionnaire(params.quest.agenAction, 1, var.orderTrials.congruentMovementFirst))));
    squeeze(nanmean(squeeze(visuomotorInformationQuestionnaire(params.quest.agenAction, 2, var.orderTrials.congruentMovementFirst))))];

questionnaireData.processed.agency.incongruentMovementFirst = [...
    squeeze(nanmean(squeeze(visuomotorInformationQuestionnaire(params.quest.agenAction, 1, var.orderTrials.incongruentMovementFirst))));
    squeeze(nanmean(squeeze(visuomotorInformationQuestionnaire(params.quest.agenAction, 2, var.orderTrials.incongruentMovementFirst))))];


[results.agency.visuomotor.congruentMovementFirst] = statisticsQuestionnaires(...
    questionnaireData.processed.agency.congruentMovementFirst(1, :), ...
    questionnaireData.processed.agency.congruentMovementFirst(2, :));

[results.agency.visuomotor.incongruentMovementFirst] = statisticsQuestionnaires(...
    questionnaireData.processed.agency.incongruentMovementFirst(1, :), ...
    questionnaireData.processed.agency.incongruentMovementFirst(2, :));


questionnaireData.processed.outcome.congruentMovementFirst = [...
    squeeze(nanmean(squeeze(visuomotorInformationQuestionnaire(params.quest.agenOutcome, 1, var.orderTrials.congruentMovementFirst))));
    squeeze(nanmean(squeeze(visuomotorInformationQuestionnaire(params.quest.agenOutcome, 2, var.orderTrials.congruentMovementFirst))))];

questionnaireData.processed.outcome.incongruentMovementFirst = [...
    squeeze(nanmean(squeeze(visuomotorInformationQuestionnaire(params.quest.agenOutcome, 1, var.orderTrials.incongruentMovementFirst))));
    squeeze(nanmean(squeeze(visuomotorInformationQuestionnaire(params.quest.agenOutcome, 2, var.orderTrials.incongruentMovementFirst))))];


[results.outcome.visuomotor.congruentMovementFirst] = statisticsQuestionnaires(...
    questionnaireData.processed.outcome.congruentMovementFirst(1, :), ...
    questionnaireData.processed.outcome.congruentMovementFirst(2, :));

[results.outcome.visuomotor.incongruentMovementFirst] = statisticsQuestionnaires(...
    questionnaireData.processed.outcome.incongruentMovementFirst(1, :), ...
    questionnaireData.processed.outcome.incongruentMovementFirst(2, :));


