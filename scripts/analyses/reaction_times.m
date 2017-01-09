%% Variables
c = parula;
cmap = c(10:3:65,:);

c1 = 3;
c2 = 9;

n_ind = 20;

font_title = 17;


%% Time to target

files = dir('V:\Data\04. Exp1_Frontiers\TimeStamps\');


% Load the TS
for i = 3:numel(files)
    aux = dlmread(files(i).name, '\t'); 
    timestamps_subjects{i - 2} = aux(2:6, :);
end

% Load the matrix with the conditions, only the dynamic block part
aux = dlmread('V:\Data\04. Exp1_Frontiers\type_trial_participant.txt'); % Now it is loading from initial waved to waved
mat_part_dyn = aux(1:20, 4:8)';

% Transform the conditions in ordinal numbers
mat_part_dyn(mat_part_dyn == 1) = 2;
mat_part_dyn(mat_part_dyn == 0) = 1;
mat_part_dyn(mat_part_dyn == 1001) = 3;
mat_part_dyn(mat_part_dyn == 101) = 4;
mat_part_dyn(mat_part_dyn == 11) = 5;

% Re-order the timestamp_subjects
for i = 1:size(timestamps_subjects, 2)
    aux = mat_part_dyn(:, i);
    timestamps_subjects{1, i} = timestamps_subjects{1, i}(aux, :);
    
    % make a cube
    if size(timestamps_subjects{1, i}, 2) == 51
        cube_timestamps(:, :, i) = timestamps_subjects{1, i};
        % add nans to the shorter trials
    else
        add = NaN*ones(5, 10);
        timestamps_subjects{1, i} = [timestamps_subjects{1, i}, add];
        cube_timestamps(:, :, i) = timestamps_subjects{1, i};
    end   
end

% Get times towards target
for i = 1:floor(size(cube_timestamps, 2)/2)
    ii = i + (i - 1);
    jj = ii + 1;
    cube_totarget(:, i, :) = cube_timestamps(:, jj, :) - cube_timestamps(:, ii, :);
end 

% Get times towards initial
for i = 1:floor(size(cube_timestamps, 2)/2)
    ii = i + (i);
    jj = ii + 1;
    cube_toinitial(:, i, :) = cube_timestamps(:, jj, :) - cube_timestamps(:, ii, :);
end 
nooffset = squeeze(nanmedian(cube_totarget(1, :, :), 2));
control = squeeze(nanmedian(cube_totarget(2, :, :), 2));
gap = squeeze(nanmedian(cube_totarget(4, :, :), 2));
noise = squeeze(nanmedian(cube_totarget(5, :, :), 2));

% cube_totarget = ...
%     cube_timestamps(:, 2:2:size(cube_timestamps, 2)) - ...
%     cube_timestamps(:, 1:2:size(cube_timestamps, 2));

timetotarget = [...
    squeeze(nanmedian(cube_totarget(2, :, :), 2)) squeeze(nanmedian(cube_totarget(4, :, :), 2)) squeeze(nanmedian(cube_totarget(5, :, :), 2))
    ];

timetoinitial = [...
    squeeze(nanmedian(cube_toinitial(2, :, :), 2)) squeeze(nanmedian(cube_toinitial(4, :, :), 2)) squeeze(nanmedian(cube_toinitial(5, :, :), 2))
    ];



pvals_ttotarget = [...
    stat_bootstrapping(10000, ...
        squeeze(nanmedian(cube_totarget(2, :, :), 2))', ...
        squeeze(nanmedian(cube_totarget(4, :, :), 2))');
    stat_bootstrapping(10000, ...
        squeeze(nanmedian(cube_totarget(2, :, :), 2))', ...
        squeeze(nanmedian(cube_totarget(5, :, :), 2))');    
    stat_bootstrapping(10000, ...
        squeeze(nanmedian(cube_totarget(4, :, :), 2))', ...
        squeeze(nanmedian(cube_totarget(5, :, :), 2))');
    ];


cv_timetotarget = [...
    std(nanmedian(cube_totarget(2, :, :), 2)) ./ mean(nanmedian(cube_totarget(2, :, :), 2));
    std(nanmedian(cube_totarget(4, :, :), 2)) ./ mean(nanmedian(cube_totarget(4, :, :), 2));
    std(nanmedian(cube_totarget(5, :, :), 2)) ./ mean(nanmedian(cube_totarget(5, :, :), 2))];

fig1 = figure(1); clf; 
subplot(1, 2, 1); hold on, 
b = bar(1:3, [mean(control), mean(gap), mean(noise)]);
errorbar([mean(control), mean(gap), mean(noise)], ...
    [std(control), std(gap), std(noise)], 'k'); hold off, 
set(gca, 'XTick', 1:3, 'XTickLabel', {'control', 'gap', 'noise'}, 'FontSize', 12);
set(b, 'FaceColor', cmap(6, :));
title('time to target', 'FontSize', font_title, 'FontWeight', 'bold');
ylabel('time to target [s]', 'FontSize', 15, 'FontWeight', 'bold');
xlabel('conditions', 'FontSize', 15, 'FontWeight', 'bold');

subplot(1, 2, 2);
plot(1:3, [...
    cv_timetotarget(1)', cv_timetotarget(2)', cv_timetotarget(3)'], '-o', ...
    'Color', cmap(6, :), 'MarkerFaceColor', cmap(6, :));

xlim([0.5 3.5]); ylim([0 0.20]);
title('time to target - cv', 'FontWeight', 'bold', 'FontSize', font_title);
set(gca, 'XTick', 1:3, 'XTickLabel', {'control', 'gap', 'noise'}, 'FontSize', 12);
ylabel('time to target', 'FontSize', 15, 'FontWeight', 'bold');
xlabel('conditions', 'FontSize', 15, 'FontWeight', 'bold'); box off;

set(fig1,'units','normalized', 'Position', [0.2 0.2 0.8 0.65]);


%% Distance
load('V:\Data\04. Exp1_Frontiers\mat_poster.mat');

pvals_disttotarget_bs = [...
    stat_bootstrapping(10000, distances_ind_trial(:, 1)', distances_ind_trial(:, 2)');
    stat_bootstrapping(10000, distances_ind_trial(:, 1)', distances_ind_trial(:, 3)');
    stat_bootstrapping(10000, distances_ind_trial(:, 1)', distances_ind_trial(:, 4)');
    stat_bootstrapping(10000, distances_ind_trial(:, 2)', distances_ind_trial(:, 3)');
    stat_bootstrapping(10000, distances_ind_trial(:, 2)', distances_ind_trial(:, 4)');
    stat_bootstrapping(10000, distances_ind_trial(:, 3)', distances_ind_trial(:, 4)');
    ];

pvals_disttoinitial_bs = [...
    stat_bootstrapping(10000, distances_ind_trial_back(:, 1)', distances_ind_trial_back(:, 2)');
    stat_bootstrapping(10000, distances_ind_trial_back(:, 1)', distances_ind_trial_back(:, 3)');
    stat_bootstrapping(10000, distances_ind_trial_back(:, 1)', distances_ind_trial_back(:, 4)');
    stat_bootstrapping(10000, distances_ind_trial_back(:, 2)', distances_ind_trial_back(:, 3)');
    stat_bootstrapping(10000, distances_ind_trial_back(:, 2)', distances_ind_trial_back(:, 4)');
    stat_bootstrapping(10000, distances_ind_trial_back(:, 3)', distances_ind_trial_back(:, 4)');
    ];

cv_distance = [...
    std(distances_ind_trial(:, 1))./mean(distances_ind_trial(:, 1));
    std(distances_ind_trial(:, 3))./mean(distances_ind_trial(:, 3));
    std(distances_ind_trial(:, 4))./mean(distances_ind_trial(:, 4))];

cv_distance_back = [...
    std(distances_ind_trial_back(:, 1))./mean(distances_ind_trial_back(:, 1));
    std(distances_ind_trial_back(:, 3))./mean(distances_ind_trial_back(:, 3));
    std(distances_ind_trial_back(:, 4))./mean(distances_ind_trial_back(:, 4))];


fig2 = figure(2); clf;  % Figure with the distance
subplot(1, 2, 1); hold on;
b2 = bar(1:3, [...
    mean(distances_ind_trial(:, 2)) mean(distances_ind_trial_back(:, 2));
    mean(distances_ind_trial(:, 3)) mean(distances_ind_trial_back(:, 3));
    mean(distances_ind_trial(:, 4)) mean(distances_ind_trial_back(:, 4))]);

errorbar([0.85, 1.85, 2.85], [...
    mean(distances_ind_trial(:, 2)), ...
    mean(distances_ind_trial(:, 3)), ...
    mean(distances_ind_trial(:, 4))], [ ...
    std(distances_ind_trial(:, 2)/sqrt(n_ind)), ...
    std(distances_ind_trial(:, 3)/sqrt(n_ind)), ...
    std(distances_ind_trial(:, 4)/sqrt(n_ind))], 'k'); 

errorbar([1.15, 2.15, 3.15], [...
    mean(distances_ind_trial_back(:, 2)), ...
    mean(distances_ind_trial_back(:, 3)), ...
    mean(distances_ind_trial_back(:, 4))], [ ...
    std(distances_ind_trial_back(:, 2)/sqrt(n_ind)), ...
    std(distances_ind_trial_back(:, 3)/sqrt(n_ind)), ...
    std(distances_ind_trial_back(:, 4)/sqrt(n_ind))], 'k'); hold off;

set(gca, 'XTick', 1:3, 'XTickLabel', {'control', 'gap', 'noise'}, 'FontSize', 12);
set(b2(1), 'FaceColor', cmap(c1, :)); set(b2(2), 'FaceColor', cmap(c2, :));
title('distance', 'FontSize', font_title, 'FontWeight', 'bold');
xlim([0.5 3.5]); 
ylabel('mean distance[m]', 'FontSize', 15, 'FontWeight', 'bold');
xlabel('conditions', 'FontSize', 15, 'FontWeight', 'bold');
legend({'to target', 'to initial'});
line([0.85 1.85], [1.1 1.1], 'Color', 'k');
text(1.35, 1.12, '*', 'FontSize', 14, 'FontWeight', 'bold');

subplot(1, 2, 2); hold on;
plot(1:3, [...
    cv_distance(1), cv_distance(2), cv_distance(3)], '-o', ...
    'Color', cmap(c1, :), 'MarkerFaceColor', cmap(c1, :)); 
plot(1:3, [...
    cv_distance_back(1) cv_distance_back(2) cv_distance_back(3)], '-o', ...
    'Color', cmap(c2, :), 'MarkerFaceColor', cmap(c2, :));

% errorbar(1:3, [...
%     cv_distance(1) cv_distance(2) cv_distance(3)], [...
%     std(cv_distance(1))/sqrt(20), std(cv_distance(2))/sqrt(20), std(cv_distance(3))/sqrt(20)], 'k'); 
% errorbar(1:3, [...
%     cv_distance_back(1) cv_distance_back(2) cv_distance_back(3)], [...
%     std(cv_distance_back(1))/sqrt(20), std(cv_distance_back(2))/sqrt(20), std(cv_distance_back(3))/sqrt(20)], 'k'); 
hold off;

xlim([0.5 3.5]); ylim([0 2.5]);
title('distance - cv', 'FontWeight', 'bold', 'FontSize', font_title);
legend({'to target', 'to initial'});
set(gca, 'XTick', 1:3, 'XTickLabel', {'control', 'gap', 'noise'}, 'FontSize', 12);
ylabel('mean distance[m]', 'FontSize', 15, 'FontWeight', 'bold');
xlabel('conditions', 'FontSize', 15, 'FontWeight', 'bold');

set(fig2,'units','normalized', 'Position', [0.15 0 0.8 0.65]);


%% Reaction times
pvals_rtimetotarget_bs = [...
    stat_bootstrapping(10000, times_ind_trial(:, 1)', times_ind_trial(:, 2)');
    stat_bootstrapping(10000, times_ind_trial(:, 1)', times_ind_trial(:, 3)');
    stat_bootstrapping(10000, times_ind_trial(:, 1)', times_ind_trial(:, 4)');
    stat_bootstrapping(10000, times_ind_trial(:, 2)', times_ind_trial(:, 3)');
    stat_bootstrapping(10000, times_ind_trial(:, 2)', times_ind_trial(:, 4)');
    stat_bootstrapping(10000, times_ind_trial(:, 3)', times_ind_trial(:, 4)');
    ];

pvals_rtimetoinitial_bs = [...
    stat_bootstrapping(10000, times_ind_trial_back(:, 1)', times_ind_trial_back(:, 2)');
    stat_bootstrapping(10000, times_ind_trial_back(:, 1)', times_ind_trial_back(:, 3)');
    stat_bootstrapping(10000, times_ind_trial_back(:, 1)', times_ind_trial_back(:, 4)');
    stat_bootstrapping(10000, times_ind_trial_back(:, 2)', times_ind_trial_back(:, 3)');
    stat_bootstrapping(10000, times_ind_trial_back(:, 2)', times_ind_trial_back(:, 4)');
    stat_bootstrapping(10000, times_ind_trial_back(:, 3)', times_ind_trial_back(:, 4)');
    ];

cv_rtime = [...
    std(times_ind_trial(:, 1))./mean(times_ind_trial(:, 1));
    std(times_ind_trial(:, 3))./mean(times_ind_trial(:, 3));
    std(times_ind_trial(:, 4))./mean(times_ind_trial(:, 4))];

cv_rtime_back = [...
    std(times_ind_trial_back(:, 1))./mean(times_ind_trial_back(:, 1));
    std(times_ind_trial_back(:, 3))./mean(times_ind_trial_back(:, 3));
    std(times_ind_trial_back(:, 4))./mean(times_ind_trial_back(:, 4))];

fig4 = figure(4); clf; 

subplot(1, 2, 1); 
b3 = bar(1:3, [...
    mean(times_ind_trial(:, 2)), mean(times_ind_trial_back(:, 2)); ...
    mean(times_ind_trial(:, 3)), mean(times_ind_trial_back(:, 3)); ...
    mean(times_ind_trial(:, 4)), mean(times_ind_trial_back(:, 4))]); hold on;

errorbar([0.85, 1.85, 2.85], [...
    mean(times_ind_trial(:, 2)), ...
    mean(times_ind_trial(:, 3)), ...
    mean(times_ind_trial(:, 4))], [ ...
    std(times_ind_trial(:, 2)/sqrt(n_ind)), ...
    std(times_ind_trial(:, 3)/sqrt(n_ind)), ...
    std(times_ind_trial(:, 4)/sqrt(n_ind))], 'k');

errorbar([1.15, 2.15, 3.15], [...
    mean(times_ind_trial_back(:, 2)), ...
    mean(times_ind_trial_back(:, 3)), ...
    mean(times_ind_trial_back(:, 4))], [ ...
    std(times_ind_trial_back(:, 2)), ...
    std(times_ind_trial_back(:, 3)), ...
    std(times_ind_trial_back(:, 4))], 'k'); hold off;

set(gca, 'XTick', 1:3, 'XTickLabel', {'control', 'gap', 'noise'}, 'FontSize', 12);
set(b3(1), 'FaceColor', cmap(c1, :)); set(b3(2), 'FaceColor', cmap(c2, :));
legend({'to target', 'to initial'});
title('reaction time', 'FontSize', font_title, 'FontWeight', 'bold');
ylabel('reaction time [s]', 'FontSize', 15, 'FontWeight', 'bold');
xlabel('conditions', 'FontSize', 15, 'FontWeight', 'bold');
box off;


subplot(1, 2, 2); 
plot(1:3, [cv_rtime(1), cv_rtime(2), cv_rtime(3)], '-o', ...
    'Color', cmap(c1, :), 'MarkerFaceColor', cmap(c1, :)); hold on;
plot(1:3, [...
    cv_rtime_back(1) cv_rtime_back(2) cv_rtime_back(3)], '-o', ...
    'Color', cmap(c2, :), 'MarkerFaceColor', cmap(c2, :));

% errorbar(1:3, [...
%     cv_rtime(1) cv_rtime(2) cv_rtime(3)], [...
%     std(cv_rtime(1))/sqrt(20), std(cv_rtime(2))/sqrt(20), std(cv_rtime(3))/sqrt(20)], 'k'); 
% 
% errorbar(1:3, [...
%     cv_rtime_back(1) cv_rtime_back(2) cv_rtime_back(3)], [...
%     std(cv_rtime_back(1))/sqrt(20), std(cv_rtime_back(2))/sqrt(20), std(cv_rtime_back(3))/sqrt(20)], 'k'); 
hold off; box off;

xlim([0.5 3.5]); ylim([0 1]);
title('reaction time - cv', 'FontWeight', 'bold', 'FontSize', font_title);
xlabel('conditions', 'FontSize', 15, 'FontWeight', 'bold');
ylabel('cv reaction time [s]', 'FontSize', 15, 'FontWeight', 'bold');
legend({'to target', 'to initial'});
set(gca, 'XTick', 1:3, 'XTickLabel', {'control', 'gap', 'noise'}, 'FontSize', 12);

set(fig4,'units','normalized', 'Position', [0.15 0 0.8 0.65]);


%% velocities

velocity_ind_trial = distances_ind_trial(:, [1 3 4]) ./ timetotarget;
velocity_ind_trial_back = distances_ind_trial_back(:, [1 3 4]) ./ timetoinitial;

pvals_velocitytotarget_bs = [...
    stat_bootstrapping(10000, velocity_ind_trial(:, 1)', velocity_ind_trial(:, 2)');
    stat_bootstrapping(10000, velocity_ind_trial(:, 1)', velocity_ind_trial(:, 3)');
    stat_bootstrapping(10000, velocity_ind_trial(:, 2)', velocity_ind_trial(:, 3)');
    ];

pvals_velocitytointial_bs = [...
    stat_bootstrapping(10000, velocity_ind_trial_back(:, 1)', velocity_ind_trial_back(:, 2)');
    stat_bootstrapping(10000, velocity_ind_trial_back(:, 1)', velocity_ind_trial_back(:, 3)');
    stat_bootstrapping(10000, velocity_ind_trial_back(:, 2)', velocity_ind_trial_back(:, 3)');
    ];

cv_velocity = [...
    std(velocity_ind_trial(:, 1))./mean(velocity_ind_trial(:, 1));
    std(velocity_ind_trial(:, 2))./mean(velocity_ind_trial(:, 2));
    std(velocity_ind_trial(:, 3))./mean(velocity_ind_trial(:, 3))];

cv_velocity_back = [...
    std(velocity_ind_trial_back(:, 1))./mean(velocity_ind_trial_back(:, 1));
    std(velocity_ind_trial_back(:, 2))./mean(velocity_ind_trial_back(:, 2));
    std(velocity_ind_trial_back(:, 3))./mean(velocity_ind_trial_back(:, 3))];

fig6 = figure(6); clf;

subplot(1, 2, 1); hold on;

bla = bar(1:3, [
    mean(velocity_ind_trial(:, 1)), mean(velocity_ind_trial_back(:, 1)); 
    mean(velocity_ind_trial(:, 2)), mean(velocity_ind_trial_back(:, 2)); 
    mean(velocity_ind_trial(:, 3)), mean(velocity_ind_trial_back(:, 3))]); 

errorbar([0.85, 1.85, 2.85], [...
    mean(velocity_ind_trial(:, 1)), ...
    mean(velocity_ind_trial(:, 2)), ...
    mean(velocity_ind_trial(:, 3))], [ ...
    std(velocity_ind_trial(:, 1)/sqrt(n_ind)), ...
    std(velocity_ind_trial(:, 2)/sqrt(n_ind)), ...
    std(velocity_ind_trial(:, 3)/sqrt(n_ind))], 'k'); 

errorbar([1.15, 2.15, 3.15], [...
    mean(velocity_ind_trial_back(:, 1)), ...
    mean(velocity_ind_trial_back(:, 2)), ...
    mean(velocity_ind_trial_back(:, 3))], [ ...
    std(velocity_ind_trial_back(:, 1)/sqrt(n_ind)), ...
    std(velocity_ind_trial_back(:, 2)/sqrt(n_ind)), ...
    std(velocity_ind_trial_back(:, 3)/sqrt(n_ind))], 'k'); hold off;

set(gca, 'XTick', 1:3, 'XTickLabel', {'control', 'gap', 'noise'}, 'FontSize', 12);
set(bla(1), 'FaceColor', cmap(c1, :)); set(bla(2), 'FaceColor', cmap(c2, :));
title('velocity', 'FontSize', font_title, 'FontWeight', 'bold');
ylabel('velocity [m/s]', 'FontSize', 15, 'FontWeight', 'bold');
xlabel('conditions', 'FontSize', 15, 'FontWeight', 'bold');
legend({'to target', 'to initial'}); box off;



line([0.85 1.85], [0.37 0.37], 'Color', 'k');
text(1.35, 0.38, '*', 'FontSize', 14, 'FontWeight', 'bold');
xlim([0.5 3.5]); ylim([0 0.45]);

subplot(1, 2, 2); 
plot(1:3, [cv_velocity(1), cv_velocity(2), cv_velocity(3)], '-o', ...
    'Color', cmap(c1, :), 'MarkerFaceColor', cmap(c1, :)); hold on;
plot(1:3, ...
    [cv_velocity_back(1) cv_velocity_back(2) cv_velocity_back(3)], '-o', ...
    'Color', cmap(c2, :), 'MarkerFaceColor', cmap(c2, :)); hold off;
box off;



% errorbar(1:3, [...
%     cv_velocity(1) cv_velocity(2) cv_velocity(3)], [...
%     std(cv_velocity(1))/sqrt(20), std(cv_velocity(2))/sqrt(20), std(cv_velocity(3))/sqrt(20)], 'k'); 
% 
% errorbar(1:3, [...
%     cv_velocity_back(1) cv_velocity_back(2) cv_velocity_back(3)], [...
%     std(cv_velocity_back(1))/sqrt(20), std(cv_velocity_back(2))/sqrt(20), std(cv_velocity_back(3))/sqrt(20)], 'k'); 

set(gca, 'XTick', 1:3, 'XTickLabel', {'control', 'gap', 'noise'}, 'FontSize', 12);
xlim([0.5 3.5]); ylim([0 2.5]);
title('velocity - cv', 'FontWeight', 'bold', 'FontSize', font_title);
xlabel('conditions', 'FontSize', 15, 'FontWeight', 'bold');
ylabel('cv velocity [m/s]', 'FontSize', 15, 'FontWeight', 'bold');
legend({'to target', 'to initial'});


set(fig6,'units','normalized', 'Position', [0.15 0 0.8 0.65]);

