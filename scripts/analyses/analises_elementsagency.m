% ANALZELEMAGENCY takes the results from the datasets that included noise
% and analyzes the differences between noise and no-noise conditions.
addpath('..\');
addpath('..\getData\');
addpath('..\figures\');
addpath('..\statistics\');


%% Formatting variables
axis_fontsize = 15;
tick_fontsize = 13;
title_fontsize = 17;

line_colorgrey = [211/256 211/256 211/256];


%% get the data
config; [~, cube_pilots] = get_data_pilots (); % first Pilots

[cube_ar_inverted, ~] = get_data_ar (); 
[cube_ar] = invertLScube (cube_ar_inverted); % Ar Event

[~, dynamic_array] = get_data (1);


%% Variables for local and outcome agency
quest_local_pilots = 7:8;
quest_local_ar = 3;
quest_outcome_pilots = 9;
quest_outcome_ar = 4;

cond_nonoise_pilots = 1;
cond_nonoise_ar = 1;
cond_noise_pilots = 3;
cond_noise_ar = 2;

it = 10000;

local_nonoise_pilots = ...
    squeeze(cube_pilots(quest_local_pilots, cond_nonoise_pilots, :));
local_nonoise_ar = ...
    squeeze(cube_ar(cond_nonoise_ar, quest_local_ar, :));
local_noise_pilots = ...
    squeeze(cube_pilots(quest_local_pilots, cond_noise_pilots, :));
local_noise_ar = ...
    squeeze(cube_ar(cond_noise_ar, quest_local_ar, :));

outcome_nonoise_pilots = ...
    squeeze(cube_pilots(quest_outcome_pilots, cond_nonoise_pilots, :));
outcome_nonoise_ar = ...
    squeeze(cube_ar(cond_nonoise_ar, quest_outcome_ar,:));
outcome_noise_pilots = ...
    squeeze(cube_pilots(quest_outcome_pilots, cond_noise_pilots, :));
outcome_noise_ar = ...
    squeeze(cube_ar(cond_noise_ar, quest_outcome_ar, :));

local_exp = [...
    dynamic_array(quest_local_pilots, 2, :); % no noise
    dynamic_array(quest_local_pilots, 5, :); % noise
    ];
    
outcome_exp = [...
    dynamic_array(quest_outcome_pilots, 2, :); % no noise
    dynamic_array(quest_outcome_pilots, 5, :); % noise
    ];


%% make common matrices for all the conditions

local_nonoise_all = [mean(local_nonoise_pilots), local_nonoise_ar'];
local_noise_all = [mean(local_noise_pilots), local_noise_ar'];

outcome_nonoise_all = [outcome_nonoise_pilots', outcome_nonoise_ar'];
outcome_noise_all = [outcome_noise_pilots', outcome_noise_ar'];


%% Bootstrapping


% ar event + pilots
pval_local = stat_bootstrapping(it, local_nonoise_all, local_noise_all);
pval_outcome = stat_bootstrapping(it, outcome_nonoise_all, outcome_noise_all);


%% Box plot with the results

fig1 = figure(1);
subplot(1, 2, 1)

boxplot([local_nonoise_all', local_noise_all']);

text(2.1, 0.75, strcat('p-val= ', num2str(pval_local)), 'FontSize', 8);
text(0.95, 0.25, 'No noise'); text(1.95, 0.25, 'Noise');
line([0 3], [4 4], 'LineStyle', ':', 'Color', line_colorgrey);

title('Bodily agency', 'FontWeight', 'bold', 'FontSize', 11);
ylim([0.5 7.5]);
set(gca,'XTickLabel', {''; ''});
xlabel('Conditions', 'FontWeight', 'bold', 'FontSize', 10);
ylabel('Questionnaire responses', 'FontWeight', 'bold', 'FontSize', 10)

subplot(1, 2, 2)

boxplot([outcome_nonoise_all', outcome_noise_all']);

text(2.1, 0.75, strcat('p= ', num2str(pval_outcome)), 'FontSize', 8);
text(0.95, 0.25, 'No noise'); text(1.95, 0.25, 'Noise');
line([0 3], [4 4], 'LineStyle', ':', 'Color', line_colorgrey);

title('Outcome agency', 'FontWeight', 'bold', 'FontSize', 11);
ylim([0.5 7.5]);
set(gca,'XTickLabel', {''; ''});
xlabel('Conditions', 'FontWeight', 'bold', 'FontSize', 10);
ylabel('Questionnaire responses', 'FontWeight', 'bold', 'FontSize', 10)


set(fig1,'units','normalized', 'Position', [0.1 0.1 0.75 0.55])


%% Plot the distributions
c = parula;
c  =  c([9 18 50 60], :);

edge = 1:1:7;
h1 = hist(local_nonoise_all, edge);
h2 = hist(local_noise_all, edge);
h3 = hist(outcome_nonoise_all, edge);
h4 = hist(outcome_noise_all,edge);


fig2 = figure(2);
plot(edge, h1/38, 'color', c(1, :), 'LineWidth', 5); hold on,
plot(edge, h2/38, 'color', c(2, :), 'LineWidth', 5, 'LineStyle', ':');
plot(edge, h3/38, 'color', c(4, :), 'LineWidth', 5);
plot(edge, h4/38, 'color', c(3, :), 'LineWidth', 5, 'LineStyle', ':');
hold off,

xlim([0.5 7.5]);
ylim([-0.025 0.55]);

line([0 8],[0 0], 'LineStyle', ':', 'color', line_colorgrey);

fig3 = figure(3);
subplot(1, 2, 1)
plot(edge, h1/38, 'color', c(1, :), 'LineWidth', 5); hold on,
plot(edge, h2/38, 'color', c(2, :), 'LineWidth', 5, 'LineStyle', ':'); hold off,

xlim([0.5 7.5]);
ylim([-0.025 0.55]);
xlabel('questionnaire responses', 'FontSize', axis_fontsize, 'FontWeight', 'bold');
ylabel('probability density', 'FontSize', axis_fontsize, 'FontWeight', 'bold');
set(gca, 'FontSize', 12, 'FontWeight', 'bold');

title('agency over movement', 'FontSize', title_fontsize, 'FontWeight', 'bold');
line([mean(local_nonoise_all), mean(local_nonoise_all)], [-0.1 0.6], ...
    'LineStyle', '-', 'color', c(1, :));
line([mean(local_noise_all), mean(local_noise_all)], [-0.1 0.6], ...
    'LineStyle', '--', 'color', c(2, :));
line([0 8],[0 0], 'LineStyle', ':', 'color', line_colorgrey);

legend({'without noise', 'with noise', 'mean without noise',...
    'mean with noise'}, 'location', 'northwest');

text(0.75, 0.4, strcat('p-val =', num2str(pval_local, '%.3f')), 'FontSize', 12);

subplot(1, 2, 2)
plot(edge, h3/38, 'color', c(4, :), 'LineWidth', 5); hold on,
plot(edge, h4/38, 'color', c(3, :), 'LineWidth', 5, 'LineStyle', ':'); hold off,

title('agency over outcome', 'FontSize', title_fontsize, 'FontWeight', 'bold');
xlim([0.5 7.5]);
ylim([-0.025 0.55]);
xlabel('questionnaire responses', 'FontSize', axis_fontsize, 'FontWeight', 'bold');
ylabel('probability density', 'FontSize', axis_fontsize, 'FontWeight', 'bold');
set(gca, 'FontSize', 12, 'FontWeight', 'bold');

line([mean(outcome_nonoise_all), mean(outcome_nonoise_all)], [-0.1 0.6], ...
    'LineStyle', '-', 'color', c(4, :));
line([mean(outcome_noise_all), mean(outcome_noise_all)], [-0.1 0.6], ...
    'LineStyle', '--', 'color', c(3, :));
line([0 8],[0 0], 'LineStyle', ':', 'color', line_colorgrey);

legend({'without noise', 'with noise', 'mean without noise',...
    'mean with noise'}, 'location', 'northwest');

text(0.75, 0.4, strcat('p =', num2str(pval_outcome, '%.3f')), 'FontSize', 12);


set(fig3,'units','normalized', 'Position', [0.1 0.1 0.75 0.55])

% fig4 = figure(4);
%
% [f1, xi1] = ksdensity(local_nonoise_all);
% [f2, xi2] = ksdensity(local_noise_all);
%
% plot(xi1, f1); hold on,
% plot (xi2, f2); hold off


%% Correlations - questions

fig5 = figure(5);
subplot(1, 2, 1)
plot(local_nonoise_all', outcome_nonoise_all', 'og');
xlim([0.5 7.5]);
ylim([0.5 7.5]);

subplot(1, 2, 2)
plot(local_noise_all', outcome_noise_all', 'or');
xlim([0.5 7.5]);
ylim([0.5 7.5]);

%% Figure Experiment 1 - Frontiers in Human Neuroscience
pval_local_exp = ...
    stat_bootstrapping(it, squeeze(mean(local_exp(1:2, :, :)))', ...
    squeeze(mean(local_exp(3:4, :, :)))'); 
pval_outcome_exp = ...
    stat_bootstrapping(it, outcome_exp(1, :), outcome_exp(2, :));

[h_local, p_local] = kstest2(squeeze(mean(local_exp(1:2, :, :)))', ...
    squeeze(mean(local_exp(3:4, :, :)))');

[h_outcome, p_outcome] = kstest2(outcome_exp(1, :), outcome_exp(2, :));

fig6 = figure(6); clf;
subplot(1, 2, 1)
fig_distributions(squeeze(mean(local_exp(1:2, :, :)))', ...
    squeeze(mean(local_exp(3:4, :, :)))', 1, 6, 22, ...
    mean(mean(local_exp(1:2, :, :))), mean(mean(local_exp(3:4))), 12, ...
    pval_local_exp, p_local);
legend({'without noise', 'with noise'}, 'location', 'northwest');

subplot(1, 2, 2)
fig_distributions(squeeze(outcome_exp(1, :, :)), ...
    squeeze(outcome_exp(2, :, :)), 9, 13, 22, ...
    mean(outcome_exp(1, :, :)), mean(outcome_exp(2)), 12, ...
    pval_outcome_exp, p_outcome);
legend({'without noise', 'with noise'}, 'location', 'northwest');

set(fig6,'units','normalized', 'Position', [0.1 0.1 0.75 0.55]);
