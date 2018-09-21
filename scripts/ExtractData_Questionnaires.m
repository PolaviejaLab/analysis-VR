addpath('getData');
dataDirectory = 'V:\Data\06. ExpRep\';


%% Load Subject Data
% The vectors are already extracted with the subjects that are going to be
% used for the analysis
% Adjust the auxiliar variables according to the morphology of the table

% Load the sociodemographics file
fileName = 'sociodemographics.txt';
sociodem_table = readtable(fullfile(dataDirectory, fileName));

% Subjects Used for Analysis (Inclusion Criteria)
column_used = 8; % Change according to file
vecUsed = findUsed(sociodem_table, column_used);

% SubjectData of the data used for analysis
sociodem_array = table2array(sociodem_table(vecUsed, 3:9));
[SubjectData] = GetSociodemData (sociodem_array);


%% Load questionnaire data
[QuestionnaireData] = GetDataFromQuestionnaires(dataDirectory);


%% Questionnaire Data
QuestionnaireData.staticUsed = QuestionnaireData.static(:, :, vecUsed);
QuestionnaireData.dynamicUsed = QuestionnaireData.dynamic(:, :, vecUsed);

load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\QuestionnaireOrder.mat');
OrderQuestionnaires.All = orderArray; 
OrderQuestionnaires.Used = orderArray(:, vecUsed);
save

%% Save parameters
save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\QuestionnaireOrder.mat', ...
    'OrderQuestionnaires');
save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\Data.mat', ...
     'SubjectData', 'QuestionnaireData', 'vecUsed');

 