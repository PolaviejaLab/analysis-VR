addpath('analyses\questionnaires');
addpath('figures');
[params] = GetParameters();
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\Data.mat');


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





%% OWNERSHIP - AGENCY CORRELATION 
%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM STATIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(staticUsed(qOwnership, 1, :));
data2 = squeeze(staticUsed(qvAgency, 1, :));
cond1 = 'Sense of ownership';
cond2 = 'Vicarious agency';
FigTitle = 'Full arm static';
i_fig = i_fig + 1;

[R, P] = corrcoef (nanmean(data1), nanmean(data2));

fig3 = ...
    plotCorrelations(data1, data2, FigTitle, cond1, cond2, R(1,2), P(1,2));

[pGroups] = analysisGroups(data1,data2);

FigName = strcat('Figure',num2str(i_fig));

saveas(fig3, strcat(saveDirectory, FigName, 'A.png'));
saveas(fig3, strcat(saveDirectory, FigName, 'A.eps'));
saveas(fig3, strcat(saveDirectory, FigName, 'A.fig'));


%% OWNERSHIP - AGENCY CORRELATION 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DETACHED ARM STATIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(staticUsed(qOwnership, 2, :));
data2 = squeeze(staticUsed(qvAgency, 2, :));
cond1 = 'Sense of ownership';
cond2 = 'Vicarious agency';
FigTitle = 'Detached arm static';

[R, P] = corrcoef (nanmean(data1), nanmean(data2));

fig3 = ...
    plotCorrelations(data1, data2, FigTitle, cond1, cond2, R(1,2), P(1,2));

[pGroups] = analysisGroups(data1,data2);

FigName = strcat('Figure',num2str(i_fig));

saveas(fig3, strcat(saveDirectory, FigName, 'B.png'));
saveas(fig3, strcat(saveDirectory, FigName, 'B.eps'));
saveas(fig3, strcat(saveDirectory, FigName, 'B.fig'));


%% OWNERSHIP - AGENCY CORRELATION 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM STATIC - POST %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(staticUsed(qOwnership, 3, :));
data2 = squeeze(staticUsed(qvAgency, 3, :));
cond1 = 'Sense of ownership';
cond2 = 'Vicarious agency';
FigTitle = 'Full arm static - post';


[R, P] = corrcoef (nanmean(data1), nanmean(data2));

fig3 = ...
    plotCorrelations(data1, data2, FigTitle, cond1, cond2, R(1,2), P(1,2));

[pGroups] = analysisGroups(data1,data2);

FigName = strcat('Figure',num2str(i_fig));

saveas(fig3, strcat(saveDirectory, FigName, 'C.png'));
saveas(fig3, strcat(saveDirectory, FigName, 'C.eps'));
saveas(fig3, strcat(saveDirectory, FigName, 'C.fig'));


%% OWNERSHIP - AGENCY CORRELATION 
%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(dynamicUsed(qOwnership, 1, :));
data2 = squeeze(dynamicUsed(qAgency, 1, :));
cond1 = 'Sense of ownership';
cond2 = 'Sense of agency';
FigTitle = 'Full arm dynamic';

[R, P] = corrcoef (nanmean(data1), nanmean(data2));

fig3 = ...
    plotCorrelations(data1, data2, FigTitle, cond1, cond2, R(1,2), P(1,2));

[pGroups] = analysisGroups(data1,data2);

FigName = strcat('Figure',num2str(i_fig));

saveas(fig3, strcat(saveDirectory, FigName, 'D.png'));
saveas(fig3, strcat(saveDirectory, FigName, 'D.eps'));
saveas(fig3, strcat(saveDirectory, FigName, 'D.fig'));


%% OWNERSHIP - AGENCY CORRELATION 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DETACHED ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(dynamicUsed(qOwnership, 2, :));
data2 = squeeze(dynamicUsed(qAgency, 2, :));
cond1 = 'Sense of ownership';
cond2 = 'Sense of agency';
FigTitle = 'Detached arm dynamic';

[R, P] = corrcoef (nanmean(data1), nanmean(data2));

fig3 = ...
    plotCorrelations(data1, data2, FigTitle, cond1, cond2, R(1,2), P(1,2));

[pGroups] = analysisGroups(data1,data2);

FigName = strcat('Figure',num2str(i_fig));

saveas(fig3, strcat(saveDirectory, FigName, 'E.png'));
saveas(fig3, strcat(saveDirectory, FigName, 'E.eps'));
saveas(fig3, strcat(saveDirectory, FigName, 'E.fig'));


%% OWNERSHIP - AGENCY CORRELATION 
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% NOISE ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(dynamicUsed(qOwnership, 3, :));
data2 = squeeze(dynamicUsed(qAgency, 3, :));
cond1 = 'Sense of ownership';
cond2 = 'Sense of agency';
FigTitle = 'Noisy arm dynamic';

[R, P] = corrcoef (nanmean(data1), nanmean(data2));

fig3 = ...
    plotCorrelations(data1, data2, FigTitle, cond1, cond2, R(1,2), P(1,2));

[pGroups] = analysisGroups(data1,data2);

FigName = strcat('Figure',num2str(i_fig));

saveas(fig3, strcat(saveDirectory, FigName, 'F.png'));
saveas(fig3, strcat(saveDirectory, FigName, 'F.eps'));
saveas(fig3, strcat(saveDirectory, FigName, 'F.fig'));

