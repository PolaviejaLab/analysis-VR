%
% MAIN script for the analysis of the trajectories after the knife falls
% into the hand.
%


%% Common variables
dataDirectory = 'V:\Data\04. Exp1_Frontiers';
filesSubjects = dir(fullfile(dataDirectory, 'Subject*'));

n_subjects = size(filesSubjects, 1);

% load
cacheDirectory = 'E:\GitHub\analysis-VR\cache';
files_hands = dir(cacheDirectory);

%%

for i_subject = 1:n_subjects
    % subject folder
    subjectFolder = fullfile(dataDirectory, filesSubjects(i_subject).name, '\');
    unityFolder = fullfile(dataDirectory, filesSubjects(i_subject).name, '\Unity_Files\');
    fileName = filesSubjects(i_subject).name;
    
    fprintf('Reading data for %s\n', fileName);
    
    % Log_File
    file_log = dir(fullfile(unityFolder, '*.log'));
    fileName_log = fullfile(unityFolder, file_log(1).name);
    
    % Get conditions order
    file_protocol = fullfile(unityFolder, 'protocol_code.txt');
    [~, order_dyn] = get_order_trials (file_protocol);
    
    % get the time stamps of end and begining
    fid = fopen(fileName_log);
    m_log = textscan(fid, '%s %s %s', 'Delimiter', '\t');
    
    i_start = findsame(strmatch('TrialController', m_log{1,2})', ...
        strmatch('Started', m_log{1, 3})');
    
    i_end = findsame(strmatch('TrialController', m_log{1,2})', ...
        strmatch('Entering state TrialFinished', m_log{1, 3})');
    i_end = i_end(2:6);
    
    ts_ = cell2mat(m_log{1});
    ts_start = ts_(i_start, :); ts_end = ts_(i_end, :);
    
    % get .mat
    hands_mat = load(fullfile(cacheDirectory, '\', lower(fileName)));
    hands_trajectories = hands_mat.hands;
    
    
    for i_t = 4:8
        fprintf('Reading trial %d\n', i_t);
        
        % Find all the files with the trajectories
        trajectories_files = dir(fullfile(unityFolder, '* Trial*'));
        
        % Find the timestamp position
        name_ = fullfile(unityFolder, trajectories_files(i_t).name);
        fid_ = fopen(name_);
        m_handp = textscan(fid_, '%s %q %f %f %f', 'Delimiter', ',');
        
        start_ = strmatch(ts_start((i_t - 2), 1:21), m_handp{1});
        end_ = strmatch(ts_end((i_t - 3), 1:21), m_handp{1});
        
        % Trajectories
        hands_ = hands_trajectories{i_t}(:, 2:4);
        hands_trial = hands_(start_(1):end_(1), :) * 100;
        
        % put in a struc
        trajectories{order_dyn(i_t - 3)}.(fileName) = hands_trial;
    end
    
    % plot
    figure, hold on,
    % plot(trajectories{1}.(fileName)(:, 1), trajectories{1}.(fileName)(:, 3));
    plot(trajectories{2}.(fileName)(:, 1), trajectories{2}.(fileName)(:, 3), 'r');
    % plot(trajectories{3}.(fileName)(:, 1), trajectories{3}.(fileName)(:, 3), 'g');
    plot(trajectories{4}.(fileName)(:, 1), trajectories{4}.(fileName)(:, 3), 'k');
    plot(trajectories{5}.(fileName)(:, 1), trajectories{5}.(fileName)(:, 3), 'c');
    hold off, box on;
    xlim([-20 20]); ylim([-13 13])
    
    
end



















%%
% names = fieldnames(trajectories{1});
%
% figure,
% for i = 1:size(names,1)
%     plot(trajectories{2}.(char(names(i)))(1:f_end, 1), trajectories{2}.(char(names(i)))(1:f_end, 3)); hold on
%     plot(trajectories{4}.(char(names(i)))(1:f_end, 1), trajectories{4}.(char(names(i)))(1:f_end, 3), 'r');
%     plot(trajectories{5}.(char(names(i)))(1:f_end, 1), trajectories{5}.(char(names(i)))(1:f_end, 3), 'k');
% end
%
% figure,
% offset = 00;
% for i = 1:size(names,1)
%     plot(trajectories{2}.(char(names(i)))(1:f_end, 1) + offset, trajectories{2}.(char(names(i)))(1:f_end, 3), 'b'); hold on
%     plot(trajectories{2}.(char(names(i)))(1, 1) + offset, trajectories{2}.(char(names(i)))(1, 3), 'xb');
%     %     plot(trajectories{2}.(char(names(i)))(f_end, 1) + offset, trajectories{2}.(char(names(i)))(f_end, 3), 'xb');
%     plot(trajectories{3}.(char(names(i)))(1:f_end, 1), trajectories{3}.(char(names(i)))(1:f_end, 3), 'r');
%     plot(trajectories{3}.(char(names(i)))(1, 1), trajectories{3}.(char(names(i)))(1, 3), 'xr');
%     %     plot(trajectories{3}.(char(names(i)))(f_end, 1), trajectories{3}.(char(names(i)))(f_end, 3), 'xr');
% end



























%% Get the data
% dataDirectory = 'V:\Data\04. Exp1_Frontiers';
% filesSubjects = dir(fullfile(dataDirectory, 'Subject*'));
%
% n_subjects = size(filesSubjects, 1);
% f_end = 75;
%
% % load
% cacheDirectory = 'E:\GitHub\analysis-VR\cache';
% files_hands = dir(cacheDirectory);
%
% for i_subject = 1:n_subjects
%     % subject folder
%     subjectFolder = fullfile(dataDirectory, filesSubjects(i_subject).name, '\');
%     unityFolder = fullfile(dataDirectory, filesSubjects(i_subject).name, '\Unity_Files\');
%     fileName = filesSubjects(i_subject).name;
%
%     fprintf('Reading data for %s\n', fileName);
%
%     % Log_File
%     file_log = dir(fullfile(unityFolder, '*.log'));
%     fileName_log = fullfile(unityFolder, file_log(1).name);
%
%     % Get conditions order
%     file_protocol = fullfile(unityFolder, 'protocol_code.txt');
%     [~, order_dyn] = get_order_trials (file_protocol);
%
%     % get the time stamps of end and begining
%     fid = fopen(fileName_log);
%     m_log = textscan(fid, '%s %s %s', 'Delimiter', '\t');
%
%     i_start = findsame(strmatch('Threat', m_log{1,2})', ...
%         strmatch('Started', m_log{1, 3})');
%
%     i_end = findsame(strmatch('TrialController', m_log{1,2})', ...
%         strmatch('Entering state TrialFinished', m_log{1, 3})');
%     i_end = i_end(2:6);
%
%     ts_ = cell2mat(m_log{1});
%     ts_start = ts_(i_start, :); ts_end = ts_(i_end, :);
%
%     % get .mat
%     hands_mat = load(fullfile(cacheDirectory, '\', lower(fileName)));
%     hands_trajectories = hands_mat.hands;
%
%
%     for i_t = 4:8
%         fprintf('Reading trial %d\n', i_t);
%
%         % Find all the files with the trajectories
%         trajectories_files = dir(fullfile(unityFolder, '* Trial*'));
%
%         % Find the timestamp position
%         name_ = fullfile(unityFolder, trajectories_files(i_t).name);
%         fid_ = fopen(name_);
%         m_handp = textscan(fid_, '%s %q %f %f %f', 'Delimiter', ',');
%
%         start_ = strmatch(ts_start((i_t - 3), 1:21), m_handp{1});
%         end_ = strmatch(ts_end((i_t - 3), 1:21), m_handp{1});
%
%         % Trajectories
%         hands_ = hands_trajectories{i_t}(:, 2:4);
%         hands_threat = hands_(start_(1):end_(1), :) * 100;
%
%         % put in a struc
%         trajectories{order_dyn(i_t - 3)}.(fileName) = hands_threat;
%     end
%
%     % plot
%     figure, plot(trajectories{1}.(fileName)(1:f_end, 1), trajectories{1}.(fileName)(1:f_end, 3)); hold on
%     plot(trajectories{2}.(fileName)(1:f_end, 1), trajectories{2}.(fileName)(1:f_end, 3), 'r')
%     plot(trajectories{3}.(fileName)(1:f_end, 1), trajectories{3}.(fileName)(1:f_end, 3), 'g')
%     plot(trajectories{4}.(fileName)(1:f_end, 1), trajectories{4}.(fileName)(1:f_end, 3), 'k')
%     plot(trajectories{5}.(fileName)(1:f_end, 1), trajectories{5}.(fileName)(1:f_end, 3), 'c')
%     xlim([-20 20]); ylim([-13 13])
%
% end
%
% names = fieldnames(trajectories{1});
%
% figure,
% for i = 1:size(names,1)
%     plot(trajectories{2}.(char(names(i)))(1:f_end, 1), trajectories{2}.(char(names(i)))(1:f_end, 3)); hold on
%     plot(trajectories{4}.(char(names(i)))(1:f_end, 1), trajectories{4}.(char(names(i)))(1:f_end, 3), 'r');
%     plot(trajectories{5}.(char(names(i)))(1:f_end, 1), trajectories{5}.(char(names(i)))(1:f_end, 3), 'k');
% end
%
% figure,
% offset = 00;
% for i = 1:size(names,1)
%     plot(trajectories{2}.(char(names(i)))(1:f_end, 1) + offset, trajectories{2}.(char(names(i)))(1:f_end, 3), 'b'); hold on
%     plot(trajectories{2}.(char(names(i)))(1, 1) + offset, trajectories{2}.(char(names(i)))(1, 3), 'xb');
%     %     plot(trajectories{2}.(char(names(i)))(f_end, 1) + offset, trajectories{2}.(char(names(i)))(f_end, 3), 'xb');
%     plot(trajectories{3}.(char(names(i)))(1:f_end, 1), trajectories{3}.(char(names(i)))(1:f_end, 3), 'r');
%     plot(trajectories{3}.(char(names(i)))(1, 1), trajectories{3}.(char(names(i)))(1, 3), 'xr');
%     %     plot(trajectories{3}.(char(names(i)))(f_end, 1), trajectories{3}.(char(names(i)))(f_end, 3), 'xr');
% end
%
%
% %% Analysis of velocity
%
% % Get velocity array
%
% v_basal = zeros(74, 19);
% for i = 1:size(names,1)
%     x = trajectories{1}.(char(names(i)))(1:f_end, 1);
%     y = trajectories{1}.(char(names(i)))(1:f_end, 3);
%     v = sqrt((x(2:end)-x(1:end-1)).*(x(2:end)-x(1:end-1)) + (y(2:end)-y(1:end-1)).*(y(2:end)-y(1:end-1)));
%     v_basal(:, i) = v;
% end
%
%
% v_onreal = zeros(74, 19);
% for i = 1:size(names,1)
%     x = trajectories{3}.(char(names(i)))(1:f_end, 1);
%     y = trajectories{3}.(char(names(i)))(1:f_end, 3);
%     v = sqrt((x(2:end)-x(1:end-1)).*(x(2:end)-x(1:end-1)) + (y(2:end)-y(1:end-1)).*(y(2:end)-y(1:end-1)));
%     v_onreal(:, i) = v;
% end
%
% % plot mean velocity and std
% figure, hold on,
% p(1) = plot(nanmean(v_basal, 2), 'linewidth', 2),
% plot(nanmean(v_basal, 2) + nanstd(v_basal, 1, 2))
% plot(nanmean(v_basal, 2) - nanstd(v_basal, 1, 2))
% p(2) = plot(nanmean(v_onreal, 2), 'linewidth', 2, 'color', 'r'),
% plot(nanmean(v_onreal, 2) + nanstd(v_onreal, 1, 2), 'r')
% plot(nanmean(v_onreal, 2) - nanstd(v_onreal, 1, 2), 'r')
% legend(p, {'basal dynamic', 'on real'})
% line([30, 30], [-2, 3], 'color', 'k');
% xlim([0 70]);
% ylabel('velocity [cm/frame]');
% xlabel('frames' );
% title('velocity', 'fontweight', 'bold');
% hold off, box on
%
% % Differences in velocity at any timepoint
% addpath('E:\GitHub\analysis-VR\scripts\statistics');
% for kk = 1:74
%     stat_frame(kk)  = stat_bootstrapping(10000, v_basal(kk, :), v_onreal(kk, :));
% end
%
% % Velocity changes within condition
% m_basal = nanmean(v_basal, 2);
% diff_means = nanmean(m_basal([1:34 56:74], :)') - nanmean(m_basal(35:55,:)');
% vec_comp = repmat(diff_means, 1, 10000);
% vec_res = zeros(1, 10000);
%
% for i = 1:10000
%     i_rand = randperm(size(m_basal, 2));
%     vec_perm = m_basal(1, i_rand);
%     vec_res(i) = nanmean(m_basal([1:34 56:74])) - nanmean(m_basal(35:55));
% end
% pval_basal = sum(abs(vec_res) > vec_comp, 2)/10000;
%
% m_onreal = nanmean(v_onreal, 2);
% diff_means = nanmean(m_onreal([1:34 56:74], :)') - nanmean(m_onreal(35:55,:)');
% vec_comp = repmat(diff_means, 1, 10000);
% vec_res = zeros(1, 10000);
%
% for i = 1:10000
%     i_rand = randperm(size(m_onreal, 2));
%     vec_perm = m_onreal(1, i_rand);
%     vec_res(i) = nanmean(m_onreal([1:34 56:74])) - nanmean(m_onreal(35:55));
% end
% pval_onreal = sum(abs(vec_res) > vec_comp, 2)/10000;
%
%
%
%
%
%
%
%

