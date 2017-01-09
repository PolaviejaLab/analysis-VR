%% Get data

addpath('V:\Data\04. Exp1_Frontiers');
addpath('..\getData\');

[~, dyn_array] = get_data (1);


%% load matrix
mat_gsrslopes = load('mat_slopes.mat');


%% Set the variables
q_ownership = 1:4;
q_agency = 7:9;
q_order = [2 3 4 5]; % kov kor gap noise
gsr_order = [2 1 3 4]; % kov kor gap noise


%% Matrices
% Matrices of 3 * 20
% row 1 = gsr
% row 2 = ownership, means
% row 3 = agency, means

% Knife on Virtual
mat_kov = [...
    mat_gsrslopes.mat_slopes(:, gsr_order(1))';
    mean(squeeze(dyn_array(q_ownership, q_order(1), 1:20)));
    mean(squeeze(dyn_array(q_agency, q_order(1), 1:20)));
    ];

% Knife on real
mat_kor = [...
    mat_gsrslopes.mat_slopes(:, gsr_order(2))';
    mean(squeeze(dyn_array(q_ownership, q_order(2), 1:20)));
    mean(squeeze(dyn_array(q_agency, q_order(2), 1:20)));
    ];

% Gap
mat_gap = [...
    mat_gsrslopes.mat_slopes(:, gsr_order(3))';
    mean(squeeze(dyn_array(q_ownership, q_order(3), 1:20)));
    mean(squeeze(dyn_array(q_agency, q_order(3), 1:20)));
    ];

% Noise
mat_noise = [...
    mat_gsrslopes.mat_slopes(:, gsr_order(4))';
    mean(squeeze(dyn_array(q_ownership, q_order(4), 1:20)));
    mean(squeeze(dyn_array(q_agency, q_order(4), 1:20)));
    ];


%% Correlations

[r_1, p_1] = corr(mat_kov(1, :)', mat_kov(2, :)');
[r_2, p_2] = corr(mat_kor(1, :)', mat_kor(2, :)');
[r_3, p_3] = corr(mat_gap(1, :)', mat_gap(2, :)');
[r_4, p_4] = corr(mat_noise(1, :)', mat_noise(2, :)');

[r_5, p_5] = corr(mat_kov(1, :)', mat_kov(3, :)');
[r_6, p_6] = corr(mat_kor(1, :)', mat_kor(3, :)');
[r_7, p_7] = corr(mat_gap(1, :)', mat_gap(3, :)');
[r_8, p_8] = corr(mat_noise(1, :)', mat_noise(3, :)');

[r_9, p_9] = corr(mat_kov(2, :)', mat_kov(3, :)');
[r_10, p_10] = corr(mat_kor(2, :)', mat_kor(3, :)');
[r_11, p_11] = corr(mat_gap(2, :)', mat_gap(3, :)');
[r_12, p_12] = corr(mat_noise(2, :)', mat_noise(3, :)');



% GSR vs ownership
fig1 = figure(1); clf; hold on;
subplot(2, 2, 1)
scatter(mat_kov(1, :), mat_kov(2, :), 'ko');
subplot(2, 2, 2)
scatter(mat_kor(1, :), mat_kor(2, :), 'bo');
subplot(2, 2, 3)
scatter(mat_gap(1, :), mat_gap(2, :), 'go');
subplot(2, 2, 4)
scatter(mat_noise(1, :), mat_noise(2, :), 'ro'); hold off;

% GSR vs agency
fig2 = figure(2); clf; hold on;
subplot(2, 2, 1)
scatter(mat_kov(1, :), mat_kov(3, :), 'ko');
subplot(2, 2, 2)
scatter(mat_kor(1, :), mat_kor(3, :), 'bo');
subplot(2, 2, 3)
scatter(mat_gap(1, :), mat_gap(3, :), 'go');
subplot(2, 2, 4)
scatter(mat_noise(1, :), mat_noise(3, :), 'ro'); hold off;

% Ownership vs agency
fig3 = figure(3); clf; hold on;
subplot(2, 2, 1)
scatter(mat_kov(2, :), mat_kov(3, :), 'ko');
subplot(2, 2, 2)
scatter(mat_kor(2, :), mat_kor(3, :), 'bo');
subplot(2, 2, 3)
scatter(mat_gap(2, :), mat_gap(3, :), 'go');
subplot(2, 2, 4)
scatter(mat_noise(2, :), mat_noise(3, :), 'ro'); hold off;


%%
% legend ({'knife on virtual', 'knife on real', 'gap', 'noise'});
% 
% xlim([-4, 2]);
% set(gca, 'XTick', -4:0.5:1.5);
% ylim([-4, 2.5]);
% set(gca, 'YTick', -4:0.5:2);
% line([9 -4], [9 -4], 'color', [0.827451 0.827451 0.827451]);
% line ([0 0],[-4 10], 'color', [0.827451 0.827451 0.827451]);
% line ([-4 10],[0 0], 'color', [0.827451 0.827451 0.827451]);

