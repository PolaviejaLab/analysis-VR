% FIG_POSTER_CNP2016 generates all the figures from the poster.

%% Load data
load('..\..\data\mat_stat.mat');
load('..\..\data\mat_dyn.mat');
load('..\..\data\mn_stat.mat');
load('..\..\data\mn_dyn.mat');
load('..\..\data\pval_stat_bs.mat');
load('..\..\data\pval_dyn_bs.mat');
load('..\..\data\cv.mat');
load('..\..\data\pval_cv.mat');


%% Set variables
n_elem_own = size(mat_stat_own(1, :), 2);
n_elem_agn = size(mat_dyn_agn(1, :), 2);
n_elem_loc_s = size(mat_stat_loc(1, :), 2);
n_elem_loc_d = size(mat_dyn_loc(1, :), 2);

c = parula;
cc = c(1:3:64,:);


%% Figure 1, modulation ownership and agency
fig1 = figure(1); clf;  
subplot(1, 2, 1); hold on,
bar([1, 2], [mean(mat_stat_own(1, :)), mean(mat_stat_own(2, :))]);
errorbar([0.75, 1.75], [mean(mat_stat_own(1, :)), ...
    mean(mat_stat_own(2, :))], [...
    std(mat_stat_own(1, :))/sqrt(n_elem_own), ...
    std(mat_stat_own(2, :))/sqrt(n_elem_own)], '.k');  hold off;

xlim([0.5 2.5]); ylim([0 7.5]);
set(gca, 'XTickLabel', {'', ''});
title('static block', 'FontWeight', 'bold', 'FontSize', 17);
legend({'ownership'}, 'location', 'NorthWest');

text(0.5, -0.3, 'Gap', 'FontWeight', 'bold');
text(0.5, -0.6, 'Noise', 'FontWeight', 'bold');

text(1, -0.3, '-'); text(2, -0.3, '+'); 
text(1, -0.6, '-'); text(2, -0.6, '-');

line([1 2], [5.5 5.5], 'Color', 'black');
text(1.5, 5.7, '*', 'FontWeight', 'bold', 'FontSize', 12);
ylabel('questionnaire answers', 'FontWeight', 'bold', 'FontSize', 15);

subplot(1, 2, 2); hold on; 
bar(1:3, [...
    mean(mat_dyn_own(2, :)) mean(mat_dyn_agn(2, :)); 
    mean(mat_dyn_own(4, :)) mean(mat_dyn_agn(4, :));
    mean(mat_dyn_own(5, :)) mean(mat_dyn_agn(5, :));
    ]);
errorbar(0.86:2.86, [...
    mean(mat_dyn_own(2, :)); 
    mean(mat_dyn_own(4, :));
    mean(mat_dyn_own(5, :));
    ], [...
    std(mat_dyn_own(2, :))/sqrt(n_elem_own);
    std(mat_dyn_own(4, :))/sqrt(n_elem_own);
    std(mat_dyn_own(5, :))/sqrt(n_elem_own);
    ], '.k'); 
errorbar(1.13:3.13, [...
    mean(mat_dyn_agn(2, :)); 
    mean(mat_dyn_agn(4, :));
    mean(mat_dyn_agn(5, :));
    ], [...
    std(mat_dyn_agn(2, :))/sqrt(n_elem_agn);
    std(mat_dyn_agn(4, :))/sqrt(n_elem_agn);
    std(mat_dyn_agn(5, :))/sqrt(n_elem_agn);
    ], '.k'); 

xlim([0.5 3.5]); ylim([0 7.5]);
set(gca, 'XTickLabel', {'', '', ''});
legend({'ownership', 'agency'}, 'location', 'NorthWest');
title('dynamic block', 'FontWeight', 'bold', 'FontSize', 17);

text(1, -0.3, '-'); text(2, -0.3, '+'); text(3, -0.3, '-'); 
text(1, -0.6, '-'); text(2, -0.6, '-'); text(3, -0.6, '+');

line([1.86 2.86], [6.75 6.75], 'Color', 'black');
line([2.13 3.13], [7 7], 'Color', 'black');
text(2.26, 6.8, '*', 'FontWeight', 'bold', 'FontSize', 12);
text(2.63, 7.1, '*', 'FontWeight', 'bold', 'FontSize', 12);

set(fig1,'units','normalized', 'Position', [0.2 0.2 0.8 0.65]);


%% Figure 2, modulation ownership and agency and location
fig2=figure(2); clf;  
subplot(1, 2, 1); hold on,

b = bar([1, 2], [mean(mat_stat_own(1, :)) mean(mat_stat_loc(1, :));  ...
    mean(mat_stat_own(2, :)) mean(mat_stat_loc(2, :))]);
errorbar([0.85, 1.85], [mean(mat_stat_own(1, :)), ...
    mean(mat_stat_own(2, :))], ...
    [std(mat_stat_own(1, :))/sqrt(n_elem_own), ...
    std(mat_stat_own(2, :))/sqrt(n_elem_own)], '.k'); 
errorbar([1.15, 2.15], [mean(mat_stat_loc(1, :)), ...
    mean(mat_stat_loc(2, :))], ...
    [std(mat_stat_loc(1, :))/sqrt(n_elem_loc_s), ...
    std(mat_stat_loc(2, :))/sqrt(n_elem_loc_s)], '.k'); hold off;

xlim([0.5 2.5]); ylim([0 7.5]);
set(gca, 'XTickLabel', {'', ''});
title('static block', 'FontWeight', 'bold', 'FontSize', 17);
legend({'ownership', 'location'}, 'location', 'NorthWest');

set(b(1), 'FaceColor', cc(4, :));
set(b(2), 'FaceColor', cc(15, :));

text(0.5, -0.3, 'Gap', 'FontWeight', 'bold');
text(0.5, -0.6, 'Noise', 'FontWeight', 'bold');

text(1, -0.3, '–'); text(2, -0.3, '+'); 
text(1, -0.6, '–'); text(2, -0.6, '–');

line([0.85 1.85], [6.5 6.5], 'Color', 'black');
text(1.35, 6.65, '*', 'FontWeight', 'bold', 'FontSize', 14);
ylabel('questionnaire answers', 'FontWeight', 'bold', 'FontSize', 15);

subplot(1, 2, 2); hold on; 
bb = bar(1:3, [...
    mean(mat_dyn_own(2, :)) mean(mat_dyn_agn(2, :)) mean(mat_dyn_loc(2, :)); 
    mean(mat_dyn_own(4, :)) mean(mat_dyn_agn(4, :)) mean(mat_dyn_loc(4, :));
    mean(mat_dyn_own(5, :)) mean(mat_dyn_agn(5, :)) mean(mat_dyn_loc(5, :));
    ]);
errorbar(0.775:2.775, [...
    mean(mat_dyn_own(2, :)); 
    mean(mat_dyn_own(4, :));
    mean(mat_dyn_own(5, :));
    ], [...
    std(mat_dyn_own(2, :))/sqrt(n_elem_own);
    std(mat_dyn_own(4, :))/sqrt(n_elem_own);
    std(mat_dyn_own(5, :))/sqrt(n_elem_own);
    ], '.k');
errorbar(1:3, [...
    mean(mat_dyn_agn(2, :)); 
    mean(mat_dyn_agn(4, :));
    mean(mat_dyn_agn(5, :));
    ], [...
    std(mat_dyn_agn(2, :))/sqrt(n_elem_agn);
    std(mat_dyn_agn(4, :))/sqrt(n_elem_agn);
    std(mat_dyn_agn(5, :))/sqrt(n_elem_agn);
    ], '.k'); 
errorbar(1.225:3.225, [...
    mean(mat_dyn_loc(2, :)); 
    mean(mat_dyn_loc(4, :));
    mean(mat_dyn_loc(5, :));
    ], [...
    std(mat_dyn_loc(2, :))/sqrt(n_elem_loc_d);
    std(mat_dyn_loc(4, :))/sqrt(n_elem_loc_d);
    std(mat_dyn_loc(5, :))/sqrt(n_elem_loc_d);
    ], '.k'); hold off;
xlim([0.5 3.5]); ylim([0 7.5]);
set(gca, 'XTickLabel', {'', '', ''});
legend({'ownership', 'agency', 'location'}, 'location', 'NorthWest');
title('dynamic block', 'FontWeight', 'bold', 'FontSize', 17);

set(bb(1), 'FaceColor', cc(4, :));
set(bb(2), 'FaceColor', cc(8, :));
set(bb(3), 'FaceColor', cc(15, :));

text(1, -0.3, '–'); text(2, -0.3, '+'); text(3, -0.3, '–'); 
text(1, -0.6, '–'); text(2, -0.6, '–'); text(3, -0.6, '+');

line([1.775 2.775], [6.65 6.65], 'Color', 'black');
line([2 3], [6.9 6.9], 'Color', 'black');
line([2.225 3.225], [7.15 7.15], 'Color', 'black');

text(2.275, 6.75, '*', 'FontWeight', 'bold', 'FontSize', 14);
text(2.5, 7, '*', 'FontWeight', 'bold', 'FontSize', 14);
text(2.725, 7.25, '*', 'FontWeight', 'bold', 'FontSize', 14);

set(fig2,'units','normalized', 'Position', [0.2 0.2 0.8 0.65]);


%% Figure 3, adding dots
format = '.b';

c_o = 3;
c_a = 12;
c_l = 18;

fig3=figure(3); clf;  
subplot(1, 2, 1); hold on,

b = bar([1, 2], [mean(mat_stat_own(1, :)) mean(mat_stat_loc(1, :));  ...
    mean(mat_stat_own(2, :)) mean(mat_stat_loc(2, :))]);
errorbar([0.85, 1.85], [mean(mat_stat_own(1, :)), ...
    mean(mat_stat_own(2, :))], ...
    [std(mat_stat_own(1, :))/sqrt(n_elem_own), ...
    std(mat_stat_own(2, :))/sqrt(n_elem_own)], '.k'); 
errorbar([1.15, 2.15], [mean(mat_stat_loc(1, :)), ...
    mean(mat_stat_loc(2, :))], ...
    [std(mat_stat_loc(1, :))/sqrt(n_elem_loc_s), ...
    std(mat_stat_loc(2, :))/sqrt(n_elem_loc_s)], '.k'); 

set(b(1), 'FaceColor', cc(c_o, :));
set(b(2), 'FaceColor', cc(c_l, :));


scatter (0.8-0.001*ones(1, n_elem_own) + (1:n_elem_own)*0.001, mat_stat_own(1, :), format);
scatter (1.8-0.001*ones(1, n_elem_own) + (1:n_elem_own)*0.001, mat_stat_own(2, :), format);

scatter (1.15-0.001*ones(1, n_elem_loc_s) + (1:n_elem_loc_s)*0.001, mat_stat_loc(1, :), format);
scatter (2.15-0.001*ones(1, n_elem_loc_s) + (1:n_elem_loc_s)*0.001, mat_stat_loc(2, :), format);

xlim([0.5 2.5]); ylim([0 7.5]);
set(gca, 'XTickLabel', {'', ''}, 'YTick', 1:1:7);
title('static block', 'FontWeight', 'bold', 'FontSize', 17);
legend({'ownership', 'location'}, 'location', 'NorthWest');

text(0.5, -0.3, 'Gap', 'FontWeight', 'bold'); text(1, -0.3, '–'); text(2, -0.3, '+'); 
text(0.5, -0.6, 'Noise', 'FontWeight', 'bold'); text(1, -0.6, '–'); text(2, -0.6, '–');

line([0.85 1.85], [6.5 6.5], 'Color', 'black');
text(1.35, 6.65, '*', 'FontWeight', 'bold', 'FontSize', 14);
ylabel('questionnaire answers', 'FontWeight', 'bold', 'FontSize', 15);


subplot(1, 2, 2); hold on; 
bb = bar(1:3, [...
    mean(mat_dyn_own(2, :)) mean(mat_dyn_agn(2, :)) mean(mat_dyn_loc(2, :)); 
    mean(mat_dyn_own(4, :)) mean(mat_dyn_agn(4, :)) mean(mat_dyn_loc(4, :));
    mean(mat_dyn_own(5, :)) mean(mat_dyn_agn(5, :)) mean(mat_dyn_loc(5, :));
    ]);
errorbar(0.775:2.775, [...
    mean(mat_dyn_own(2, :)); 
    mean(mat_dyn_own(4, :));
    mean(mat_dyn_own(5, :));
    ], [...
    std(mat_dyn_own(2, :))/sqrt(n_elem_own);
    std(mat_dyn_own(4, :))/sqrt(n_elem_own);
    std(mat_dyn_own(5, :))/sqrt(n_elem_own);
    ], '.k');
errorbar(1:3, [...
    mean(mat_dyn_agn(2, :)); 
    mean(mat_dyn_agn(4, :));
    mean(mat_dyn_agn(5, :));
    ], [...
    std(mat_dyn_agn(2, :))/sqrt(n_elem_agn);
    std(mat_dyn_agn(4, :))/sqrt(n_elem_agn);
    std(mat_dyn_agn(5, :))/sqrt(n_elem_agn);
    ], '.k'); 
errorbar(1.225:3.225, [...
    mean(mat_dyn_loc(2, :)); 
    mean(mat_dyn_loc(4, :));
    mean(mat_dyn_loc(5, :));
    ], [...
    std(mat_dyn_loc(2, :))/sqrt(n_elem_loc_d);
    std(mat_dyn_loc(4, :))/sqrt(n_elem_loc_d);
    std(mat_dyn_loc(5, :))/sqrt(n_elem_loc_d);
    ], '.k'); 

scatter (0.725-0.001*ones(1, n_elem_own) + ...
    (1:n_elem_own)*0.001, mat_dyn_own(2, :), format);
scatter (1.725-0.001*ones(1, n_elem_own) + (1:n_elem_own)*0.001, mat_dyn_own(4, :), format);
scatter (2.725-0.001*ones(1, n_elem_own) + (1:n_elem_own)*0.001, mat_dyn_own(5, :), format);

scatter (0.95-0.001*ones(1, n_elem_agn) + (1:n_elem_agn)*0.001, mat_dyn_agn(2, :), format);
scatter (1.95-0.001*ones(1, n_elem_agn) + (1:n_elem_agn)*0.001, mat_dyn_agn(4, :), format);
scatter (2.95-0.001*ones(1, n_elem_agn) + (1:n_elem_agn)*0.001, mat_dyn_agn(5, :), format);

scatter (1.2-0.001*ones(1, n_elem_loc_d) + (1:n_elem_loc_d)*0.001, mat_dyn_loc(2, :), format);
scatter (2.2-0.001*ones(1, n_elem_loc_d) + (1:n_elem_loc_d)*0.001, mat_dyn_loc(4, :), format);
scatter (3.2-0.001*ones(1, n_elem_loc_d) + (1:n_elem_loc_d)*0.001, mat_dyn_loc(5, :), format);
hold off;

set(bb(1), 'FaceColor', cc(c_o, :));
set(bb(2), 'FaceColor', cc(c_a, :));
set(bb(3), 'FaceColor', cc(c_l, :));

xlim([0.5 3.5]); ylim([0 8.5]);
set(gca, 'XTickLabel', {'', ''}, 'YTick', 1:1:7);
legend({'ownership', 'agency', 'location'}, 'location', 'NorthWest');
title('dynamic block', 'FontWeight', 'bold', 'FontSize', 17);

text(1, -0.3, '–'); text(2, -0.3, '+'); text(3, -0.3, '–'); 
text(1, -0.6, '–'); text(2, -0.6, '–'); text(3, -0.6, '+');

line([0.775 2.775], [6.95 6.95], 'Color', 'black');
line([1 3], [7.2 7.2], 'Color', 'black');
line([1.225 3.225], [7.45 7.45], 'Color', 'black');

text(1.775, 7, '*', 'FontWeight', 'bold', 'FontSize', 16);
text(2, 7.25, '*', 'FontWeight', 'bold', 'FontSize', 16);
text(2.225, 7.5, '*', 'FontWeight', 'bold', 'FontSize', 16);

set(fig3,'units','normalized', 'Position', [0.2 0.2 0.8 0.65]);


%% Figure, coefficient variations

c = parula;
c =  c([1 6 11 16 21 26 31 36 41 46 51 56 61], :);
edge = 1:7;

dyn_own_control = reshape(mat_dyn_own(2, :), 4, 22);
dyn_own_gap = reshape(mat_dyn_own(4, :), 4, 22);
dyn_own_noise = reshape(mat_dyn_own(5, :), 4, 22);

cv_own_control = std(dyn_own_control)./mean(dyn_own_control);
cv_own_gap = std(dyn_own_gap)./mean(dyn_own_gap);
cv_own_noise = std(dyn_own_noise)./mean(dyn_own_noise);


dyn_agn_control = reshape(mat_dyn_agn(2, :), 3, 22);
dyn_agn_gap = reshape(mat_dyn_agn(4, :), 3, 22);
dyn_agn_noise = reshape(mat_dyn_agn(5, :), 3, 22);

cv_agn_control = std(dyn_agn_control)./mean(dyn_agn_control);
cv_agn_gap = std(dyn_agn_gap)./mean(dyn_agn_gap);
cv_agn_noise = std(dyn_agn_noise)./mean(dyn_agn_noise);

fig4 = figure(4); clf; 
subplot(2, 2, 1); % distributions - ownership
n_elements = n_elem_own;

plot(edge, hist(mat_dyn_own(2, :), edge)/n_elements, ...
    'color', c(2, :), 'LineWidth', 3); hold on,
plot(edge, hist(mat_dyn_own(4, :), edge)/n_elements, ...
    'color', c(8, :), 'LineWidth', 3); hold on,
plot(edge, hist(mat_dyn_own(5, :), edge)/n_elements, ...
    'color', c(12, :), 'LineWidth', 3); hold on,

line([mn_dyn_own(1, :), mn_dyn_own(1, :)], [-0.1 1.1], ...
    'LineStyle', '-', 'color', c(2, :));
line([mn_dyn_own(3, :), mn_dyn_own(3, :)], [-0.1 1.1], ...
    'LineStyle', '-', 'color', c(8, :));
line([mn_dyn_own(4, :), mn_dyn_own(4, :)], [-0.1 1.1], ...
    'LineStyle', '-', 'color', c(12, :));

line([0 8],[0 0], 'LineStyle', ':', 'color', [211/256 211/256 211/256]);

xlim([1 7]);
ylim([-0.05 1]);

title('ownership', 'FontWeight', 'bold', 'FontSize', 15);
xlabel('questionnaire responses', 'FontSize', ...
    14, 'FontWeight', 'bold');
ylabel('probability density', 'FontSize', ...
    14, 'FontWeight', 'bold');

legend({'control', 'gap', 'noise'}, 'location', 'northwest');

% 
% text(1.25, 0.75, strcat('p =', num2str(p_val, '%.3f')), 'FontSize', 12, 'color', c(color2, :));
% text(1.25, 0.65, strcat('p =', num2str(p_val_ks, '%.3f')), 'FontSize', 12, 'color', 'k');

subplot(2, 2, 2);
scatter(1:3, cv_dyn_own([2 4 5])); hold on, 

errorbar(1:3, [...
    cv_dyn_own(2), cv_dyn_own(4), cv_dyn_own(5)], [...
    std(cv_own_control)/sqrt(22), std(cv_own_gap)/sqrt(22), std(cv_own_noise)/sqrt(22)], 'k');
hold off; 

xlim([0.5 3.5]); ylim([0 1]);
set(gca, 'XTick', 1:3, 'XTickLabel', {'control', 'gap', 'noise'});
title('ownership - cv', 'FontWeight', 'bold', 'FontSize', 16);
line([2 3], [0.75 0.75], 'Color', 'k');
text(2.5, 0.77, '*', 'FontSize', 14);


subplot(2, 2, 3);
n_elements = n_elem_agn;

plot(edge, hist(mat_dyn_agn(2, :), edge)/n_elements, ...
    'color', c(2, :), 'LineWidth', 3); hold on,
plot(edge, hist(mat_dyn_agn(4, :), edge)/n_elements, ...
    'color', c(8, :), 'LineWidth', 3); hold on,
plot(edge, hist(mat_dyn_agn(5, :), edge)/n_elements, ...
    'color', c(12, :), 'LineWidth', 3); hold on,

line([mn_dyn_agn(1, :), mn_dyn_agn(1, :)], [-0.1 1.1], ...
    'LineStyle', '-', 'color', c(2, :));
line([mn_dyn_agn(3, :), mn_dyn_agn(3, :)], [-0.1 1.1], ...
    'LineStyle', '-', 'color', c(8, :));
line([mn_dyn_agn(4, :), mn_dyn_agn(4, :)], [-0.1 1.1], ...
    'LineStyle', '-', 'color', c(12, :));

line([0 8],[0 0], 'LineStyle', ':', 'color', [211/256 211/256 211/256]);

xlim([1 7]);
ylim([-0.05 1]);

title('agency', 'FontWeight', 'bold', 'FontSize', 16);
xlabel('questionnaire responses', 'FontSize', ...
    14, 'FontWeight', 'bold');
ylabel('probability density', 'FontSize', ...
    14, 'FontWeight', 'bold');
legend({'control', 'gap', 'noise'}, 'location', 'northwest');

subplot(2, 2, 4);
scatter(1:3, cv_dyn_agn([2 4 5])); hold on, 
errorbar(1:3, [...
    cv_dyn_agn(2), cv_dyn_agn(4), cv_dyn_agn(5)], [...
    std(cv_agn_control)/sqrt(22), std(cv_agn_gap)/sqrt(22), std(cv_agn_noise)/sqrt(22)], 'k');
hold off; 

title('agency - cv', 'FontWeight', 'bold', 'FontSize', 15);
xlim([0.5 3.5]); ylim([0 1]);
set(gca, 'XTick', 1:3, 'XTickLabel', {'control', 'gap', 'noise'});
line([2 3], [0.75 0.75], 'Color', 'k');
text(2.5, 0.77, '*', 'FontSize', 14);

set(fig4,'units','normalized', 'Position', [0.15 0 0.48 0.75]);