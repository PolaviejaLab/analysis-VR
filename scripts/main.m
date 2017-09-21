addpath('getData\');
addpath('analyses\questionnaires\');
addpath('figures\');

dataDirectory;% 'V:\Data\06. ExpRep\';
saveDirectory;% 'C:\Users\User\Desktop\FiguresResubmission_MATLAB\';


%% Load sociodemographics and other relevant data (sociodemographics.txt)
% The vectors are already extracted with the subjects that are going to be
% used for the analysis
% Adjust the auxiliar variables according to the morphology of the table
[vecUsed, perFem, ageArray, ~, gameArray, VRarray] = ...
    sociodem (dataDirectory);

save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\sociodem.mat', ...
    'vecUsed', 'ageArray', 'gameArray', 'VRarray');


%% Load questionnaire data
[static_data, dynamic_data] = getData(dataDirectory);

static_data = static_data(:, :, vecUsed);
dynamic_data = dynamic_data(:, :, vecUsed);

save('E:\GitHub\analysis-VR\data\03. Experiment_Rep\questionnaire_data.mat', ...
    'static_data', 'dynamic_data');


%% Add restrictions and recalculate values

age_restrict = find(ageArray <= 45);
static_data = static_data(:, :, age_restrict);
dynamic_data = dynamic_data(:, :, age_restrict);

ageArray = ageArray(age_restrict, :);

mnAge = mean(ageArray);
stdAge = std(ageArray);


%% Define variables for questionnaire data
qOwnership;
qControlOwn;
qSimilar;
qAgency;
qOutAgency;
qAgencyControl;
qvAgency;
qvAgencyControl;

i_fig = 0;

%% Plot and analyze

% Use AnalyzeandPlot ()

%% Correlations 

% use plotCorrelations, already adding the name of the variables instead of
% initializing them. 
 
% fig3 = ...
%     plotCorrelations(data1, data2, FigTitle, cond1, cond2, R(1,2), P(1,2));

% [pGroups, nGroups] = analysisGroups(data1,data2);

% FigName = strcat('Figure',num2str(i_fig));
% 
% saveas(fig3, strcat(saveDirectory, FigName, 'A.png'));
% saveas(fig3, strcat(saveDirectory, FigName, 'A.eps'));
% saveas(fig3, strcat(saveDirectory, FigName, 'A.fig'));


