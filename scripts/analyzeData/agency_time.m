%% Get Data
addpath('..\getData\');
[stat_array, dyn_array] = get_data (0);

%% Set the variables
nAgency = 7:9;

%% Arrays
agn_dyn = dyn_array(nAgency, :, :);

mn_questions_dyn = squeeze(mean(agn_dyn));
mn_trial_dyn = mean(mn_questions_dyn, 2); 

std_questions_dyn = std(mn_questions_dyn');
sdt_trial_dyn = std(mn_questions_dyn');

%% Plot raw means 
figure(1), clf; hold on,
errorbar(mn_trial_dyn, sdt_trial_dyn, 'k');
plot(mn_trial_dyn, 'or', 'MarkerSize', 10, 'MarkerFace', 'r');
ylim([0.5 7.5]); xlim([0.5 5.5]);
set(gca,'XTick', 1:5, 'XTickLabel',{'D1', 'D2', 'D3', 'D4', 'D5'});
title('Sense of agency over trials over time');
ylabel('Questionnaire response');
xlabel('Trial');
hold off, 



%% Normalizing
norm_div_dyn = zeros(22, 5);

norm_div_dyn(:, 1) = mn_questions_dyn(1, :) ./ mn_questions_dyn(1, :);
norm_div_dyn(:, 2) = mn_questions_dyn(2, :) ./ mn_questions_dyn(1, :);
norm_div_dyn(:, 3) = mn_questions_dyn(3, :) ./ mn_questions_dyn(1, :);
norm_div_dyn(:, 4) = mn_questions_dyn(4, :) ./ mn_questions_dyn(1, :);
norm_div_dyn(:, 5) = mn_questions_dyn(5, :) ./ mn_questions_dyn(1, :);

mn_norm_div_dyn = mean(norm_div_dyn);
std_norm_div_dyn = std(norm_div_dyn);

figure(2), clf; hold on,
errorbar(mn_norm_div_dyn, std_norm_div_dyn, 'k'); 
plot(mn_norm_div_dyn, 'or', 'MarkerSize', 10, 'MarkerFace', 'r');
hold off;
ylim([0 2]); xlim([0.5 5.5]);
set(gca,'XTick', 1:5, 'XTickLabel',{'D1', 'D2', 'D3', 'D4', 'D5'});
title('Sense of agency over time');
xlabel('Trial');
hold off, 


%% Normalizing
norm_res_dyn = zeros(22, 5);

norm_res_dyn(:, 1) = mn_questions_dyn(1, :) - mn_questions_dyn(1, :);
norm_res_dyn(:, 2) = mn_questions_dyn(2, :) - mn_questions_dyn(1, :);
norm_res_dyn(:, 3) = mn_questions_dyn(3, :) - mn_questions_dyn(1, :);
norm_res_dyn(:, 4) = mn_questions_dyn(4, :) - mn_questions_dyn(1, :);
norm_res_dyn(:, 5) = mn_questions_dyn(5, :) - mn_questions_dyn(1, :);

mn_norm_res_dyn = mean(norm_res_dyn);
std_norm_res_dyn = std(norm_res_dyn);

figure(3), clf; hold on,
errorbar(mn_norm_res_dyn, std_norm_res_dyn, 'k'); 
plot(mn_norm_res_dyn, 'or', 'MarkerSize', 10, 'MarkerFace', 'r');
hold off;
ylim([-3 3]); xlim([0.5 5.5]);
set(gca,'XTick', 1:5, 'XTickLabel',{'D1', 'D2', 'D3', 'D4', 'D5'});
title('Sense of agency over time');
xlabel('Trial');
hold off, 