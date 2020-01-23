%%
addpath('extractData');
addpath('figures');
addpath('analyzeData/questionnaires');
addpath('processData');

%% Find variables 
% This file should be modified with the parameters of each experiment
[params] = GetParameters();


%% Extract Questionnaire Data
[subjectData] = extractSociodemcloographics (params, 'sociodemographics.txt');

[questionnaireData.preprocessed, var] = extractQuestionnaires(params, subjectData);

save(strcat(params.dataDirectory, '\Results\subjectData'), 'subjectData');
save(strcat(params.dataDirectory, '\Results\preprocessedQuestionnaires.mat'), ...
    'questionnaireData');

%% Extract GSR Data
GSRData.preprocessed = ...
    extractGSR (params, subjectData, subjectData.subjectID);

GSRData.processed = ...
    processGSR(GSRData.preprocessed, subjectData.usedGSR, var);


%% Extract Raw data for the .csv files
[var.trialInformation, var.waves] = extractVariables (params, subjectData, var);


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
results.questionnaireData.ownership.visuomotor = ...
    data_results(questionnaireData.processed.owner.visuomotor); 

results.questionnaireData.ownership.outcome = ...
    data_results(questionnaireData.processed.owner.outcome);

results.questionnaireData.agency.visuomotor = ...
    data_results(questionnaireData.processed.agency.visuomotor);

results.questionnaireData.agency.outcome = ...
    data_results(questionnaireData.processed.agency.outcome);

results.questionnaireData.outcome.visuomotor = ...
    data_results(questionnaireData.processed.outcome.visuomotor);

results.questionnaireData.outcome.outcome = ...
    data_results(questionnaireData.processed.outcome.outcome);


% Friedman



% Control Statements
[results.questionnaireData.control_statements] = ...
    controlStatements(questionnaireData.processed);

% Pairwise 
[results.questionnaireData.pairwiseComparisons] = ... 
    pairwiseComparisons (questionnaireData.processed);


%% Questionnaires by errors

% median, mean, range
results.waves.visuomotorInformation.incongruentOutcome = [...
    mean(var.waves.visuomotorInformation.incorrectWaves(3, :)), ...
    median(var.waves.visuomotorInformation.incorrectWaves(3, :)), ...
    min(var.waves.visuomotorInformation.incorrectWaves(3, :)), ...
    max(var.waves.visuomotorInformation.incorrectWaves(3, :)), ...
    ];

results.waves.visuomotorInformation.incongruent = [...
    mean(var.waves.visuomotorInformation.incorrectWaves(4, :)), ...
    median(var.waves.visuomotorInformation.incorrectWaves(4, :)), ...
    min(var.waves.visuomotorInformation.incorrectWaves(4, :)), ...
    max(var.waves.visuomotorInformation.incorrectWaves(4, :))];

results.waves.outcomeOwnership.incongruentOutcome = [...
    mean(var.waves.outcomeOwnership.incorrectWaves(3, :)), ...
    median(var.waves.outcomeOwnership.incorrectWaves(3, :)), ...
    min(var.waves.outcomeOwnership.incorrectWaves(3, :)), ...
    max(var.waves.outcomeOwnership.incorrectWaves(3, :))];

results.waves.outcomeOwnership.incongruent = [...
    mean(var.waves.outcomeOwnership.incorrectWaves(4, :)), ...
    median(var.waves.outcomeOwnership.incorrectWaves(4, :)), ...
    min(var.waves.outcomeOwnership.incorrectWaves(4, :)), ...
    max(var.waves.outcomeOwnership.incorrectWaves(4, :))];

figure,
plot(double(var.waves.visuomotorInformation.incorrectWaves(3, :))./30, ...
    questionnaireData.processed.outcome.visuomotor(3, :), ...
    'ok'); lsline;
ylim([0.5 7.5]); xlim([0 1]); 
xlabel('incorrect waves/total waves');
ylabel('Likert scale');

[results.correlationWaves.visuomotorInformation.incongruentOutcome(1), ...
    results.correlationWaves.visuomotorInformation.incongruentOutcome(2)] = corr(...
    (double(var.waves.visuomotorInformation.incorrectWaves(3, :))./30)', ...
    questionnaireData.processed.outcome.visuomotor(3, :)', 'Type', 'Spearman');


figure,
plot(double(var.waves.visuomotorInformation.incorrectWaves(4, :))./30, ...
    questionnaireData.processed.outcome.visuomotor(4, :), ...
    'og'); lsline;
ylim([0.5 7.5]); xlim([0 1]);

[results.correlationWaves.visuomotorInformation.incongruent(1), ...
    results.correlationWaves.visuomotorInformation.incongruent(2)] = corr(...
    (double(var.waves.visuomotorInformation.incorrectWaves(4, :))/30)', ...
    questionnaireData.processed.outcome.visuomotor(4, :)', 'Type', 'Spearman');

figure, 
plot(double(var.waves.outcomeOwnership.incorrectWaves(3, :))./30, ...
    questionnaireData.processed.outcome.outcome(3, :), ...
    'or'); lsline;
ylim([0.5 7.5]); xlim([0 1]);
xlabel('incorrect waves/total waves');
ylabel('Likert scale');

[results.correlationWaves.outcomeOwnership.incongruentOutcome(1), ...
    results.correlationWaves.outcomeOwnership.incongruentOutcome(2)] = corr(...
    (double(var.waves.outcomeOwnership.incorrectWaves(3, :))/30)', ...
    questionnaireData.processed.outcome.outcome(3, :)', 'Type', 'Spearman');

figure,
plot(double(var.waves.outcomeOwnership.incorrectWaves(4, :))./30, ...
    questionnaireData.processed.outcome.outcome(4, :), ...
    'ok');
ylim([0.5 7.5]); xlim([0 1]);

[results.correlationWaves.outcomeOwnership.incongruent(1), ...
    results.correlationWaves.outcomeOwnership.incongruent(2)] = corr(...
    (double(var.waves.outcomeOwnership.incorrectWaves(4, :))./30)', ...
    questionnaireData.processed.outcome.outcome(4, :)', 'Type', 'Spearman');


% with ownership
figure, 
plot(double(var.waves.visuomotorInformation.incorrectWaves(3, :))./30, ...
    questionnaireData.processed.owner.visuomotor(3, :), ...
    'ok');
ylim([0.5 7.5]); xlim([0 1]);
xlabel('incorrect_waves / total_waves');

[results.correlationWaves.visuomotorInformation.incongruentOutcomeOwnership(1), ...
    results.correlationWaves.visuomotorInformation.incongruentOutcomeOwnership(2)] = corr(...
    (double(var.waves.visuomotorInformation.incorrectWaves(3, :))./30)', ...
    questionnaireData.processed.owner.visuomotor(3, :)', 'Type', 'Spearman');


figure, 
plot(double(var.waves.outcomeOwnership.incorrectWaves(3, :))./30, ...
    questionnaireData.processed.owner.visuomotor(3, :), ...
    'ok');
ylim([0.5 7.5]); xlim([0 1]);
xlabel('incorrect waves / total waves');

[results.correlationWaves.outcomeOwnership.incongruentOutcomeOwnership(1), ...
    results.correlationWaves.outcomeOwnership.incongruentOutcomeOwnership(2)] = corr(...
    (double(var.waves.outcomeOwnership.incorrectWaves(3, :))./30)', ...
    questionnaireData.processed.owner.outcome(3, :)', 'Type', 'Spearman');



%% Correlation differences

diffoutcomeA = questionnaireData.processed.outcome.visuomotor(1, :) - questionnaireData.processed.outcome.visuomotor(3, :);
diffagenA = questionnaireData.processed.agency.visuomotor(1, :) - questionnaireData.processed.agency.visuomotor(3, :);
diffownerA = questionnaireData.processed.owner.visuomotor(1, :) - questionnaireData.processed.owner.visuomotor(3, :);

diffoutcomeB = questionnaireData.processed.outcome.outcome(1, :) - questionnaireData.processed.outcome.outcome(3, :);
diffagenB = questionnaireData.processed.agency.outcome(1, :) - questionnaireData.processed.agency.outcome(3, :);
diffownerB = questionnaireData.processed.owner.outcome(1, :) - questionnaireData.processed.owner.outcome(3, :);

[a, b] = corr(diffownerA', diffoutcomeA', 'Type', 'Spearman');
figure,
plotCorrelationDifference(diffownerA', diffoutcomeA', a, b);

[a, b] = corr(diffownerB', diffoutcomeB', 'Type', 'Spearman');
figure,
plotCorrelationDifference(diffownerB', diffoutcomeB', a, b);


[a, b] = corr(diffagenA', diffoutcomeA', 'Type', 'Spearman');
figure,
plotCorrelationDifference(diffagenA', diffoutcomeA', a, b);

[a, b] = corr(diffagenB', diffoutcomeB', 'Type', 'Spearman');
figure,
plotCorrelationDifference(diffagenB', diffoutcomeB', a, b);


[a, b] = corr(diffownerA', diffagenB', 'Type', 'Spearman');
figure,
plotCorrelationDifference(diffownerA', diffagenA', a, b);

[a, b] = corr(diffownerB', diffagenB', 'Type', 'Spearman');
figure,
plotCorrelationDifference(diffownerB', diffagenB', a, b);




diffagenA = questionnaireData.processed.agency.visuomotor(1, :) - questionnaireData.processed.agency.visuomotor(2, :)
diffownerA = questionnaireData.processed.owner.visuomotor(1, :) - questionnaireData.processed.owner.visuomotor(2, :)
[a, b] = corr(diffownerA', diffagenA', 'Type', 'Spearman')
figure,
plotCorrelationDifference(diffownerA', diffagenA', a, b);


diffagenB = questionnaireData.processed.agency.outcome(1, :) - questionnaireData.processed.agency.outcome(2, :)
diffownerB = questionnaireData.processed.owner.outcome(1, :) - questionnaireData.processed.owner.outcome(2, :)
[a, b] = corr(diffownerB', diffagenB', 'Type', 'Spearman')
figure,
plotCorrelationDifference(diffownerB', diffagenB', a, b);

diffoutcomeA = questionnaireData.processed.outcome.visuomotor(1, :) - questionnaireData.processed.outcome.visuomotor(2, :)
diffoutcomeB = questionnaireData.processed.outcome.outcome(1, :) - questionnaireData.processed.outcome.outcome(2, :)

[a, b] = corr(diffownerA', diffoutcomeA', 'Type', 'Spearman');
figure,
plotCorrelationDifference(diffownerA', diffoutcomeA', a, b);

[a, b] = corr(diffownerB', diffoutcomeB', 'Type', 'Spearman');
figure,
plotCorrelationDifference(diffownerB', diffoutcomeB', a, b);


[a, b] = corr(diffagenA', diffoutcomeA', 'Type', 'Spearman');
figure,
plotCorrelationDifference(diffagenA', diffoutcomeA', a, b);


[a, b] = corr(diffagenB', diffoutcomeB', 'Type', 'Spearman');
figure,
plotCorrelationDifference(diffagenB', diffoutcomeB', a, b);


%% GSR

% GSRData.processed = ...
%     processGSR (GSRData.preprocessed, subjectData, var);
% 
