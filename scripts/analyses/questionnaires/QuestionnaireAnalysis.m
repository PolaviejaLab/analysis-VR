addpath('..\..\figures\');
addpath('..\..\getData\');
addpath('..\..\');
[params] = GetParameters();
% load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\PreprocessData_Questionnaires.mat');


%%
[comparisonResults] = statisticsQuestionnaires (...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 1, :)))...
    );

plotQuestionnaires(...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 1, :))), ...
    'Sense of Ownership', params.conditionStatic{1,1}, ...
    params.conditionDynamic{1, 1}, comparisonResults.stats);

results.Ownership.FullSD = comparisonResults;
results.Ownership.FullSD.Condition1 = params.conditionStatic{1, 1};
results.Ownership.FullSD.Condition2 = params.conditionDynamic{1, 1};


%%
[comparisonResults] = statisticsQuestionnaires (...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 2, :)))...
    );

plotQuestionnaires(...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 2, :))), ...
    'Sense of Ownership', params.conditionStatic{1,1}, ...
    params.conditionStatic{1,2}, comparisonResults.stats);

results.Ownership.StatFD = comparisonResults;
results.Ownership.StatFD.Condition1 = params.conditionStatic{1, 1};
results.Ownership.StatFD.Condition2 = params.conditionStatic{1, 2};


%%
[comparisonResults] = statisticsQuestionnaires (...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 2, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 2, :)))...
    );

plotQuestionnaires(...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 2, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 2, :))), ...
    'Sense of Ownership', params.conditionStatic{1,2}, ...
    params.conditionDynamic{1, 2}, comparisonResults.stats);

results.Ownership.DetSD = comparisonResults;
results.Ownership.DetSD.Condition1 = params.conditionStatic{1, 2};
results.Ownership.DetSD.Condition2 = params.conditionDynamic{1, 2};


%%
[comparisonResults] = statisticsQuestionnaires (...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 2, :)))...
    );

plotQuestionnaires(...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 2, :))), ...
    'Sense of Ownership', params.conditionDynamic{1, 1}, ...
    params.conditionDynamic{1, 2}, comparisonResults.stats);

results.Ownership.DynFD = comparisonResults;
results.Ownership.DynFD.Condition1 = params.conditionDynamic{1, 1};
results.Ownership.DynFD.Condition2 = params.conditionDynamic{1, 2};


%%
[comparisonResults] = statisticsQuestionnaires (...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 3, :)))...
    );

plotQuestionnaires(...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 3, :))), ...
    'Sense of Ownership', params.conditionStatic{1, 1}, ...
    params.conditionStatic{1, 3}, comparisonResults.stats);

results.Ownership.StatFF = comparisonResults;
results.Ownership.StatFF.Condition1 = params.conditionStatic{1, 1};
results.Ownership.StatFF.Condition2 = params.conditionStatic{1, 3};


%%
[comparisonResults] = statisticsQuestionnaires (...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 3, :)))...
    );

plotQuestionnaires(...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 3, :))), ...
    'Sense of Ownership', params.conditionDynamic{1, 1}, ...
    params.conditionDynamic{1, 3}, comparisonResults.stats);

results.Ownership.DynFI = comparisonResults;
results.Ownership.DynFI.Condition1 = params.conditionDynamic{1, 1};
results.Ownership.DynFI.Condition2 = params.conditionDynamic{1, 3};


%%
[comparisonResults] = statisticsQuestionnaires (...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 2, :))), ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, :)))...
    );

plotQuestionnaires(...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 2, :))), ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, :))), ...
    'Sense of Ownership', params.conditionDynamic{1, 2}, ...
    params.conditionStatic{1, 1}, comparisonResults.stats);

results.Ownership.DSDF = comparisonResults;
results.Ownership.DSDF.Condition1 = params.conditionDynamic{1, 2};
results.Ownership.DSDF.Condition2 = params.conditionStatic{1, 1};


%%
[comparisonResults] = statisticsQuestionnaires (...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.agenStat, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.agenStat, 2, :)))...
    );

plotQuestionnaires(...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.agenStat, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.agenStat, 2, :))), ...
    'Sense of Agency', params.conditionStatic{1, 1}, ...
    params.conditionStatic{1, 2}, comparisonResults.stats);

results.AgencyStatic.FD = comparisonResults;
results.AgencyStatic.FD.Condition1 = params.conditionStatic{1, 1};
results.AgencyStatic.FD.Condition2 = params.conditionStatic{1, 2};


%%
[comparisonResults] = statisticsQuestionnaires (...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.agenStat, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.agenStat, 3, :)))...
    );

plotQuestionnaires(...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.agenStat, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.agenStat, 3, :))), ...
    'Sense of Agency', params.conditionStatic{1, 1}, ...
    params.conditionStatic{1, 3}, comparisonResults.stats);

results.AgencyStatic.FF = comparisonResults;
results.AgencyStatic.FF.Condition1 = params.conditionStatic{1, 1};
results.AgencyStatic.FF.Condition2 = params.conditionStatic{1, 3};


%%
[comparisonResults] = statisticsQuestionnaires (...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenDyn, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenDyn, 2, :)))...
    );

plotQuestionnaires(...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenDyn, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenDyn, 2, :))), ...
    'Sense of Agency', params.conditionDynamic{1, 1}, ...
    params.conditionDynamic{1, 2}, comparisonResults.stats);

results.AgencyDynamic.FD = comparisonResults;
results.AgencyDynamic.FD.Condition1 = params.conditionStatic{1, 1};
results.AgencyDynamic.FD.Condition2 = params.conditionStatic{1, 2};


%%
[comparisonResults] = statisticsQuestionnaires (...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenDyn, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenDyn, 3, :)))...
    );

plotQuestionnaires(...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenDyn, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenDyn, 3, :))), ...
    'Sense of Agency', params.conditionDynamic{1, 1}, ...
    params.conditionDynamic{1, 3}, comparisonResults.stats);

results.AgencyDynamic.FI = comparisonResults;
results.AgencyDynamic.FI.Condition1 = params.conditionStatic{1, 1};
results.AgencyDynamic.FI.Condition2 = params.conditionStatic{1, 3};


%%
[comparisonResults] = statisticsQuestionnaires (...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenOut, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenOut, 2, :)))...
    );

plotQuestionnaires(...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenOut, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenOut, 2, :))), ...
    'Sense of Agency Outcome', params.conditionDynamic{1, 1}, ...
    params.conditionDynamic{1, 2}, comparisonResults.stats);

results.AgencyOutcome.FD = comparisonResults;
results.AgencyOutcome.FD.Condition1 = params.conditionStatic{1, 1};
results.AgencyOutcome.FD.Condition2 = params.conditionStatic{1, 2};


%%
[comparisonResults] = statisticsQuestionnaires (...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenOut, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenOut, 3, :)))...
    );

plotQuestionnaires(...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenOut, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenOut, 3, :))), ...
    'Sense of Agency Outcome', params.conditionDynamic{1, 1}, ...
    params.conditionDynamic{1, 3}, comparisonResults.stats);

results.AgencyOutcome.FI = comparisonResults;
results.AgencyOutcome.FI.Condition1 = params.conditionStatic{1, 1};
results.AgencyOutcome.FI.Condition2 = params.conditionStatic{1, 3};


%% correlations difference

[results.correlations.FASDAS]= correlationDifference(...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, :))) - ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 2, :))), ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.agenStat, 1, :))) - ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.agenStat, 2, :))));

[results.correlations.FASP]= correlationDifference(...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, :))) - ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 3, :))), ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.agenStat, 1, :))) - ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.agenStat, 3, :))));

[results.correlations.FADDAD]= correlationDifference(...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 1, :))) - ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 2, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenDyn, 1, :))) - ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenDyn, 2, :))));

[results.correlations.FADIM]= correlationDifference(...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 1, :))) - ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 3, :))), ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenDyn, 1, :))) - ...
    nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.agenDyn, 3, :))));


%% Save Variables
save('C:\Users\polav\Desktop\VR_Data\Thesis_Experiment2\ProcessedData_Questionnaires.mat', ...
    'results');

