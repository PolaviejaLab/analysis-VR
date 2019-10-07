%%
addpath('extractData');
addpath('figures');
addpath('analyzeData/questionnaires');

%% Find variables 
% This file should be modified with the parameters of each experiment
[params] = GetParameters();


%% Extract Raw Data
[subjectData] = extractSociodemographics (params, 'sociodemographics.txt');

[questionnaireData.preprocessed, var] = extractQuestionnaires(params, subjectData);

save(strcat(params.dataDirectory, '\Results\subjectData'), 'subjectData');
save(strcat(params.dataDirectory, '\Results\preprocessedQuestionnaires.mat'), ...
    'questionnaireData');

%% Process Data
questionnaireData.processed.owner.visuomotor = ...
    squeeze(nanmean(squeeze(questionnaireData.preprocessed.visuomotorInformation(params.quest.owner, :, :))));
questionnaireData.processed.ownerC.visuomotor = ...
    squeeze(nanmean(squeeze(questionnaireData.preprocessed.visuomotorInformation(params.quest.ownerCnt, :, :))));
questionnaireData.processed.owner.outcome = ...
    squeeze(nanmean(squeeze(questionnaireData.preprocessed.outcomeOwnership(params.quest.owner, :, :))));
questionnaireData.processed.ownerC.outcome = ...
    squeeze(nanmean(squeeze(questionnaireData.preprocessed.outcomeOwnership(params.quest.ownerCnt, :, :))));

questionnaireData.processed.agency.visuomotor = ...
    squeeze(nanmean(squeeze(questionnaireData.preprocessed.visuomotorInformation(params.quest.agenAction, :, :))));
questionnaireData.processed.agencyC.visuomotor = ...
    squeeze(nanmean(squeeze(questionnaireData.preprocessed.visuomotorInformation(params.quest.agenActionCnt, :, :))));
questionnaireData.processed.agency.outcome = ...
    squeeze(nanmean(squeeze(questionnaireData.preprocessed.outcomeOwnership(params.quest.agenAction, :, :))));
questionnaireData.processed.agencyC.outcome = ...
    squeeze(nanmean(squeeze(questionnaireData.preprocessed.outcomeOwnership(params.quest.agenActionCnt, :, :))));

questionnaireData.processed.outcome.visuomotor = ...
    squeeze(nanmean(squeeze(questionnaireData.preprocessed.visuomotorInformation(params.quest.agenOutcome, :, :))));
questionnaireData.processed.outcomeC.visuomotor = ...
    squeeze(nanmean(squeeze(questionnaireData.preprocessed.visuomotorInformation(params.quest.agenOutcomeCnt, :, :))));
questionnaireData.processed.outcome.outcome = ...
    squeeze(nanmean(squeeze(questionnaireData.preprocessed.outcomeOwnership(params.quest.agenOutcome, :, :))));
questionnaireData.processed.outcomeC.outcome = ...
    squeeze(nanmean(squeeze(questionnaireData.preprocessed.outcomeOwnership(params.quest.agenOutcomeCnt, :, :))));

questionnaireData.processed.similarity.visuomotor = ...
    squeeze(nanmean(squeeze(questionnaireData.preprocessed.visuomotorInformation(params.quest.similar, :, :))));
questionnaireData.processed.similarity.outcome = ...
    squeeze(nanmean(squeeze(questionnaireData.preprocessed.outcomeOwnership(params.quest.similar, :, :))));

questionnaireData.processed.location.visuomotor = ...
    squeeze(nanmean(squeeze(questionnaireData.preprocessed.visuomotorInformation(params.quest.location, :, :))));
questionnaireData.processed.location.outcome = ...
    squeeze(nanmean(squeeze(questionnaireData.preprocessed.outcomeOwnership(params.quest.location, :, :))));


save(strcat(params.dataDirectory, '\Results\preprocessedQuestionnaires.mat'), ...
    'questionnaireData');

%% 


% mean, medians, std, and normality distribution. 
questionnaireData.results.ownership.visuomotor = ...
    data_results(questionnaireData.processed.owner.visuomotor); 

questionnaireData.results.ownership.outcome = ...
    data_results(questionnaireData.processed.owner.outcome);

questionnaireData.results.agency.visuomotor = ...
    data_results(questionnaireData.processed.agency.visuomotor);

questionnaireData.results.agency.outcome = ...
    data_results(questionnaireData.processed.agency.outcome);

questionnaireData.results.outcome.visuomotor = ...
    data_results(questionnaireData.processed.outcome.visuomotor);

questionnaireData.results.outcome.outcome = ...
    data_results(questionnaireData.processed.outcome.outcome);


% Friedman



% Control Statements
[questionnaireData.results.control_statements] = ...
    controlStatements(questionnaireData.processed);

% Pairwise 
[questionnaireData.results.pairwise] = ... 
    pairwiseComparisons (questionnaireData.processed);


%% GSR

GSRData.preprocessed = ...
    extractGSR (params, subjectData, subjectData.subjectID);
 
% GSRData.processed = processGSR (params, GSRData, subjectData, var);
% 
% 







%%


% %% Plot
% 
% load(strcat(params.dataDirectory, '\Results\preprocessedQuestionnaires.mat'));
% 
% 
% fig1 = figure(1);
% set(fig1, 'units', 'centimeters', 'position', [5 5 10.0 15.0]);
% plotBoxplots(questionnaireData.processed.owner.visuomotor, ...
%     'Visuomotor Information - Sense of ownership');
% 
% 







