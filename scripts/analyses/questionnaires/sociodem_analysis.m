
%% Add Paths and Load Data
addpath('..\..\figures\');
addpath('..\..\getData\');
addpath('..\..\');
[params] = GetParameters();

load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\PreprocessData_Questionnaires.mat');
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\SubjectData.mat');

%% Correlation Age - Basal static ownership



scatter(SubjectData.Age.All([1:25 27:31 33:37]), ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, ...
    [1:25 27:31 33:37]))),...
    '.k');
 
xlim([18 47]);
ylim([0.5 7.5]);
title('Age - Full arm static');
ylabel('Likert scale');
xlabel('Age');

[R, P] = corrcoef(SubjectData.Age.All([1:25 27:31 33:37]), ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, [1:25 27:31 33:37]))));

%% Classify by previous contact with VR

VRfirst = nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, SubjectData.VRUse.First)));
mean(VRfirst)

VRAlready = nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, SubjectData.VRUse.Already)));
mean(VRAlready)

VRAlways = nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, SubjectData.VRUse.Always)));
mean(VRAlways)

boxplot(nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, SubjectData.VRUse.First))); ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, SubjectData.VRUse.Already))); ...
    nanmean(squeeze(QuestionnaireData.staticUsed(params.quest.owner, 1, SubjectData.VRUse.Always)));


boxplot ([1; 2], [1:5; 3:17])