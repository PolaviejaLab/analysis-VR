addpath('../extractData');

[params] = GetParameters();



%% Extract Raw Data
[SubjectData] = extractSociodemographics (params, 'sociodemographics.txt');





% extractQuestionnaires();



