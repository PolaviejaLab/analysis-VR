addpath('..\'); config;
addpath('..\statistics\');

%% Get Data
[drift, handp, n_participants] = get_drift_and_handp();

diff_position = handp - drift * 1000;

position1 = [0.15, 0.5, 0.8, 0.4];
position2 = [0.15, 0.1, 0.8, 0.4];

fig1 = figure(1); clf,

% subplot('Position', position1);
% 
% c = parula;
% c  =  c([1 6 11 16 42 47 52 57], :);
%  
% cla; hold on;
% drp = plot(nanmean(drift(:, 1:6)) * 100, 'o-', 'Color', c(6, :), 'linewidth',3);
% hpp = plot(nanmean(handp(:, 1:6)) * 100, 'o-', 'Color', c(3, :), 'linewidth',3);
% 
% % plot(nanmean(drift(:, 1:3)) * 100, 'o-', 'Color', c(6, :), 'linewidth',3);
% % plot(nanmean(handp(:, 1:3)) / 10, 'o-', 'Color', c(3, :), 'linewidth', 3);
% 
% % plot(4:6, nanmean(drift(:, 4:6)) * 100, 'o-', 'Color', c(6, :), 'linewidth', 3);
% % plot(4:6, nanmean(handp(:, 4:6)) / 10, 'o-', 'Color', c(3, :), 'linewidth', 3);
% 
% for i = 1:6
%     errorbar(i, nanmean(drift(:, i)) * 100, nanstd(drift(:, i) * 100) /sqrt(n_participants), 'Color', c(6, :));
%     errorbar(i, nanmean(handp(:, i)) * 100, nanstd(handp(:, i) * 100) / sqrt(n_participants), 'Color', c(3, :));
% end
% % 
% title('Proprioceptive Drift', 'FontWeight', 'bold', 'FontSize', 17);
% legend ({'Perceived Position', 'Real Position'}, 'location', 'northwest', 'FontSize', 14);
% ylim([-3 11])
% % xlabel('Condition', 'fontsize', 16, 'FontWeight', 'bold');
% ylabel('Position (cm)', 'fontsize', 16, 'FontWeight', 'bold');
% set(gca, 'XTick', 1:6);
% set(gca, 'XTickLabel', {'' '' '' '' '' ''}, 'FontSize', 14);
% line([],[], 'color', 'k', 'linestyle', ':');
% line([0 7],[0 0], 'LineStyle', ':', 'color', [211/256 211/256 211/256]); 
% hold off; hold on;
% 
% % set(fig1,'units','normalized', 'Position', [0.1 0.1 0.45 0.75]);
% 
% subplot('Position', position2)

c = parula;
c  =  c([1 6 11 16 42 47 52 57], :);

cla; hold on;
plot(nanmean(diff_position(:, 1:8)) / 10, '.', 'Color', c(6, :), 'MarkerSize', 18);

for i = 1:8  
    errorbar(i, nanmean(diff_position(:, i)) / 10, ...
        nanstd(diff_position(:, i) / 10) /sqrt(n_participants), ...
        'Color', c(6, :));
end

ylim([-3 11]);
% title('Proprioceptive Drift', 'FontWeight', 'bold', 'FontSize', 19);
xlabel('Condition');
ylabel('Real - Perceived Position [cm]');
set(gca, 'XTick', 1:6, 'XTickLabel', {'H' 'NO' 'B' 'OR' 'G' 'N'});
xlim([0.5 6.5]);
line([5 6], [8 8], 'Color', 'black');
text(5.5, 8.25, '*', 'FontSize', 13, 'FontWeight', 'bold'); hold off; box on;
title('Proprioceptive drift', 'fontweight', 'bold')
set(fig1, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);


%% Set variables 
iterations = 10000;


%% differences
% pval_diff_1 = 1 - stat_bootstrapping (iterations, drift(:, 1)', handp(:, 1)');
% pval_diff_2 = 1 - stat_bootstrapping (iterations, drift(:, 2)', handp(:, 2)');
% pval_diff_3 = 1 - stat_bootstrapping (iterations, drift(:, 3)', handp(:, 3)');
% pval_diff_4 = 1 - stat_bootstrapping (iterations, drift(:, 4)', handp(:, 4)');
% pval_diff_5 = 1 - stat_bootstrapping (iterations, drift(:, 5)', handp(:, 5)');
% pval_diff_6 = 1 - stat_bootstrapping (iterations, drift(:, 6)', handp(:, 6)');


%% between conditions
% pval_cond1 = 1 - stat_bootstrapping (iterations, drift(:, 2)', drift(:, 3)');
% pval_cond2 = 1 - stat_bootstrapping (iterations, drift(:, 2)', drift(:, 4)');
% pval_cond3 = 1 - stat_bootstrapping (iterations, drift(:, 2)', drift(:, 5)');
% pval_cond4 = 1 - stat_bootstrapping (iterations, drift(:, 2)', drift(:, 6)');
% pval_cond5 = 1 - stat_bootstrapping (iterations, drift(:, 3)', drift(:, 4)');
% pval_cond6 = 1 - stat_bootstrapping (iterations, drift(:, 3)', drift(:, 5)');
% pval_cond7 = 1 - stat_bootstrapping (iterations, drift(:, 3)', drift(:, 6)');
% pval_cond8 = 1 - stat_bootstrapping (iterations, drift(:, 4)', drift(:, 5)');
% pval_cond9 = 1 - stat_bootstrapping (iterations, drift(:, 4)', drift(:, 6)');
% pval_cond10 = 1 - stat_bootstrapping (iterations, drift(:, 5)', drift(:, 6)');
% pval_cond11 = 1 - stat_bootstrapping (iterations, drift(:, 1)', drift(:, 6)');


%%



%% 
[h1, p1] = kstest2 (diff_position(:, 2), diff_position(:, 3)); % D1 - D2
[h2, p2] = kstest2 (diff_position(:, 3), diff_position(:, 5)); % D2 - D4
[h3, p3] = kstest2 (diff_position(:, 3), diff_position(:, 6)); % D2 - D5
[h4, p4] = kstest2 (diff_position(:, 5), diff_position(:, 6)); % D4 - D5
[h5, p5] = kstest2 (diff_position(:, 2), diff_position(:, 5)); % D1 - D4
[h6, p6] = kstest2 (diff_position(:, 2), diff_position(:, 6)); % D1 - D5
[h7, p7] = kstest2 (diff_position(:, 1), diff_position(:, 2)); % T - D5
[h8, p8] = kstest2 (diff_position(:, 1), diff_position(:, 5)); % T - D4

pval1 = stat_bootstrapping (iterations, ...
    diff_position(:, 2)', diff_position(:, 3)'); % D1 - D2
pval2 = stat_bootstrapping (iterations, ...
    diff_position(:, 2)', diff_position(:, 4)'); % D1 - D3
pval3 = stat_bootstrapping (iterations, ...
    diff_position(:, 2)', diff_position(:, 5)'); % D1 - D4
pval4 = stat_bootstrapping (iterations, ...
    diff_position(:, 2)', diff_position(:, 6)'); % D1 - D5
pval5 = stat_bootstrapping (iterations, ...
    diff_position(:, 1)', diff_position(:, 2)'); % T - D1
pval6 = stat_bootstrapping (iterations, ...
    diff_position(:, 1)', diff_position(:, 3)'); % T - D2
pval7 = stat_bootstrapping (iterations, ...
    diff_position(:, 1)', diff_position(:, 4)'); % T - D3
pval8 = stat_bootstrapping (iterations, ...
    diff_position(:, 1)', diff_position(:, 5)'); % T - D4
pval9 = stat_bootstrapping (iterations, ...
    diff_position(:, 6)', diff_position(:, 1)'); % T - D5
pval11 = stat_bootstrapping (iterations, ...
    diff_position(:, 3)', diff_position(:, 4)'); % D2 - D3
pval22 = stat_bootstrapping (iterations, ...
    diff_position(:, 3)', diff_position(:, 5)'); % D2 - D4
pval33 = stat_bootstrapping (iterations, ...
    diff_position(:, 3)', diff_position(:, 6)'); % D2 - D5
pval44 = stat_bootstrapping (iterations, ...
    diff_position(:, 4)', diff_position(:, 5)'); % D3 - D4
pval55 = stat_bootstrapping (iterations, ...
    diff_position(:, 4)', diff_position(:, 6)'); % D3 - D5
pval66 = stat_bootstrapping (iterations, ...
    diff_position(:, 6)', diff_position(:, 5)'); % D4 - D5


%% Correlations
% 
% addpath('..\getData\');
% [~, dynamic_array] = get_data (1);
% 
% q_location = 13;
% pval_corr = nan(1, 5);
% rval_corr = nan(1, 5);
% 
% for i = 1:5
%     vect1 = squeeze(dynamic_array(q_location, i, :));
%     vect2 = diff_position(:, i+1);
%     vect1(isnan(vect2)) = [];
%     vect2(isnan(vect2)) = [];
%     
% %     [corr_mat, p_val_mat] = corr(vect1, vect2);
% %     rval_corr(i) = corr_mat;
% %     pval_corr(i) = p_val_mat;
%     
%     figure(i + 1);
%     plot(vect1, vect2, 'o');
%     set(gca, 'XTick', 1:7);
%     xlim([0.5 7.5]);
% end


%% Plot

