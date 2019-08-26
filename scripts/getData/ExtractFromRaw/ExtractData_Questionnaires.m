addpath('..');


%% Variables
[params] = GetParameters();


%% Load Subject Data
% The vectors are already extracted with the subjects that are going to be
% used for the analysis
% Adjust the auxiliar variables according to the morphology of the table

% Load the sociodemographics file
fileName = 'sociodemographics.txt';
sociodem_table = readtable(fullfile(params.dataDirectory, fileName));

% Subjects Used for Analysis (Inclusion Criteria: the tracking workedm the
% the participant followed our instructions, naîve to the study)
column_used = 11; % Change according to file
vecUsed = findUsed(sociodem_table, column_used);

% Get subject Code%% Variables
subjectCodeArray = table2array(sociodem_table(vecUsed, 2));

% SubjectData of the data used for analysis
sociodem_array = table2array(sociodem_table(vecUsed, 3:10));
[SubjectData] = GetSociodemData (sociodem_array);


 %% Load questionnaire data
experimentType = '\Visuomotor Information\';
[QuestionnaireData.visuomotorInformation.responses, ...
    QuestionnaireData.visuomotorInformation.order_matrix] = ...
    GetDataFromQuestionnaires(params.dataDirectory, ...
    experimentType, subjectCodeArray);

experimentType = '\Outcome Ownership\';
[QuestionnaireData.outcomeOwnership.responses, ...
    QuestionnaireData.visuomotorInformation.order_matrix] = ...
    GetDataFromQuestionnaires(params.dataDirectory, ...
    experimentType, subjectCodeArray);


%% Save parameters
save('E:\GitHub\analysis-VR\data\NewExperiment\SubjectData.mat', ...
    'SubjectData');
save('E:\GitHub\analysis-VR\data\NewExperiment\PreprocessData_Questionnaires.mat', ...
    'QuestionnaireData');

