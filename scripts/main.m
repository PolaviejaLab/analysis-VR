%%
addpath('extractData');

%% Find variables 
% This file should be modified with the parameters of each experiment
[params] = GetParameters();


%% Extract Raw Data
[subjectData] = extractSociodemographics (params, 'sociodemographics.txt');

[questionnaireData] = extractQuestionnaires(params, subjectData);

save(strcat(params.dataDirectory, '\Results\subjectData'), 'subjectData');
save(strcat(params.dataDirectory, '\Results\preprocessedQuestionnaires.mat'), ...
    'questionnaireData');

%% 