addpath('..\getData\');
addpath('..\figures\');
addpath('..\figures\formatting\');
addpath('..\statistics\');


%% get the data
[stat_array, dyn_array] = get_data (1);


%% Declare Question Number
nOwnership = 1:4;
nAgency = 7:9;
nLocation_static = 8;
nLocation_dynamic = 13:14;

% nSimilar = 5;
% nControlOw_static = 6:7;
% nControlOw_dynamic = 6;
% nControlAg = 10:12;

nParticipants = size(stat_array, 3);
ii = 10000;          % number of iterations


%% Static
n_elements_ow = numel(squeeze(stat_array(nOwnership, 1, :)));
n_elements_locs = numel(squeeze(stat_array(nLocation_static, 1, :)));

mat_stat_own = [...
    reshape(squeeze(stat_array(nOwnership, 1, :)), 1, ...
    numel(squeeze(stat_array(nOwnership, 1, :)))); % no gap
    reshape(squeeze(stat_array(nOwnership, 2, :)), 1, ...
    numel(squeeze(stat_array(nOwnership, 2, :)))); % gap
    ];

mat_stat_loc = [...
    reshape(squeeze(stat_array(nLocation_static, 1, :)), 1, ...
    numel(squeeze(stat_array(nLocation_static, 1, :)))); % no gap
    reshape(squeeze(stat_array(nLocation_static, 2, :)), 1, ...
    numel(squeeze(stat_array(nLocation_static, 2, :)))); % gap
    ];

mn_stat_own = [...
    mean(mat_stat_own(1, :));
    mean(mat_stat_own(2, :));
    ];

std_stat_own = [...
    std(mat_stat_own(1, :));
    std(mat_stat_own(2, :));
    ];

mn_stat_loc = [...
    mean(mat_stat_loc(1, :));
    mean(mat_stat_loc(2, :));
    ];

std_stat_agn = [...
    std(mat_stat_loc(1, :));
    std(mat_stat_loc(2, :));
    ];

pval_stat_own = stat_bootstrapping(ii, mat_stat_own(1, :), mat_stat_own(2, :));
pval_stat_loc = stat_bootstrapping(ii, mat_stat_loc(1, :), mat_stat_loc(2, :));

[~, ow_stat_p] = kstest2(mat_stat_own(1, :), mat_stat_own(2, :));

fig1 = figure(1); clf;
legend_font = 12;
axis_font = 16;
title_font = 18;
fig_distributions(mat_stat_own(1, :), mat_stat_own(2, :), 2, 9, ...
    n_elements_ow, mn_stat_own(1, :), mn_stat_own(2, :), axis_font, ...
    pval_stat_own, ow_stat_p);

title('static block - ownership', 'FontSize', title_font, 'FontWeight', 'bold');
legend({'no gap', 'gap'}, 'location', 'northwest', 'FontSize', legend_font);
set(fig1,'units','normalized', 'Position', [0.15 0 0.48 0.75]);


%% Dynamic - ownership
mat_dyn_own = [... 
    reshape(squeeze(dyn_array(nOwnership, 1, :)), 1, ...
    numel(squeeze(dyn_array(nOwnership, 1, :)))); % no gap    
    reshape(squeeze(dyn_array(nOwnership, 2, :)), 1, ...
    numel(squeeze(dyn_array(nOwnership, 2, :)))); % offset = 10 cm
    reshape(squeeze(dyn_array(nOwnership, 3, :)), 1, ...
    numel(squeeze(dyn_array(nOwnership, 3, :)))); % knife on real
    reshape(squeeze(dyn_array(nOwnership, 4, :)), 1, ...
    numel(squeeze(dyn_array(nOwnership, 4, :)))); % gap
    reshape(squeeze(dyn_array(nOwnership, 5, :)), 1, ...
    numel(squeeze(dyn_array(nOwnership, 5, :)))); % noise
    ];

mn_dyn_own = [...
    mean(mat_dyn_own(1, :)); % control
    mean(mat_dyn_own(2, :)); % offset = 10 cm
    mean(mat_dyn_own(3, :)); % knife on real
    mean(mat_dyn_own(4, :)); % gap
    mean(mat_dyn_own(5, :)); % noise
    ];

std_dyn_own = [...
    std(mat_dyn_own(1, :)); % control
    std(mat_dyn_own(2, :)); % offset = 10 cm
    std(mat_dyn_own(3, :)); % knife on real
    std(mat_dyn_own(4, :)); % gap
    std(mat_dyn_own(5, :)); % noise
    ];

pval_dyn_own_bs = [...
    stat_bootstrapping(ii, mat_dyn_own(2, :), mat_dyn_own(1, :));
    stat_bootstrapping(ii, mat_dyn_own(2, :), mat_dyn_own(3, :));
    stat_bootstrapping(ii, mat_dyn_own(2, :), mat_dyn_own(4, :));
    stat_bootstrapping(ii, mat_dyn_own(2, :), mat_dyn_own(5, :));
    stat_bootstrapping(ii, mat_dyn_own(4, :), mat_dyn_own(5, :));
    ];

[~, ow_dyn_1_p] = kstest2(mat_dyn_own(2, :), mat_dyn_own(1, :));
[~, ow_dyn_2_p] = kstest2(mat_dyn_own(2, :), mat_dyn_own(3, :));
[~, ow_dyn_3_p] = kstest2(mat_dyn_own(2, :), mat_dyn_own(4, :));
[~, ow_dyn_4_p] = kstest2(mat_dyn_own(2, :), mat_dyn_own(5, :));
[~, ow_dyn_5_p] = kstest2(mat_dyn_own(4, :), mat_dyn_own(5, :));

fig2 = figure(2); clf;
legend_font = 11;
axis_font = 12;
title_font = 14;
subplot(2, 2, 1);
fig_distributions(mat_dyn_own(2, :), mat_dyn_own(1, :), 2, 5, ...
    n_elements_ow, mn_dyn_own(2, :), mn_dyn_own(1, :), ...
    axis_font, pval_dyn_own_bs(1, :), ow_dyn_1_p);
title('dynamic block - ownership', 'FontSize', title_font, 'FontWeight', 'bold');
legend({'control', 'no offset'}, 'location', 'northwest', 'FontSize', legend_font);

subplot(2, 2, 2);
fig_distributions(mat_dyn_own(2, :), mat_dyn_own(3, :), 2, 7, ...
    n_elements_ow, mn_dyn_own(2, :), mn_dyn_own(3, :), ...
    axis_font, pval_dyn_own_bs(2, :), ow_dyn_2_p);
title('dynamic block - ownership', 'FontSize', title_font, 'FontWeight', 'bold');
legend({'control', 'knife on real'}, 'location', 'northwest', 'FontSize', legend_font);

subplot(2, 2, 3);
fig_distributions(mat_dyn_own (2, :), mat_dyn_own (4, :), 2, 9, ...
    n_elements_ow, mn_dyn_own(2, :), mn_dyn_own(4, :), ...
    axis_font, pval_dyn_own_bs(3, :), ow_dyn_3_p);
title('dynamic block - ownership', 'FontSize', title_font, 'FontWeight', 'bold');
legend({'control', 'gap'}, 'location', 'northwest', 'FontSize', legend_font);

subplot(2, 2, 4);
fig_distributions(mat_dyn_own(2, :), mat_dyn_own(5, :), 2, 11, ...
    n_elements_ow, mn_dyn_own(2, :), mn_dyn_own(5, :), ...
    axis_font, pval_dyn_own_bs(4, :), ow_dyn_4_p);
title('dynamic block - ownership', 'FontSize', title_font, 'FontWeight', 'bold');
legend({'control', 'noise'}, 'location', 'northwest', 'FontSize', legend_font);

set(fig2,'units','normalized', 'Position', [0.15 0 0.61 0.93]);

fig10 = figure(10); clf;
fig_distributions(mat_dyn_own(4, :), mat_dyn_own(5, :), 9, 11, ...
    n_elements_ow, mn_dyn_own(4, :), mn_dyn_own(5, :), ...
    axis_font, pval_dyn_own_bs(5, :), ow_dyn_5_p);
title('dynamic block - ownership', 'FontSize', title_font, 'FontWeight', 'bold');
legend({'gap', 'noise'}, 'location', 'northwest', 'FontSize', legend_font);


%% Dynamic - agency
n_elements_ag = numel(squeeze(dyn_array(nAgency, 1, :)));

mat_dyn_agn = [... % mean per subject
    reshape(squeeze(dyn_array(nAgency, 1, :)), 1, ...
    numel(squeeze(dyn_array(nAgency, 1, :)))); % control
    reshape(squeeze(dyn_array(nAgency, 2, :)), 1, ...
    numel(squeeze(dyn_array(nAgency, 2, :)))); % offset = 10 cm
    reshape(squeeze(dyn_array(nAgency, 3, :)), 1, ...
    numel(squeeze(dyn_array(nAgency, 3, :)))); % knife on real
    reshape(squeeze(dyn_array(nAgency, 4, :)), 1, ...
    numel(squeeze(dyn_array(nAgency, 4, :)))); % gap
    reshape(squeeze(dyn_array(nAgency, 5, :)), 1, ...
    numel(squeeze(dyn_array(nAgency, 5, :)))); % noise
    ];

mn_dyn_agn = [...
    mean(mat_dyn_agn(1, :)); % control
    mean(mat_dyn_agn(2, :)); % offset = 10 cm
    mean(mat_dyn_agn(3, :)); % knife on real
    mean(mat_dyn_agn(4, :)); % gap
    mean(mat_dyn_agn(5, :)); % noise
    ];

std_dyn_agn = [...
    std(mat_dyn_agn(1, :)); % control
    std(mat_dyn_agn(2, :)); % offset = 10 cm
    std(mat_dyn_agn(3, :)); % knife on real
    std(mat_dyn_agn(4, :)); % gap
    std(mat_dyn_agn(5, :)); % noise
    ];

pval_dyn_agn_bs = [ ...
    stat_bootstrapping(ii, mat_dyn_agn(2, :), mat_dyn_agn(1, :));
    stat_bootstrapping(ii, mat_dyn_agn(2, :), mat_dyn_agn(3, :));
    stat_bootstrapping(ii, mat_dyn_agn(2, :), mat_dyn_agn(4, :));
    stat_bootstrapping(ii, mat_dyn_agn(2, :), mat_dyn_agn(5, :));
    stat_bootstrapping(ii, mat_dyn_agn(4, :), mat_dyn_agn(5, :));
    ];

[~, ag_dyn_1_p] = kstest2(mat_dyn_agn(2, :), mat_dyn_agn(1, :));
[~, ag_dyn_2_p] = kstest2(mat_dyn_agn(2, :), mat_dyn_agn(3, :));
[~, ag_dyn_3_p] = kstest2(mat_dyn_agn(2, :), mat_dyn_agn(4, :));
[~, ag_dyn_4_p] = kstest2(mat_dyn_agn(2, :), mat_dyn_agn(5, :));
[~, ag_dyn_5_p] = kstest2(mat_dyn_agn(4, :), mat_dyn_agn(5, :));


fig3 = figure(3); clf;
subplot(2, 2, 1);
fig_distributions(mat_dyn_agn(2, :), mat_dyn_agn (1, :), 2, 5, ...
    n_elements_ag, mn_dyn_agn(2, :), mn_dyn_agn (1, :), ...
    12, pval_dyn_agn_bs(1, :), ag_dyn_1_p);
title('dynamic block - agency', 'FontSize', 14, 'FontWeight', 'bold');
legend({'control', 'no offset'}, 'location', 'northwest', 'FontSize', 11);

subplot(2, 2, 2);
fig_distributions(mat_dyn_agn (2, :), mat_dyn_agn (3, :), 2, 7, ...
    n_elements_ag, mn_dyn_agn(2, :), mn_dyn_agn(3, :), ...
    12, pval_dyn_agn_bs(2, :), ag_dyn_2_p);
title('dynamic block - agency', 'FontSize', 14, 'FontWeight', 'bold');
legend({'control', 'knife on real'}, 'location', 'northwest', 'FontSize', 11);

subplot(2, 2, 3);
fig_distributions(mat_dyn_agn (2, :), mat_dyn_agn (4, :), 2, 9, ...
    n_elements_ag, mn_dyn_agn(2, :), mn_dyn_agn(4, :), ...
    12, pval_dyn_agn_bs(3, :), ag_dyn_3_p);
title('dynamic block - agency', 'FontSize', 14, 'FontWeight', 'bold');
legend({'control', 'gap'}, 'location', 'northwest', 'FontSize', 11);

subplot(2, 2, 4);
fig_distributions(mat_dyn_agn (2, :), mat_dyn_agn (5, :), 2, 11, ...
    n_elements_ag, mn_dyn_agn(2, :), mn_dyn_agn(5, :), ...
    12, pval_dyn_agn_bs(4, :), ag_dyn_4_p);
title('dynamic block - agency', 'FontSize', 14, 'FontWeight', 'bold');
legend({'control', 'noise'}, 'location', 'northwest', 'FontSize', 11);

set(fig3,'units','normalized', 'Position', [0.15 0 0.61 0.93]);

fig11 = figure(11); clf;
fig_distributions(mat_dyn_agn(4, :), mat_dyn_agn(5, :), 9, 11, ...
    n_elements_ag, mn_dyn_agn(4, :), mn_dyn_agn(5, :), ...
    axis_font, pval_dyn_agn_bs(5, :), ag_dyn_5_p);
title('dynamic block - agency', 'FontSize', title_font, 'FontWeight', 'bold');
legend({'gap', 'noise'}, 'location', 'northwest', 'FontSize', legend_font);


%% Dynamic - Location
mat_dyn_loc = [... 
    reshape(squeeze(dyn_array(nLocation_dynamic, 1, :)), 1, ...
    numel(squeeze(dyn_array(nLocation_dynamic, 1, :)))); % no gap    
    reshape(squeeze(dyn_array(nLocation_dynamic, 2, :)), 1, ...
    numel(squeeze(dyn_array(nLocation_dynamic, 2, :)))); % offset = 10 cm
    reshape(squeeze(dyn_array(nLocation_dynamic, 3, :)), 1, ...
    numel(squeeze(dyn_array(nLocation_dynamic, 3, :)))); % knife on real
    reshape(squeeze(dyn_array(nLocation_dynamic, 4, :)), 1, ...
    numel(squeeze(dyn_array(nLocation_dynamic, 4, :)))); % gap
    reshape(squeeze(dyn_array(nLocation_dynamic, 5, :)), 1, ...
    numel(squeeze(dyn_array(nLocation_dynamic, 5, :)))); % noise
    ];

mn_dyn_loc = [...
    mean(mat_dyn_loc(1, :)); % control
    mean(mat_dyn_loc(2, :)); % offset = 10 cm
    mean(mat_dyn_loc(3, :)); % knife on real
    mean(mat_dyn_loc(4, :)); % gap
    mean(mat_dyn_loc(5, :)); % noise
    ];

std_dyn_loc = [...
    std(mat_dyn_loc(1, :)); % control
    std(mat_dyn_loc(2, :)); % offset = 10 cm
    std(mat_dyn_loc(3, :)); % knife on real
    std(mat_dyn_loc(4, :)); % gap
    std(mat_dyn_loc(5, :)); % noise
    ];

pval_stat_loc = ...
    stat_bootstrapping(ii, mat_stat_loc(1, :), mat_stat_loc(2, :));

pval_dyn_loc_bs = [...
    stat_bootstrapping(ii, mat_dyn_loc(2, :), mat_dyn_loc(1, :));
    stat_bootstrapping(ii, mat_dyn_loc(2, :), mat_dyn_loc(3, :));
    stat_bootstrapping(ii, mat_dyn_loc(2, :), mat_dyn_loc(4, :));
    stat_bootstrapping(ii, mat_dyn_loc(2, :), mat_dyn_loc(5, :));
];

% [~, pval_loc_dyn_ks1] = ...
%     kstest2(mat_dyn_loc(2, :), mat_dyn_loc(1, :));
% [~, pval_loc_dyn_ks2] = ...
%     kstest2(mat_dyn_loc(2, :), mat_dyn_loc(3, :));
% [~, pval_loc_dyn_ks3] = ...
%     kstest2(mat_dyn_loc(2, :), mat_dyn_loc(4, :));
% [~, pval_loc_dyn_ks4] = ...
%     kstest2(mat_dyn_loc(2, :), mat_dyn_loc(5, :));

%% New analyses - Correlations
own_stat_nogap = squeeze(stat_array(nOwnership, 1, :)); % stat no gap
own_stat_gap = squeeze(stat_array(nOwnership, 2, :)); % stat gap
own_dyn_nooffset = squeeze(dyn_array(nOwnership, 1, :)); % dyn nooffset
own_dyn_control = squeeze(dyn_array(nOwnership, 2, :)); % dyn no gap
own_dyn_kor = squeeze(dyn_array(nOwnership, 3, :)); % kor
own_dyn_gap = squeeze(dyn_array(nOwnership, 4, :)); % dyn gap
own_dyn_noise = squeeze(dyn_array(nOwnership, 5, :)); % dyn gap

agn_dyn_nooffset = squeeze(dyn_array(nAgency, 1, :)); % stat no gap
agn_dyn_control = squeeze(dyn_array(nAgency, 2, :)); % stat no gap
agn_dyn_kor = squeeze(dyn_array(nAgency, 3, :)); % stat no gap
agn_dyn_gap = squeeze(dyn_array(nAgency, 4, :)); % stat gap
agn_dyn_noise = squeeze(dyn_array(nAgency, 5, :)); % stat no gap

save('..\..\data\arrays_ownstat.mat', 'own_stat_nogap', 'own_stat_gap');
save('..\..\data\arrays_owndyn.mat', 'own_dyn_nooffset', ...
    'own_dyn_control', 'own_dyn_kor', 'own_dyn_gap', 'own_dyn_noise');
save('..\..\data\arrays_agndyn.mat', 'agn_dyn_nooffset', ...
    'agn_dyn_control', 'agn_dyn_kor', 'agn_dyn_gap', 'agn_dyn_noise');

p1 = polyfit(mean(own_stat_nogap), mean(own_dyn_control), 1);
p2 = polyfit(mean(own_stat_gap), mean(own_dyn_gap), 1);

x1 = mean(own_stat_nogap); y1 = polyval(p1, x1);
x2 = mean(own_stat_gap); y2 = polyval(p2, x2);

% compare nogap and gap in static and dynamioc
[R_nogap, p_nogap] = corrcoef(mean(own_stat_nogap), mean(own_dyn_control));
[R_gap, p_gap] = corrcoef(mean(own_stat_gap), mean(own_dyn_gap));

fig4 = figure(4); clf; hold on;
plot(mean(own_stat_nogap), mean(own_dyn_control), '.b', 'MarkerSize', 20); 
plot(mean(own_stat_gap), mean(own_dyn_gap), '.r', 'MarkerSize', 20); 
line([0 8],[0 8], 'Color', 'k', 'LineStyle', ':');
plot(x1, y1, 'Color', 'b');
plot(x2, y2, 'Color', 'r');
hold off; box on;

formatcorrelations(...
    [0.5 7.5], [0.5 7.5], 'reported answers static block', ...
    'reported answers dynamic block', 17); hold off, 
set(fig4,'units','normalized', 'Position', [0.15 0 0.48 0.75]);



p3 = polyfit(mean(own_dyn_control), mean(own_dyn_gap), 1);
p4 = polyfit(mean(agn_dyn_control), mean(agn_dyn_gap), 1);

x3 = mean(own_dyn_control); y3 = polyval(p3, x3);
x4 = mean(agn_dyn_control); y4 = polyval(p4, x4);

% compare nogap and gap in static and dynamic
[R_nogap_own, p_nogap_own] = corrcoef(mean(own_dyn_control), mean(own_dyn_gap));
[R_gap_own, p_gap_own] = corrcoef(mean(agn_dyn_control), mean(agn_dyn_gap));


fig5 = figure(5); clf; hold on;
plot(mean(own_dyn_control), mean(own_dyn_gap), '.b', 'MarkerSize', 20); 
plot(mean(agn_dyn_control),  mean(agn_dyn_gap), '.r', 'MarkerSize', 20); 
line([0 8],[0 8], 'Color', 'k', 'LineStyle', ':');
plot(x3, y3, 'Color', 'b');
plot(x4, y4, 'Color', 'r');
hold off; box on;

formatcorrelations(...
    [0.5 7.5], [0.5 7.5], 'reported answers gap ', ...
    'reported answers no gap', 17); hold off, 
set(fig4,'units','normalized', 'Position', [0.15 0 0.48 0.75]);


%% STD in the distributions
pval_std_stat_bs = ...
    stat_bootstrapping_std(ii, mat_stat_own(1, :), mat_stat_own(2, :));

pval_std_dyn_own_bs = [...
    stat_bootstrapping_std(ii, mat_dyn_own(2, :), mat_dyn_own(1, :));
    stat_bootstrapping_std(ii, mat_dyn_own(2, :), mat_dyn_own(3, :));
    stat_bootstrapping_std(ii, mat_dyn_own(2, :), mat_dyn_own(4, :));
    stat_bootstrapping_std(ii, mat_dyn_own(2, :), mat_dyn_own(5, :));    
    stat_bootstrapping_std(ii, mat_dyn_own(5, :), mat_dyn_own(1, :));
    stat_bootstrapping_std(ii, mat_dyn_own(5, :), mat_dyn_own(3, :));
    stat_bootstrapping_std(ii, mat_dyn_own(5, :), mat_dyn_own(4, :));
    ];

pval_std_dyn_agn_bs = [...
    stat_bootstrapping_std(ii, mat_dyn_agn(2, :), mat_dyn_agn(1, :));
    stat_bootstrapping_std(ii, mat_dyn_agn(2, :), mat_dyn_agn(3, :));
    stat_bootstrapping_std(ii, mat_dyn_agn(2, :), mat_dyn_agn(4, :)); 
    stat_bootstrapping_std(ii, mat_dyn_agn(2, :), mat_dyn_agn(5, :));
    stat_bootstrapping_std(ii, mat_dyn_agn(5, :), mat_dyn_agn(1, :));
    stat_bootstrapping_std(ii, mat_dyn_agn(5, :), mat_dyn_agn(3, :)); 
    stat_bootstrapping_std(ii, mat_dyn_agn(5, :), mat_dyn_agn(4, :));
    ];


%% CV
cv_stat_own = std_stat_own ./ mn_stat_own;
cv_dyn_own = std_dyn_own ./ mn_dyn_own;
cv_dyn_agn = std_dyn_agn ./ mn_dyn_agn;

pval_cv_stat_own_bs = ...
    stat_bootstrapping_cv(ii, mat_stat_own(1, :), mat_stat_own(2, :));

pval_cv_dyn_own_bs = [...
    stat_bootstrapping_cv(ii, mat_dyn_own(2, :), mat_dyn_own(1, :));
    stat_bootstrapping_cv(ii, mat_dyn_own(2, :), mat_dyn_own(3, :));
    stat_bootstrapping_cv(ii, mat_dyn_own(2, :), mat_dyn_own(4, :));
    stat_bootstrapping_cv(ii, mat_dyn_own(2, :), mat_dyn_own(5, :));
    stat_bootstrapping_cv(ii, mat_dyn_own(5, :), mat_dyn_own(1, :));
    stat_bootstrapping_cv(ii, mat_dyn_own(5, :), mat_dyn_own(3, :));
    stat_bootstrapping_cv(ii, mat_dyn_own(5, :), mat_dyn_own(4, :));
    ];

pval_cv_dyn_agn_bs = [...
    stat_bootstrapping_cv(ii, mat_dyn_agn(2, :), mat_dyn_agn(1, :));
    stat_bootstrapping_cv(ii, mat_dyn_agn(2, :), mat_dyn_agn(3, :));
    stat_bootstrapping_cv(ii, mat_dyn_agn(2, :), mat_dyn_agn(4, :)); 
    stat_bootstrapping_cv(ii, mat_dyn_agn(2, :), mat_dyn_agn(5, :));
    stat_bootstrapping_cv(ii, mat_dyn_agn(5, :), mat_dyn_agn(1, :));
    stat_bootstrapping_cv(ii, mat_dyn_agn(5, :), mat_dyn_agn(3, :));
    stat_bootstrapping_cv(ii, mat_dyn_agn(5, :), mat_dyn_agn(4, :));
    ];


%% Save matrices in .mat files

save('..\..\data\mat_questions.mat', 'stat_array', 'dyn_array');

save('..\..\data\mat_stat.mat', 'mat_stat_own', 'mat_stat_loc');
save('..\..\data\mat_dyn.mat', 'mat_dyn_own', 'mat_dyn_agn', 'mat_dyn_loc');

save('..\..\data\mn_dyn.mat', 'mn_dyn_own', 'mn_dyn_agn', 'mn_dyn_loc');
save('..\..\data\pval_dyn_bs.mat', 'pval_dyn_own_bs', 'pval_dyn_agn_bs', 'pval_dyn_loc_bs');

save('..\..\data\mn_stat.mat', 'mn_stat_own', 'mn_stat_loc');
save('..\..\data\pval_stat_bs.mat', 'pval_stat_own', 'pval_stat_loc');

save('..\..\data\cv.mat', 'cv_stat_own', 'cv_dyn_own', 'cv_dyn_agn');
save('..\..\data\pval_cv.mat', 'pval_cv_stat_own_bs', 'pval_cv_dyn_agn_bs', 'pval_cv_dyn_own_bs');

%%  By group
load('V:\Data\04. Exp1_Frontiers\type_trial_participant.txt');

group1 = find(type_trial_participant(:, 4) == 101);
group2 = find(type_trial_participant(:, 7) == 101);

mat_dyn_own_first = [... 
    reshape(squeeze(dyn_array(nOwnership, 1, group1)), 1, ...
    numel(squeeze(dyn_array(nOwnership, 1, group1)))); % no gap    
    reshape(squeeze(dyn_array(nOwnership, 2, group1)), 1, ...
    numel(squeeze(dyn_array(nOwnership, 2, group1)))); % offset = 10 cm
    reshape(squeeze(dyn_array(nOwnership, 3, group1)), 1, ...
    numel(squeeze(dyn_array(nOwnership, 3, group1)))); % knife on real
    reshape(squeeze(dyn_array(nOwnership, 4, group1)), 1, ...
    numel(squeeze(dyn_array(nOwnership, 4, group1)))); % gap
    reshape(squeeze(dyn_array(nOwnership, 5, group1)), 1, ...
    numel(squeeze(dyn_array(nOwnership, 5, group1)))); % noise
    ];

mat_dyn_own_end =  [... 
    reshape(squeeze(dyn_array(nOwnership, 1, group2)), 1, ...
    numel(squeeze(dyn_array(nOwnership, 1, group2)))); % no gap    
    reshape(squeeze(dyn_array(nOwnership, 2, group2)), 1, ...
    numel(squeeze(dyn_array(nOwnership, 2, group2)))); % offset = 10 cm
    reshape(squeeze(dyn_array(nOwnership, 3, group2)), 1, ...
    numel(squeeze(dyn_array(nOwnership, 3, group2)))); % knife on real
    reshape(squeeze(dyn_array(nOwnership, 4, group2)), 1, ...
    numel(squeeze(dyn_array(nOwnership, 4, group2)))); % gap
    reshape(squeeze(dyn_array(nOwnership, 5, group2)), 1, ...
    numel(squeeze(dyn_array(nOwnership, 5, group2)))); % noise
    ];

mat_dyn_agn_first = [... 
    reshape(squeeze(dyn_array(nAgency, 1, group1)), 1, ...
    numel(squeeze(dyn_array(nAgency, 1, group1)))); % no gap    
    reshape(squeeze(dyn_array(nAgency, 2, group1)), 1, ...
    numel(squeeze(dyn_array(nAgency, 2, group1)))); % offset = 10 cm
    reshape(squeeze(dyn_array(nAgency, 3, group1)), 1, ...
    numel(squeeze(dyn_array(nAgency, 3, group1)))); % knife on real
    reshape(squeeze(dyn_array(nAgency, 4, group1)), 1, ...
    numel(squeeze(dyn_array(nAgency, 4, group1)))); % gap
    reshape(squeeze(dyn_array(nAgency, 5, group1)), 1, ...
    numel(squeeze(dyn_array(nAgency, 5, group1)))); % noise
    ];

mat_dyn_agn_end =  [... 
    reshape(squeeze(dyn_array(nAgency, 1, group2)), 1, ...
    numel(squeeze(dyn_array(nAgency, 1, group2)))); % no gap    
    reshape(squeeze(dyn_array(nAgency, 2, group2)), 1, ...
    numel(squeeze(dyn_array(nAgency, 2, group2)))); % offset = 10 cm
    reshape(squeeze(dyn_array(nAgency, 3, group2)), 1, ...
    numel(squeeze(dyn_array(nAgency, 3, group2)))); % knife on real
    reshape(squeeze(dyn_array(nAgency, 4, group2)), 1, ...
    numel(squeeze(dyn_array(nAgency, 4, group2)))); % gap
    reshape(squeeze(dyn_array(nAgency, 5, group2)), 1, ...
    numel(squeeze(dyn_array(nAgency, 5, group2)))); % noise
    ];


pval_dyn_own_first_bs = [...
    stat_bootstrapping(ii, mat_dyn_own_first(2, :), mat_dyn_own_first(1, :));
    stat_bootstrapping(ii, mat_dyn_own_first(2, :), mat_dyn_own_first(3, :));
    stat_bootstrapping(ii, mat_dyn_own_first(2, :), mat_dyn_own_first(4, :));
    stat_bootstrapping(ii, mat_dyn_own_first(2, :), mat_dyn_own_first(5, :));
    stat_bootstrapping(ii, mat_dyn_own_first(4, :), mat_dyn_own_first(5, :));
    ];

pval_dyn_own_end_bs = [...
    stat_bootstrapping(ii, mat_dyn_own_end(2, :), mat_dyn_own_end(1, :));
    stat_bootstrapping(ii, mat_dyn_own_end(2, :), mat_dyn_own_end(3, :));
    stat_bootstrapping(ii, mat_dyn_own_end(2, :), mat_dyn_own_end(4, :));
    stat_bootstrapping(ii, mat_dyn_own_end(2, :), mat_dyn_own_end(5, :));
    stat_bootstrapping(ii, mat_dyn_own_end(4, :), mat_dyn_own_end(5, :));
    ];

pval_dyn_agn_first_bs = [ ...
    stat_bootstrapping(ii, mat_dyn_agn_first(2, :), mat_dyn_agn_first(1, :));
    stat_bootstrapping(ii, mat_dyn_agn_first(2, :), mat_dyn_agn_first(3, :));
    stat_bootstrapping(ii, mat_dyn_agn_first(2, :), mat_dyn_agn_first(4, :));
    stat_bootstrapping(ii, mat_dyn_agn_first(2, :), mat_dyn_agn_first(5, :));
    stat_bootstrapping(ii, mat_dyn_agn_first(4, :), mat_dyn_agn_first(5, :));
    ];

pval_dyn_agn_end_bs = [ ...
    stat_bootstrapping(ii, mat_dyn_agn_end(2, :), mat_dyn_agn_end(1, :));
    stat_bootstrapping(ii, mat_dyn_agn_end(2, :), mat_dyn_agn_end(3, :));
    stat_bootstrapping(ii, mat_dyn_agn_end(2, :), mat_dyn_agn_end(4, :));
    stat_bootstrapping(ii, mat_dyn_agn_end(2, :), mat_dyn_agn_end(5, :));
    stat_bootstrapping(ii, mat_dyn_agn_end(4, :), mat_dyn_agn_end(5, :));
    ];

pval_dyn_own_firstend = [... 
    stat_bootstrapping(ii, mat_dyn_own_first(1, :), mat_dyn_own_end(1, :));
    stat_bootstrapping(ii, mat_dyn_own_first(2, :), mat_dyn_own_end(2, :));
    stat_bootstrapping(ii, mat_dyn_own_first(3, :), mat_dyn_own_end(3, :));
    stat_bootstrapping(ii, mat_dyn_own_first(4, :), mat_dyn_own_end(4, :));
    stat_bootstrapping(ii, mat_dyn_own_first(5, :), mat_dyn_own_end(5, :));
    ];

pval_dyn_agn_firstend = [... 
    stat_bootstrapping(ii, mat_dyn_agn_first(1, :), mat_dyn_agn_end(1, :));
    stat_bootstrapping(ii, mat_dyn_agn_first(2, :), mat_dyn_agn_end(2, :));
    stat_bootstrapping(ii, mat_dyn_agn_first(3, :), mat_dyn_agn_end(3, :));
    stat_bootstrapping(ii, mat_dyn_agn_first(4, :), mat_dyn_agn_end(4, :));
    stat_bootstrapping(ii, mat_dyn_agn_first(5, :), mat_dyn_agn_end(5, :));
    ];


