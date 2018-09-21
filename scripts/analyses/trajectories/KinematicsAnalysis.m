% TRAJECTORIES is used for the analysis of the trajectories of the task.
addpath('..\..\getData\');
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\Data_Trajectories.mat');


%% 






   
% %% plot the three together
% for i_plot = 2:numel(vecUsed)
%     traj1 = handp_trials{i_plot,3}; traj2 = handp_trials{i_plot,4}; traj3 = handp_trials{i_plot,6};
%     try
%         figure, plot(traj1(:,1), traj1(:,3), 'k'), hold on, plot(traj2(:,1), traj2(:,3), 'b'), plot(traj3(:,1), traj3(:,3), 'r')
%     catch
%         continue;
%     end
%     xlim([-200 200]); ylim([-150 200]);
% end
%     
% 
% %% Plot the only the waves
% 
% colors = ['k', 'b', 'r'];
% 
% for i_plot = 2:numel(vecUsed)
%   
%     try
%     for i_trial = 1:3
%         figure,
%         for i_wave = 1:25
%             currentWave = handp_waves{i_plot,active_trials(i_trial)}{i_wave};
%             plot(currentWave(:,1), currentWave(:,3), 'color' , colors(i_trial)); hold on;
%         end
%     end
%     catch
%         continue;
%     end
%     
%     xlim([-200 200]); ylim([-150 200]);
% end
