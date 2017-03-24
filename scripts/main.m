qo = 1:4;
qa = 7:9;
ql = 13:14;

iterations = 10000;

v_age = [21 24 24 19 55 18 20 60 49 60 29 29 60 45]; % all participants
participants = [1 2 3 4 5 6 7 8 10 11 12 13]; % participants that I was able to get the questionnaire data from

v_participants = v_age(participants); % ages of participants that had the questionnaire data available

hist(v_participants, 5); % plot age

% get from questionnaires
addpath('getData\'); addpath('statistics\'); addpath('figures\');
[statArray, dynArray] = get_questionnaire_data();

% divide by age
stat_y = statArray(:, :, v_participants < 40);
stat_o = statArray(:, :, v_participants > 40);

dyn_y = dynArray(:, :, v_participants < 40);
dyn_o = dynArray(:, :, v_participants > 40);

% divide by groups
statLow = find(mean(squeeze(statArray(qo, 1, :))) <= 3);
statMed = find(mean(squeeze(statArray(qo, 1, :))) > 3 & mean(squeeze(statArray(qo, 1, :))) < 5);
statHig = find(mean(squeeze(statArray(qo, 1, :))) >= 5);

dynLow = find(mean(squeeze(dynArray(qo, 1, :))) <= 3);
dynMed = find(mean(squeeze(dynArray(qo, 1, :))) > 3 & mean(squeeze(dynArray(qo, 1, :))) < 5);
dynHig = find(mean(squeeze(dynArray(qo, 1, :))) >= 5);

%% STATIC

% statistical analyses
permOwn_all = permutationAnalysis(10000, ...
    reshape(squeeze(statArray(qo, 1, :)), 1, 4*12), ...
    reshape(squeeze(statArray(qo, 2, :)), 1, 4*12)); % ownership

[~,ksOwn_all] = kstest2(reshape(squeeze(statArray(qo, 1, :)), 1, 4*12), ...
    reshape(squeeze(statArray(qo, 2, :)), 1, 4*12)); % ownership

% groups analysis
[r,pcorr] = corrcoef(mean(squeeze(statArray(qo, 1, :))), ...
    mean(squeeze(statArray(qo, 2, :))));

permGroups = permutation_byGroups(10000, statLow, statMed, statHig, ...
    squeeze(statArray(qo, 1, :)), ...
    squeeze(statArray(qo, 2, :)));

% age analysis
permOwn_y = permutationAnalysis_diffSize(10000, ...
    reshape(squeeze(stat_y(qo, 1, :)), 1, 4*8), ...
    reshape(squeeze(stat_y(qo, 2, :)), 1, 4*8));

permOwn_o = permutationAnalysis_diffSize(10000, ...
    reshape(squeeze(stat_o(qo, 1, :)), 1, 4*4), ...
    reshape(squeeze(stat_o(qo, 2, :)), 1, 4*4));

permOwn_agebas = permutationAnalysis_diffSize(10000, ... % basal dynamic age
    reshape(squeeze(stat_y(qo, 1, :)), 1, 4*8), ...
    reshape(squeeze(stat_o(qo, 1, :)), 1, 4*4));

permOwn_ageman = permutationAnalysis_diffSize(10000, ... % discon dynamic age
    reshape(squeeze(stat_y(qo, 2, :)), 1, 4*8), ...
    reshape(squeeze(stat_o(qo, 2, :)), 1, 4*4));

[~,ksOwn_y] = kstest2(reshape(squeeze(stat_y(qo, 1, :)), 1, 4*8), ...
    reshape(squeeze(stat_y(qo, 2, :)), 1, 4*8));

[~,ksOwn_o] = kstest2(reshape(squeeze(stat_o(qo, 1, :)), 1, 4*4), ...
    reshape(squeeze(stat_o(qo, 2, :)), 1, 4*4));

% plot the figures
fig_mean_distributions(1, ...                               % all_questionnaire
    reshape(squeeze(statArray(qo, 1, :)), 1, 4*12), ...
    reshape(squeeze(statArray(qo, 2, :)), 1, 4*12), 6);

fig = figure(2); clf;                                       %  correlation
set(fig, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);
plot(mean(squeeze(statArray(qo, 1, :))), ...
    mean(squeeze(statArray(qo, 2, :))), 'ok'); hold on,
line([0 8], [0 8]);
xlim([0.5 7.5]);  ylim([0.5 7.5]);

fig_mean_distributions(3, reshape(squeeze(stat_y(qo, 1, :)), 1, 4*8), ... % under 40
    reshape(squeeze(stat_y(qo, 2, :)), 1, 4*8), 6);

fig_mean_distributions(4, reshape(squeeze(stat_o(qo, 1, :)), 1, 4*4), ... % over 40
    reshape(squeeze(stat_o(qo, 2, :)), 1, 4*4), 6);

fig_mean_distributions(5, reshape(squeeze(stat_y(qo, 1, :)), 1, 4*8), ... % basal dynamic age
    reshape(squeeze(stat_o(qo, 1, :)), 1, 4*4), 6);

fig_mean_distributions(6, reshape(squeeze(stat_y(qo, 2, :)), 1, 4*8), ... % discon dynamic age
    reshape(squeeze(stat_o(qo, 2, :)), 1, 4*4), 6);


%% BASAL (STATIC - DYNAMIC)

% statistical analyses
permOwn_all = permutationAnalysis(10000, ...
    reshape(squeeze(statArray(qo, 1, :)), 1, 4*12), ...
    reshape(squeeze(dynArray(qo, 1, :)), 1, 4*12)); % ownership

[~,ksOwn_all] = kstest2(reshape(squeeze(statArray(qo, 1, :)), 1, 4*12), ...
    reshape(squeeze(dynArray(qo, 1, :)), 1, 4*12)); % ownership

% groups analysis
[r,pcorr] = corrcoef(mean(squeeze(statArray(qo, 1, :))), ...
    mean(squeeze(dynArray(qo, 1, :))));

permGroups = permutation_byGroups(10000, statLow, statMed, statHig, ...
    squeeze(statArray(qo, 1, :)), ...
    squeeze(dynArray(qo, 1, :)));

% age analysis
permOwn_y = permutationAnalysis_diffSize(10000, ... % under 40
    reshape(squeeze(stat_y(qo, 1, :)), 1, 4*8), ...
    reshape(squeeze(dyn_y(qo, 1, :)), 1, 4*8));

permOwn_o = permutationAnalysis_diffSize(10000, ... % over 40
    reshape(squeeze(stat_o(qo, 1, :)), 1, 4*4), ...
    reshape(squeeze(dyn_o(qo, 1, :)), 1, 4*4));

[~,ksOwn_y] = kstest2(reshape(squeeze(stat_y(qo, 1, :)), 1, 4*8), ... % under 40
    reshape(squeeze(dyn_y(qo, 1, :)), 1, 4*8));

[~,ksOwn_o] = kstest2(reshape(squeeze(stat_o(qo, 1, :)), 1, 4*4), ... % over 40
    reshape(squeeze(dyn_o(qo, 1, :)), 1, 4*4));

% plot the figures
fig_mean_distributions(1, ...                               % all_questionnaire
    reshape(squeeze(statArray(qo, 1, :)), 1, 4*12), ...
    reshape(squeeze(dynArray(qo, 1, :)), 1, 4*12), 6);

fig = figure(2); clf;                                       %  correlation
set(fig, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);
plot(mean(squeeze(statArray(qo, 1, :))), ...
    mean(squeeze(dynArray(qo, 1, :))), 'ok'); hold on,
line([0 8], [0 8]);
xlim([0.5 7.5]);  ylim([0.5 7.5]);

fig_mean_distributions(3, reshape(squeeze(stat_y(qo, 1, :)), 1, 4*8), ... % under 40
    reshape(squeeze(dyn_y(qo, 1, :)), 1, 4*8), 6);

fig_mean_distributions(4, reshape(squeeze(stat_o(qo, 1, :)), 1, 4*4), ... % over 40
    reshape(squeeze(dyn_o(qo, 1, :)), 1, 4*4), 6);


%% DYNAMIC - DISCONTINUITY

% statistical analyses
permOwn_all = permutationAnalysis(10000, ...
    reshape(squeeze(dynArray(qo, 1, :)), 1, 4*12), ...
    reshape(squeeze(dynArray(qo, 2, :)), 1, 4*12)); % ownership

[~,ksOwn_all] = kstest2(reshape(squeeze(dynArray(qo, 1, :)), 1, 4*12), ...
    reshape(squeeze(dynArray(qo, 2, :)), 1, 4*12)); % ownership

% groups analysis
[r,pcorr] = corrcoef(mean(squeeze(dynArray(qo, 1, :))), ...
    mean(squeeze(dynArray(qo, 2, :))));

permGroups = permutation_byGroups(10000, dynLow, dynMed, dynHig, ...
    squeeze(dynArray(qo, 1, :)), ...
    squeeze(dynArray(qo, 2, :)));

% age analysis
permOwn_y = permutationAnalysis_diffSize(10000, ... % under 40
    reshape(squeeze(dyn_y(qo, 1, :)), 1, 4*8), ...
    reshape(squeeze(dyn_y(qo, 2, :)), 1, 4*8));

permOwn_o = permutationAnalysis_diffSize(10000, ... % over 40
    reshape(squeeze(dyn_o(qo, 1, :)), 1, 4*4), ...
    reshape(squeeze(dyn_o(qo, 2, :)), 1, 4*4));

permOwn_agebas = permutationAnalysis_diffSize(10000, ... % basal dynamic age
    reshape(squeeze(dyn_y(qo, 1, :)), 1, 4*8), ...
    reshape(squeeze(dyn_o(qo, 1, :)), 1, 4*4));

permOwn_ageman = permutationAnalysis_diffSize(10000, ... % discon dynamic age
    reshape(squeeze(dyn_y(qo, 2, :)), 1, 4*8), ...
    reshape(squeeze(dyn_o(qo, 2, :)), 1, 4*4));

[~,ksOwn_y] = kstest2(reshape(squeeze(dyn_y(qo, 1, :)), 1, 4*8), ... % under 40
    reshape(squeeze(dyn_y(qo, 2, :)), 1, 4*8));

[~,ksOwn_o] = kstest2(reshape(squeeze(dyn_o(qo, 1, :)), 1, 4*4), ... % over 40
    reshape(squeeze(dyn_o(qo, 2, :)), 1, 4*4));

[~,ksOwn_agebas] = kstest2(reshape(squeeze(dyn_y(qo, 1, :)), 1, 4*8), ... % basal dynamic age
    reshape(squeeze(dyn_o(qo, 1, :)), 1, 4*4));

[~,ksOwn_ageman] = kstest2(reshape(squeeze(dyn_y(qo, 2, :)), 1, 4*8), ... % discon dynamic age
    reshape(squeeze(dyn_o(qo, 2, :)), 1, 4*4));

% plot the figures
fig_mean_distributions(1, ...                               % all_questionnaire
    reshape(squeeze(dynArray(qo, 1, :)), 1, 4*12), ...
    reshape(squeeze(dynArray(qo, 2, :)), 1, 4*12), 6);

fig = figure(2); clf;                                       %  correlation
set(fig, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);
plot(mean(squeeze(dynArray(qo, 1, :))), ...
    mean(squeeze(dynArray(qo, 2, :))), 'ok'); hold on,
line([0 8], [0 8]);
xlim([0.5 7.5]);  ylim([0.5 7.5]);

fig_mean_distributions(3, reshape(squeeze(dyn_y(qo, 1, :)), 1, 4*8), ... % under 40
    reshape(squeeze(dyn_y(qo, 2, :)), 1, 4*8), 6);

fig_mean_distributions(4, reshape(squeeze(dyn_o(qo, 1, :)), 1, 4*4), ... % over 40
    reshape(squeeze(dyn_o(qo, 2, :)), 1, 4*4), 6);

fig_mean_distributions(5, reshape(squeeze(dyn_y(qo, 1, :)), 1, 4*8), ... % basal dynamic age
    reshape(squeeze(dyn_o(qo, 1, :)), 1, 4*4), 6);

fig_mean_distributions(6, reshape(squeeze(dyn_y(qo, 2, :)), 1, 4*8), ... % discon dynamic age
    reshape(squeeze(dyn_o(qo, 2, :)), 1, 4*4), 6);


%% DYNAMIC - NOISE Action

% statistical analyses
permOwn_all = permutationAnalysis(10000, ...
    reshape(squeeze(dynArray(qo, 1, :)), 1, 4*12), ...
    reshape(squeeze(dynArray(qo, 3, :)), 1, 4*12)); % ownership

[~,ksOwn_all] = kstest2(reshape(squeeze(dynArray(qo, 1, :)), 1, 4*12), ...
    reshape(squeeze(dynArray(qo, 3, :)), 1, 4*12)); % ownership

% groups analysis
[r,pcorr] = corrcoef(mean(squeeze(dynArray(qo, 1, :))), ...
    mean(squeeze(dynArray(qo, 3, :))));

permGroups = permutation_byGroups(10000, dynLow, dynMed, dynHig, ...
    squeeze(dynArray(qo, 1, :)), ...
    squeeze(dynArray(qo, 3, :)));

% age analysis
permOwn_y = permutationAnalysis_diffSize(10000, ... % under 40
    reshape(squeeze(dyn_y(qo, 1, :)), 1, 4*8), ...
    reshape(squeeze(dyn_y(qo, 3, :)), 1, 4*8));

permOwn_o = permutationAnalysis_diffSize(10000, ... % over 40
    reshape(squeeze(dyn_o(qo, 1, :)), 1, 4*4), ...
    reshape(squeeze(dyn_o(qo, 3, :)), 1, 4*4));

permOwn_agebas = permutationAnalysis_diffSize(10000, ... % basal dynamic age
    reshape(squeeze(dyn_y(qo, 1, :)), 1, 4*8), ...
    reshape(squeeze(dyn_o(qo, 1, :)), 1, 4*4));

permOwn_ageman = permutationAnalysis_diffSize(10000, ... % discon dynamic age
    reshape(squeeze(dyn_y(qo, 3, :)), 1, 4*8), ...
    reshape(squeeze(dyn_o(qo, 3, :)), 1, 4*4));

[~,ksOwn_y] = kstest2(reshape(squeeze(dyn_y(qo, 1, :)), 1, 4*8), ... % under 40
    reshape(squeeze(dyn_y(qo, 3, :)), 1, 4*8));

[~,ksOwn_o] = kstest2(reshape(squeeze(dyn_o(qo, 1, :)), 1, 4*4), ... % over 40
    reshape(squeeze(dyn_o(qo, 3, :)), 1, 4*4));

[~,ksOwn_agebas] = kstest2(reshape(squeeze(dyn_y(qo, 1, :)), 1, 4*8), ... % basal dynamic age
    reshape(squeeze(dyn_o(qo, 1, :)), 1, 4*4));

[~,ksOwn_ageman] = kstest2(reshape(squeeze(dyn_y(qo, 3, :)), 1, 4*8), ... % discon dynamic age
    reshape(squeeze(dyn_o(qo, 3, :)), 1, 4*4));

% plot the figures
fig_mean_distributions(1, ...                               % all_questionnaire
    reshape(squeeze(dynArray(qo, 1, :)), 1, 4*12), ...
    reshape(squeeze(dynArray(qo, 3, :)), 1, 4*12), 6);

fig = figure(2); clf;                                       %  correlation
set(fig, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);
plot(mean(squeeze(dynArray(qo, 1, :))), ...
    mean(squeeze(dynArray(qo, 3, :))), 'ok'); hold on,
line([0 8], [0 8]);
xlim([0.5 7.5]);  ylim([0.5 7.5]);

fig_mean_distributions(3, reshape(squeeze(dyn_y(qo, 1, :)), 1, 4*8), ... % under 40
    reshape(squeeze(dyn_y(qo, 3, :)), 1, 4*8), 6);

fig_mean_distributions(4, reshape(squeeze(dyn_o(qo, 1, :)), 1, 4*4), ... % over 40
    reshape(squeeze(dyn_o(qo, 3, :)), 1, 4*4), 6);

fig_mean_distributions(5, reshape(squeeze(dyn_y(qo, 1, :)), 1, 4*8), ... % basal dynamic age
    reshape(squeeze(dyn_o(qo, 1, :)), 1, 4*4), 6);

fig_mean_distributions(6, reshape(squeeze(dyn_y(qo, 3, :)), 1, 4*8), ... % discon dynamic age
    reshape(squeeze(dyn_o(qo, 3, :)), 1, 4*4), 6);