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

% Subjects Used for Analysis (Inclusion Criteria)
column_used = 8; % Change according to file
vecUsed = findUsed(sociodem_table, column_used);

% SubjectData of the data used for analysis
sociodem_array = table2array(sociodem_table(vecUsed, 3:9));
[SubjectData] = GetSociodemData (sociodem_array);


%% Load questionnaire data
[QuestionnaireData.visuomotorInformation.responses, QuestionnaireData.visuomotorInformation.order_matrix] = ...
    GetDataFromQuestionnaires(strcat(params.dataDirectory, '\Visuomotor Information'));
QuestionnaireData.visuomotorInformation.responses = ...
    QuestionnaireData.visuomotorInformation.responses(:, :, vecUsed);
QuestionnaireData.visuomotorInformation.order_matrix = ...
    QuestionnaireData.visuomotorInformation.order_matrix(:, vecUsed);

[QuestionnaireData.outcomeOwnership.responses, QuestionnaireData.outcomeOwnership.order_matrix] = ...
    GetDataFromQuestionnaires(strcat(params.dataDirectory, '\Outcome Ownership'));
QuestionnaireData.outcomeOwnership.responses = ...
    QuestionnaireData.outcomeOwnership.responses(:, :, vecUsed);
QuestionnaireData.outcomeOwnership.order_matrix = ...
    QuestionnaireData.outcomeOwnership.order_matrix(:, vecUsed);


%% Save parameters
save('E:\GitHub\analysis-VR\data\NewExperiment\SubjectData.mat', ...
    'SubjectData');
save('E:\GitHub\analysis-VR\data\NewExperiment\PreprocessData_Questionnaires.mat', ...
    'QuestionnaireData');

