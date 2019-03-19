addpath('..\..\..\data\01. Pilot-Experiments\');
addpath('..\..\getData\');
[params] = GetParameters();

load('E:\GitHub\analysis-VR\data\01. Pilot-Experiments\results_pilots.mat');


%%
[comparisonResults] = statisticsQuestionnaires (...
     nanmean(squeeze(QuestionnaireData(params.quest.ownership, 1, :))), ...
     nanmean(squeeze(QuestionnaireData(params.quest.ownership, 3, :)))...
     );

%  plotQuestionnaires(...
%     nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, :))), ...
%     nanmean(squeeze(QuestionnaireData.dynamicUsed(params.quest.owner, 1, :))), ...
%     'Sense of Ownership', params.conditionStatic{1,1}, ...
%     params.conditionDynamic{1, 1}, comparisonResults.stats);

results.ownership.FullOffset = comparisonResults;
results.ownership.FullOffset.Condition1 = params.conditions{1, 1};
results.ownership.FullOffset.Condition2 = params.conditions{1, 3};

[comparisonResults] = statisticsQuestionnaires (...
     nanmean(squeeze(QuestionnaireData(params.quest.agency, 1, :))), ...
     nanmean(squeeze(QuestionnaireData(params.quest.agency, 3, :)))...
     );

results.agency.FullOffset = comparisonResults;
results.agency.FullOffset.Condition1 = params.conditions{1, 1};
results.agency.FullOffset.Condition2 = params.conditions{1, 3}; 

 
%% 
[comparisonResults] = statisticsQuestionnaires (...
     nanmean(squeeze(QuestionnaireData(params.quest.ownership, 4, :))), ...
     nanmean(squeeze(QuestionnaireData(params.quest.ownership, 6, :)))...
     );

results.ownership.DetachedOffset = comparisonResults;
results.ownership.DetachedOffset.Condition1 = params.conditions{1, 4};
results.ownership.DetachedOffset.Condition2 = params.conditions{1, 6}; 

[comparisonResults] = statisticsQuestionnaires (...
     nanmean(squeeze(QuestionnaireData(params.quest.agency, 4, :))), ...
     nanmean(squeeze(QuestionnaireData(params.quest.agency, 6, :)))...
     );

results.agency.DetachedOffset = comparisonResults;
results.agency.DetachedOffset.Condition1 = params.conditions{1, 4};
results.agency.DetachedOffset.Condition2 = params.conditions{1, 6}; 
 

%% 
[comparisonResults] = statisticsQuestionnaires (...
     nanmean(squeeze(QuestionnaireData(params.quest.ownership, 1, :))), ...
     nanmean(squeeze(QuestionnaireData(params.quest.ownership, 4, :)))...
     );

results.ownership.NoOffsetDiscontinuity = comparisonResults;
results.ownership.NoOffsetDiscontinuity.Condition1 = params.conditions{1, 1};
results.ownership.NoOffsetDiscontinuity.Condition2 = params.conditions{1, 4}; 

[comparisonResults] = statisticsQuestionnaires (...
     nanmean(squeeze(QuestionnaireData(params.quest.agency, 1, :))), ...
     nanmean(squeeze(QuestionnaireData(params.quest.agency, 4, :)))...
     );

results.agency.NoOffsetDiscontinuity = comparisonResults;
results.agency.NoOffsetDiscontinuity.Condition1 = params.conditions{1, 1};
results.agency.NoOffsetDiscontinuity.Condition2 = params.conditions{1, 4}; 


%% 
[comparisonResults] = statisticsQuestionnaires (...
     nanmean(squeeze(QuestionnaireData(params.quest.ownership, 4, :))), ...
     nanmean(squeeze(QuestionnaireData(params.quest.ownership, 6, :)))...
     );

results.ownership.OffsetDiscontinuity = comparisonResults;
results.ownership.OffsetDiscontinuity.Condition1 = params.conditions{1, 4};
results.ownership.OffsetDiscontinuity.Condition2 = params.conditions{1, 6}; 


[comparisonResults] = statisticsQuestionnaires (...
     nanmean(squeeze(QuestionnaireData(params.quest.agency, 4, :))), ...
     nanmean(squeeze(QuestionnaireData(params.quest.agency, 6, :)))...
     );

results.agency.OffsetDiscontinuity = comparisonResults;
results.agency.OffsetDiscontinuity.Condition1 = params.conditions{1, 4};
results.agency.OffsetDiscontinuity.Condition2 = params.conditions{1, 6}; 


% % %% Save Variables
% % save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\ProcessedData_Questionnaires.mat', ...
% %     'results');
% % 
