addpath('getData\');
addpath('analyses\questionnaires\');
addpath('figures\');

dataDirectory = 'V:\Data\06. ExpRep\';


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


%% Define variables
qOwnership = 1:4;
% qControlOwn = [5,7];
% qSimilar = 6;
qAgency = 8:11;
qOutAgency = 12:13;
% qAgencyControl = 14:16;

qvAgency = 8:9;
% qvAgencyControl = 10;

i_fig = 0;

%% OWNERSHIP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FULL ARM STATIC - FULL ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(static_data(qOwnership, 1, :));
data2 = squeeze(dynamic_data(qOwnership, 1, :));
cond1 = 'Full arm static';
cond2 = 'Full arm dynamic';
FigTitle = 'Sense of ownership';
i_fig = i_fig + 1;

doEverything(i_fig, data1, data2, cond1, cond2, FigTitle);


%% OWNERSHIP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FULL ARM STATIC - DETACHED ARM STATIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(static_data(qOwnership, 1, :));
data2 = squeeze(static_data(qOwnership, 2, :));
cond1 = 'Full arm static';
cond2 = 'Detached arm static';
FigTitle = 'Sense of ownership';
i_fig = i_fig + 1;

doEverything(i_fig, data1, data2, cond1, cond2, FigTitle);

%% OWNERSHIP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DETACHED ARM STATIC - DETACHED ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(static_data(qOwnership, 2, :));
data2 = squeeze(dynamic_data(qOwnership, 2, :));
cond1 = 'Detached arm static';
cond2 = 'Detached arm dynamic';
FigTitle = 'Sense of ownership';
i_fig = i_fig + 1;

doEverything(i_fig, data1, data2, cond1, cond2, FigTitle);

%% OWNERSHIP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FULL ARM DYNAMIC - DETACHED ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(dynamic_data(qOwnership, 1, :));
data2 = squeeze(dynamic_data(qOwnership, 2, :));
cond1 = 'Full arm dynamic';
cond2 = 'Detached arm dynamic';
FigTitle = 'Sense of ownership';
i_fig = i_fig + 1;

doEverything(i_fig, data1, data2, cond1, cond2, FigTitle);


%% OWNERSHIP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FULL ARM STATIC - FULL ARM STATIC (BIS) %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(static_data(qOwnership, 1, :));
data2 = squeeze(static_data(qOwnership, 3, :));
cond1 = 'Full arm static';
cond2 = 'Full arm static - post';
FigTitle = 'Sense of ownership';
i_fig = i_fig + 1;

doEverything(i_fig, data1, data2, cond1, cond2, FigTitle);

%% OWNERSHIP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FULL ARM DYNAMIC - FULL ARM NOISE %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(dynamic_data(qOwnership, 1, :));
data2 = squeeze(dynamic_data(qOwnership, 3, :));
cond1 = 'Full arm dynamic';
cond2 = 'Noisy arm dynamic';
FigTitle = 'Sense of ownership';
i_fig = i_fig + 1;

doEverything(i_fig, data1, data2, cond1, cond2, FigTitle);


%% OWNERSHIP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DETACHED ARM DYNAMIC - FULL ARM STATIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(static_data(qOwnership, 1, :));
data2 = squeeze(dynamic_data(qOwnership, 2, :));
cond1 = 'Full arm static';
cond2 = 'Detached arm dynamic';
FigTitle = 'Sense of ownership';
i_fig = i_fig + 1;

doEverything(i_fig, data1, data2, cond1, cond2, FigTitle);


%% AGENCY - BODY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FULL ARM DYNAMIC - DETACHED ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(dynamic_data(qAgency, 1, :));
data2 = squeeze(dynamic_data(qAgency, 2, :));
cond1 = 'Full arm dynamic';
cond2 = 'Detached arm dynamic';
FigTitle = 'Sense of agency';
i_fig = i_fig + 1;

doEverything(i_fig, data1, data2, cond1, cond2, FigTitle);

%% AGENCY - BODY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM DYNAMIC - NOISY ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(dynamic_data(qAgency, 1, :));
data2 = squeeze(dynamic_data(qAgency, 3, :));
cond1 = 'Full arm dynamic';
cond2 = 'Noisy arm dynamic';
FigTitle = 'Sense of agency';
i_fig = i_fig + 1;

[mn, md, pttest, pmann, ~, ~] = ...
    analysisQuestions (data1, data2);

doEverything(i_fig, data1, data2, cond1, cond2, FigTitle);


%% AGENCY - OUTCOME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM DYNAMIC - DETACHED ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(dynamic_data(qOutAgency, 1, :));
data2 = squeeze(dynamic_data(qOutAgency, 2, :));
cond1 = 'Full arm dynamic';
cond2 = 'Detached arm dynamic';
FigTitle = 'Sense of agency - outcome';
i_fig = i_fig + 1;

doEverything(i_fig, data1, data2, cond1, cond2, FigTitle);

%% AGENCY - OUTCOME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM DYNAMIC - NOISY ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(dynamic_data(qOutAgency, 1, :));
data2 = squeeze(dynamic_data(qOutAgency, 3, :));
cond1 = 'Full arm dynamic';
cond2 = 'Noisy arm dynamic';
FigTitle = 'Sense of agency - outcome';
i_fig = i_fig + 1;
doEverything(i_fig, data1, data2, cond1, cond2, FigTitle);


%% VICARIOUS AGENCY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM STATIC - DETACHED ARM STATIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(static_data(qvAgency, 1, :));
data2 = squeeze(static_data(qvAgency, 2, :));
cond1 = 'Full arm static';
cond2 = 'Detached arm static';
FigTitle = 'Vicarious agency';
i_fig = i_fig + 1;

doEverything(i_fig, data1, data2, cond1, cond2, FigTitle);




%% VICARIOUS AGENCY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM STATIC - FULL ARM STATIC (POST) %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(static_data(qvAgency, 1, :));
data2 = squeeze(static_data(qvAgency, 3, :));
cond1 = 'Full arm static';
cond2 = 'Full arm static - post';
FigTitle = 'Vicarious agency';
i_fig = i_fig + 1;

doEverything(i_fig, data1, data2, cond1, cond2, FigTitle);

%% OWNERSHIP - AGENCY CORRELATION 
%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM STATIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(static_data(qOwnership, 1, :));
data2 = squeeze(static_data(qvAgency, 1, :));
cond1 = 'Sense of ownership';
cond2 = 'Vicarious agency';
FigTitle = 'Full arm static';
i_fig = i_fig + 1;

[R, P] = corrcoef (nanmean(data1), nanmean(data2));

fig3 = plotCorrelations(data1, data2, ...
    FigTitle, cond1, cond2, ...
    R(1,2), P(1,2))

[pGroups] = analysisGroups(data1,data2);

FigName = strcat('Figure',num2str(i_fig));

saveas(fig3, ...
    strcat('C:\Users\User\Desktop\FiguresResubmission_MATLAB\', ...
    FigName, 'A.png'));


%% OWNERSHIP - AGENCY CORRELATION 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DETACHED ARM STATIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(static_data(qOwnership, 2, :));
data2 = squeeze(static_data(qvAgency, 2, :));
cond1 = 'Sense of ownership';
cond2 = 'Vicarious agency';
FigTitle = 'Detached arm static';

[R, P] = corrcoef (nanmean(data1), nanmean(data2));

fig3 = plotCorrelations(data1, data2, ...
    FigTitle, cond1, cond2, ...
    R(1,2), P(1,2))

[pGroups] = analysisGroups(data1,data2);

FigName = strcat('Figure',num2str(i_fig));

saveas(fig3, ...
    strcat('C:\Users\User\Desktop\FiguresResubmission_MATLAB\', ...
    FigName, 'B.png'));


%% OWNERSHIP - AGENCY CORRELATION 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM STATIC - POST %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(static_data(qOwnership, 3, :));
data2 = squeeze(static_data(qvAgency, 3, :));
cond1 = 'Sense of ownership';
cond2 = 'Vicarious agency';
FigTitle = 'Full arm static - post';


[R, P] = corrcoef (nanmean(data1), nanmean(data2));

fig3 = plotCorrelations(data1, data2, ...
    FigTitle, cond1, cond2, ...
    R(1,2), P(1,2))

[pGroups] = analysisGroups(data1,data2);

FigName = strcat('Figure',num2str(i_fig));

saveas(fig3, ...
    strcat('C:\Users\User\Desktop\FiguresResubmission_MATLAB\', ...
    FigName, 'C.png'));



%% OWNERSHIP - AGENCY CORRELATION 
%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(dynamic_data(qOwnership, 1, :));
data2 = squeeze(dynamic_data(qAgency, 1, :));
cond1 = 'Sense of ownership';
cond2 = 'Sense of agency';
FigTitle = 'Full arm dynamic';

[R, P] = corrcoef (nanmean(data1), nanmean(data2));

fig3 = plotCorrelations(data1, data2, ...
    FigTitle, cond1, cond2, ...
    R(1,2), P(1,2))

[pGroups] = analysisGroups(data1,data2);

FigName = strcat('Figure',num2str(i_fig));

saveas(fig3, ...
    strcat('C:\Users\User\Desktop\FiguresResubmission_MATLAB\', ...
    FigName, 'D.png'));



%% OWNERSHIP - AGENCY CORRELATION 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DETACHED ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(dynamic_data(qOwnership, 2, :));
data2 = squeeze(dynamic_data(qAgency, 2, :));
cond1 = 'Sense of ownership';
cond2 = 'Sense of agency';
FigTitle = 'Detached arm dynamic';

[R, P] = corrcoef (nanmean(data1), nanmean(data2));

fig3 = plotCorrelations(data1, data2, ...
    FigTitle, cond1, cond2, ...
    R(1,2), P(1,2))

[pGroups] = analysisGroups(data1,data2);

FigName = strcat('Figure',num2str(i_fig));

saveas(fig3, ...
    strcat('C:\Users\User\Desktop\FiguresResubmission_MATLAB\', ...
    FigName, 'E.png'));



%% OWNERSHIP - AGENCY CORRELATION 
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% NOISE ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

clear mn md pttest pmann pks2 R P pGroups

data1 = squeeze(dynamic_data(qOwnership, 3, :));
data2 = squeeze(dynamic_data(qAgency, 3, :));
cond1 = 'Sense of ownership';
cond2 = 'Sense of agency';
FigTitle = 'Noisy arm dynamic';

[R, P] = corrcoef (nanmean(data1), nanmean(data2));

fig3 = plotCorrelations(data1, data2, ...
    FigTitle, cond1, cond2, ...
    R(1,2), P(1,2))

[pGroups] = analysisGroups(data1,data2);

FigName = strcat('Figure',num2str(i_fig));

saveas(fig3, ...
    strcat('C:\Users\User\Desktop\FiguresResubmission_MATLAB\', ...
    FigName, 'F.png'));



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% ANALYSIS BY QUESTIONS %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Y = randi(10,100,1);
% X = randi(20,100,1);
% Z = randi(5,100,1);
% W = randi(30,100,1);

% X=[...
%     squeeze(static_data(1,1,:)), ...
%     squeeze(static_data(1,2,:)), ...
%     squeeze(dynamic_data(1,1,:)), ...
%     squeeze(dynamic_data(1,2,:)) ...
%     ];
% Y=[...
%     squeeze(static_data(2,1,:)), ...
%     squeeze(static_data(2,2,:)), ...
%     squeeze(dynamic_data(2,1,:)), ...
%     squeeze(dynamic_data(2,2,:)) ...
%     ];
% Z=[...
%     squeeze(static_data(3,1,:)), ...
%     squeeze(static_data(3,2,:)), ...
%     squeeze(dynamic_data(3,1,:)), ...
%     squeeze(dynamic_data(3,2,:)) ...
%     ];
% W=[...
%     squeeze(static_data(4,1,:)), ...
%     squeeze(static_data(4,2,:)), ...
%     squeeze(dynamic_data(4,1,:)), ...
%     squeeze(dynamic_data(4,2,:)) ...
%     ];
% X=repmat(squeeze(static_data(1,1,:)),1,4);
% Y=repmat(squeeze(static_data(2,1,:)),1,4);
% Z=repmat(squeeze(static_data(3,1,:)),1,4);
% W=repmat(squeeze(static_data(4,1,:)),1,4);
% 
% X=repmat(ones(20,1)*1,1,1);
% Y=repmat(ones(20,1)*2,1,1);
% Z=repmat(ones(20,1)*3,1,1);
% W=repmat(ones(20,1)*4,1,1);
% 
% ACTid =  randi(4,100,1);
% 
% 
% 
% xylabel = repmat('xyzw',100,1);
% figure, boxplot([X; Y; Z; W], {repmat(ACTid,4,1), xylabel(:)}, 'factorgap',15)
% 
% 
% %%
% 
% x = [1,2,3,4,5,1,2,3,4,6];
% group = [1,1,2,2,2,3,3,3,4,4];
% positions = [1 1.25 2 2.25];
% boxplot(x,group, 'positions', positions);
% 
% set(gca,'xtick',[mean(positions(1:2)) mean(positions(3:4)) ])
% set(gca,'xticklabel',{'Direct care','Housekeeping'})
% 
% color = ['c', 'y', 'c', 'y'];
% h = findobj(gca,'Tag','Box');
% for j=1:length(h)
%    patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',.5);
% end
% 
% c = get(gca, 'Children');
% 
% hleg1 = legend(c(1:2), 'Feature1', 'Feature2' );
% 
% 
% %% Ownership static
% % condition = 2;  % Change depending on the condition
% % data1 = squeeze(static_data(qOwnership, condition, :));
% % data2 = squeeze(static_data(qControlOwn, condition, :));
% % 
% % [mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
% %     (data1, data2);
% % 
% 
% %% Ownership dynamic
% % condition = 3; % changee according to condition
% % [mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
% %     (squeeze(dynamic_data(qOwnership, condition, :)), ...
% %     squeeze(dynamic_data(qControlOwn, condition, :)));
% % 
% % % figure, boxplot(reshape(data1, 1, numel(data1))', 1)
% % % figure, boxplot(reshape(data2, 1, numel(data2))', 2)
% 
% 
% %% Agency dynamic
% % condition = 2;  % Change depending on the condition
% % data1 = squeeze(dynamic_data(qAgency, condition, :));
% % data2 = squeeze(dynamic_data(qAgencyControl, condition, :));
% % 
% % [mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
% %     (data1, data2);
