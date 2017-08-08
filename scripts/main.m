addpath('getData\');
addpath('analyses\questionnaires\');
addpath('figures\');

dataDirectory = 'V:\Data\06. ExpRep\';


%% Load sociodemographics and other relevant data (sociodemographics.txt)
% The vectors are already extracted with the subjects that are going to be
% used for the analysis
% Adjust the auxiliar variables according to the morphology of the table
[vecUsed, perFem, meanAge, stdAge, scholarity, gaming, vr] = ...
    sociodem (dataDirectory);


%% Load questionnaire data

[static_data, dynamic_data] = getData(dataDirectory);

static_data = static_data(:, :, vecUsed);
dynamic_data = dynamic_data(:, :, vecUsed);


%% Define variables

qOwnership = 1:4;
qControlOwn = [5,7];
qSimilar = 6;
qAgency = 8:11;
qOutAgency = 12:13;
qAgencyControl = 14:16;

qvAgency = 8:9;
qvAgencyControl = 10;


%% Ownership static
condition = 2;  % Change depending on the condition
data1 = squeeze(static_data(qOwnership, condition, :));
data2 = squeeze(static_data(qControlOwn, condition, :));

[mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
    (data1, data2);

% figure, boxplot(reshape(data1, 1, numel(data1))', 1)
% figure, boxplot(reshape(data2, 1, numel(data2))', 2)


% x1 = rand(10,1); x2 = 2*rand(15,1); x3 = randn(30,1);
% x = [x1;x2;x3];
% g = [ones(size(x1)); 2*ones(size(x2)); 3*ones(size(x3))];
% boxplot(x,g)

%% Ownership dynamic
condition = 3; % changee according to condition
[mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
    (squeeze(dynamic_data(qOwnership, condition, :)), ...
    squeeze(dynamic_data(qControlOwn, condition, :)));

% figure, boxplot(reshape(data1, 1, numel(data1))', 1)
% figure, boxplot(reshape(data2, 1, numel(data2))', 2)


%% Agency dynamic
condition = 2;  % Change depending on the condition
data1 = squeeze(dynamic_data(qAgency, condition, :));
data2 = squeeze(dynamic_data(qAgencyControl, condition, :));

[mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
    (data1, data2);


%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FULL ARM STATIC - FULL ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Data
data1 = squeeze(static_data(qOwnership, 1, :));
data2 = squeeze(dynamic_data(qOwnership, 1, :));

[mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
    (data1, data2);

plotQuestionnaires(data1, data2, ...
    'Sense of ownership', '', 'responses to questionnaires',...
    'Full arm static', 'Full arm dynamic', pmann);

% Correlations
[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'sense of ownership', 'Full arm static', 'Full arm dynamic', ...
    R(1,2), P(1,2))

[pGroups] = analysisGroups(data1,data2);


%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FULL ARM STATIC - DETACHED ARM STATIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data1 = squeeze(static_data(qOwnership, 1, :));
data2 = squeeze(static_data(qOwnership, 2, :));

[mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
    (data1, data2);

plotQuestionnaires(data1, data2, ...
    'sense of ownership', '', 'responses to questionnaires',...
    'Full arm static', 'Detached arm static', pmann);

% Correlations
[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'sense of ownership', 'Full arm static', 'Detached arm static', ...
    R(1,2), P(1,2))

[pGroups] = analysisGroups(data1,data2);


%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DETACHED ARM STATIC - DETACHED ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data1 = squeeze(static_data(qOwnership, 2, :));
data2 = squeeze(dynamic_data(qOwnership, 2, :));

[mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
    (data1, data2);

plotQuestionnaires(data1, data2, ...
    'Sense of ownership', '', 'responses to questionnaires',...
    'Detached arm static', 'Detached arm dynamic', pmann);


% Correlations
[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'Sense of ownership', 'Detached arm static', 'Detached arm dynamic', ...
    R(1,2), P(1,2))

[pGroups] = analysisGroups(data1,data2);


%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FULL ARM DYNAMIC - DETACHED ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data1 = squeeze(dynamic_data(qOwnership, 1, :));
data2 = squeeze(dynamic_data(qOwnership, 2, :));

[mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
    (data1, data2);

plotQuestionnaires(data1, data2, ...
    'sense of ownership', '', 'responses to questionnaires',...
    'Full arm dynamic', 'Detached arm dynamic', pmann);

% Correlations
[R, P] = corrcoef (nanmean(data1), nanmean(data2));


plotCorrelations(data1, data2, ...
    'Sense of ownership', 'Full arm dynamic', 'Detached arm dynamic', ...
    R(1,2), P(1,2))

[pGroups] = analysisGroups(data1,data2);

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FULL ARM STATIC - FULL ARM STATIC (BIS) %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   


data1 = squeeze(static_data(qOwnership, 1, :));
data2 = squeeze(static_data(qOwnership, 3, :));

[mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
    (data1, data2);

plotQuestionnaires(data1, data2, ...
    'Sense of ownership', '', 'responses to questionnaires',...
    'Full arm static', 'Full arm dynamic - post', pmann);
 
% Correlations
[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'Sense of ownership', 'Full arm static', 'Full arm static bis', ...
    R(1,2), P(1,2))

[pGroups] = analysisGroups(data1,data2);


%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FULL ARM DYNAMIC - FULL ARM NOISE %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data1 = squeeze(dynamic_data(qOwnership, 1, :));
data2 = squeeze(dynamic_data(qOwnership, 3, :));

[mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
    (data1, data2);

plotQuestionnaires(data1, data2, ...
    'Sense of ownership', '', 'responses to questionnaires',...
    'Full arm dynamic', 'Noise', pmann);


% Correlations
[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'Sense of ownership', 'Full arm static', 'Dynamic Noise', ...
    R(1,2), P(1,2))

[pGroups] = analysisGroups(data1,data2);


%% AGENCY

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FULL ARM DYNAMIC - DETACHED ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data1 = squeeze(dynamic_data(qAgency, 1, :));
data2 = squeeze(dynamic_data(qAgency, 2, :));

[mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
    (data1, data2);

plotQuestionnaires(data1, data2, ...
    'Sense of agency', '', 'responses to questionnaires',...
    'Full arm dynamic', 'Detached arm dynamic', pmann);


% Correlations
[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'Sense of agency', 'Full arm static', 'Detached arm Dynamic', ...
    R(1,2), P(1,2))




%% AGENCY

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM DYNAMIC - DYNAMIC NOISE %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data1 = squeeze(dynamic_data(qAgency, 1, :));
data2 = squeeze(dynamic_data(qAgency, 3, :));

[mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
    (data1, data2);

plotQuestionnaires(data1, data2, ...
    'Sense of agency', '', 'responses to questionnaires',...
    'Full arm dynamic', 'Dynamic noise', pmann);


% Correlations
[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'Sense of agency', 'Full arm static', 'Dynamic Noise', ...
    R(1,2), P(1,2))




%% AGENCY - OUTCOME

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM DYNAMIC - DETACHED ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data1 = squeeze(dynamic_data(qOutAgency, 1, :));
data2 = squeeze(dynamic_data(qOutAgency, 2, :));

[mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
    (data1, data2);

plotQuestionnaires(data1, data2, ...
    'Sense of outcome agency', '', 'responses to questionnaires',...
    'Full arm dynamic', 'Detached arm dynamic', pmann);


% Correlations
[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'Sense of outcome agency', 'Full arm static', 'Detached arm dynamic', ...
    R(1,2), P(1,2))




%% AGENCY - OUTCOME

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM DYNAMIC - DETACHED ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data1 = squeeze(dynamic_data(qOutAgency, 1, :));
data2 = squeeze(dynamic_data(qOutAgency, 3, :));

[mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
    (data1, data2);

plotQuestionnaires(data1, data2, ...
    'Sense of outcome agency', '', 'responses to questionnaires',...
    'Full arm dynamic', 'Noise arm dynamic', pmann);


% Correlations
[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'Sense of outcome agency', 'Full arm static', 'Noise arm dynamic', ...
    R(1,2), P(1,2))




%% VICARIOUS AGENCY

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM STATIC - DETACHED ARM STATIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data1 = squeeze(static_data(qvAgency, 1, :));
data2 = squeeze(static_data(qvAgency, 2, :));

[mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
    (data1, data2);

plotQuestionnaires(data1, data2, ...
    'Vicarious agency', '', 'responses to questionnaires',...
    'Full arm static', 'Detached arm static', pmann);


% Correlations
[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'Vicarious agency', 'Full arm static', 'Detached arm static', ...
    R(1,2), P(1,2))




%% VICARIOUS AGENCY

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM STATIC - FULL ARM STATIC (POST) %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data1 = squeeze(static_data(qvAgency, 1, :));
data2 = squeeze(static_data(qvAgency, 3, :));

[mn, md, pttest, pmann, ~, ~] = analysisQuestions ...
    (data1, data2);

plotQuestionnaires(data1, data2, ...
    'Vicarious agency', '', 'responses to questionnaires',...
    'Full arm static', 'Full arm static - post', pmann);


% Correlations
[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'Vicarious agency', 'Full arm static', 'Full arm static - post',...
    R(1,2), P(1,2))





%% OWNERSHIP - AGENCY CORRELATION 

%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM STATIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%

data1 = squeeze(static_data(qOwnership, 1, :));
data2 = squeeze(static_data(qvAgency, 1, :));

[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'Full arm static', 'Sense of ownership', 'Sense of agency',...
    R(1,2), P(1,2))


%% OWNERSHIP - AGENCY CORRELATION 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DETACHED ARM STATIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data1 = squeeze(static_data(qOwnership, 2, :));
data2 = squeeze(static_data(qvAgency, 2, :));

[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'Detached arm static', 'Sense of ownership', 'Sense of agency',...
    R(1,2), P(1,2))


%% OWNERSHIP - AGENCY CORRELATION 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM STATIC - POST %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data1 = squeeze(static_data(qOwnership, 3, :));
data2 = squeeze(static_data(qvAgency, 3, :));

[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'Full arm static - post', 'Sense of ownership', 'Sense of agency',...
    R(1,2), P(1,2));


%% OWNERSHIP - AGENCY CORRELATION 
%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FULL ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%

data1 = squeeze(dynamic_data(qOwnership, 1, :));
data2 = squeeze(dynamic_data(qAgency, 1, :));

[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'Full arm dynamic', 'Sense of ownership', 'Sense of agency',...
    R(1,2), P(1,2))


%% OWNERSHIP - AGENCY CORRELATION 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DETACHED ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data1 = squeeze(dynamic_data(qOwnership, 2, :));
data2 = squeeze(dynamic_data(qAgency, 2, :));

[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'Detached arm dynamic', 'Sense of ownership', 'Sense of agency',...
    R(1,2), P(1,2))


%% OWNERSHIP - AGENCY CORRELATION 
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% NOISE ARM DYNAMIC %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

data1 = squeeze(dynamic_data(qOwnership, 3, :));
data2 = squeeze(dynamic_data(qAgency, 3, :));

[R, P] = corrcoef (nanmean(data1), nanmean(data2));

plotCorrelations(data1, data2, ...
    'Noise dynamic', 'Sense of ownership', 'Sense of agency',...
    R(1,2), P(1,2))


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

X=repmat(ones(20,1)*1,1,1);
Y=repmat(ones(20,1)*2,1,1);
Z=repmat(ones(20,1)*3,1,1);
W=repmat(ones(20,1)*4,1,1);

ACTid =  randi(4,100,1);



xylabel = repmat('xyzw',100,1);
figure, boxplot([X; Y; Z; W], {repmat(ACTid,4,1), xylabel(:)}, 'factorgap',15)


%%

x = [1,2,3,4,5,1,2,3,4,6];
group = [1,1,2,2,2,3,3,3,4,4];
positions = [1 1.25 2 2.25];
boxplot(x,group, 'positions', positions);

set(gca,'xtick',[mean(positions(1:2)) mean(positions(3:4)) ])
set(gca,'xticklabel',{'Direct care','Housekeeping'})

color = ['c', 'y', 'c', 'y'];
h = findobj(gca,'Tag','Box');
for j=1:length(h)
   patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',.5);
end

c = get(gca, 'Children');

hleg1 = legend(c(1:2), 'Feature1', 'Feature2' );

