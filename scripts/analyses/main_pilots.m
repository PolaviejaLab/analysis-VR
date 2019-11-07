load('E:\GitHub\analysis-VR\data\01. Pilot-Experiments\results_pilots.mat');
load('E:\GitHub\analysis-VR\data\01. Pilot-Experiments\data_pilots.mat');


%% Sense of ownership

qOwnership = 1:4;
qCOwnership = 6;

ownership = squeeze(nanmean(QuestionnaireData(qOwnership, :, :)));
cOwnership = squeeze(QuestionnaireData(qCOwnership, :, :));

ownership = ownership'; cOwnership = cOwnership';

[a, b, c] = signrank(ownership(:, 1), cOwnership(:, 1))
[a, b, c] = signrank(ownership(:, 3), cOwnership(:, 3))
[a, b, c] = signrank(ownership(:, 4), cOwnership(:, 4))
[a, b, c] = signrank(ownership(:, 6), cOwnership(:, 6))


[a, b, c] = signrank(ownership(:, 1), ownership(:, 3))
[a, b, c] = signrank(ownership(:, 4), ownership(:, 6))
[a, b, c] = signrank(ownership(:, 1), ownership(:, 4))
[a, b, c] = signrank(ownership(:, 3), ownership(:, 6))

[a, b, c] = friedman(ownership(:, [1, 3, 4, 6]), 1);

figure, boxplot(ownership); 
ylim([0.5 7.5])


figure, boxplot(cOwnership);
ylim([0.5 7.5])

%% Sense of agency

qAgency = 7:8;
qCAgency = 10:12;

agency = squeeze(nanmean(QuestionnaireData(qAgency, :, :)));
cAgency = squeeze(nanmean(QuestionnaireData(qCAgency, :, :)));

agency = agency'; cAgency = cAgency';

[a, b, c] = signrank(agency(:, 1), cAgency(:, 1))
[a, b, c] = signrank(agency(:, 3), cAgency(:, 3))
[a, b, c] = signrank(agency(:, 4), cAgency(:, 4))
[a, b, c] = signrank(agency(:, 6), cAgency(:, 6))


[a, b, c] = signrank(agency(:, 1), agency(:, 3))
[a, b, c] = signrank(agency(:, 4), agency(:, 6))
[a, b, c] = signrank(agency(:, 1), agency(:, 4))
[a, b, c] = signrank(agency(:, 3), agency(:, 6))

p = friedman(agency(:, [1, 3, 4, 6]), 1);

figure,
boxplot(agency); 
ylim([0.5 7.5]);

figure,
boxplot(cAgency)
ylim([0.5 7.5]);


