%% add paths
addpath('..\getData\');
addpath('..\analyses\');
addpath('formatting\');
addpath('..\');

%% get the data
config; [~, cube_firstpilots] = get_data_pilots (); % first Pilots

%% aux variables
q_location = 13:14;

axis_fontsize = 13;
title_fontsize = 17;

%% matrices
    % MAT_LOCATION is a matrix of NxM where N are the conditions and M
    % are each individual subject
mat_location = squeeze(mean(cube_firstpilots(q_location, :, :)));


%% Plot

% colors
c = parula;
c =  c([1 6 11 16 42 47 52 57], :);

% data for the plot
edge = 1:7;


% figure
fig1 = figure(1); clf,  
plot(edge, hist(mat_location(1, :), edge)/16 + 0.01, 'color', c(1, :), 'LineWidth', 5); hold on,
% plot(edge, hist(mat_location(2, :), edge)/16, 'color', c(2, :), 'LineWidth', 5); 
plot(edge, hist(mat_location(3, :), edge)/16, 'color', c(3, :), 'LineWidth', 5); 
plot(edge, hist(mat_location(4, :), edge)/16, 'color', c(6, :), 'LineWidth', 5); 
% plot(edge, hist(mat_location(5, :), edge)/16, 'color', c(7, :), 'LineWidth', 5); 
plot(edge, hist(mat_location(6, :), edge)/16, 'color', c(8, :), 'LineWidth', 5); 
hold off, 

legend({'no gap - no offset', 'no gap - offset', 'gap - no offset' ...
    'gap - offset', 'onwership - noise'}, 'location', 'northwest');

[mat_pvals, diff_means] = bootstrapping_location(mat_location);

title('Self-report of location', 'FontSize', title_fontsize, 'FontWeight', 'bold');
xlim([0.5 7.5]); ylim([-0.025 0.66]);
xlabel('questionnaire responses', 'FontSize', axis_fontsize, 'FontWeight', 'bold');
ylabel('probability density', 'FontSize', axis_fontsize, 'FontWeight', 'bold');
set(gca, 'FontSize', 12, 'FontWeight', 'bold');

% line([mean(agn_nogap_nonoise)-0.01, mean(agn_nogap_nonoise)-0.01], [-0.1 0.7], ...
%     'LineStyle', '-', 'color', c(1, :));
% line([mean(agn_gap_nonoise)+0.01, mean(agn_gap_nonoise)+0.01], [-0.1 0.7], ...
%     'LineStyle', '-', 'color', c(3, :));
line([0 8],[0 0], 'LineStyle', ':', 'color', [211/256 211/256 211/256]);

% text(0.75, 0.375, strcat('p =', num2str(pval_agn(1), '%.3f')), 'FontSize', 12, 'color', c(3,:));



set(fig1,'units','normalized', 'Position', [0.15 0.01 0.5 0.75]);

