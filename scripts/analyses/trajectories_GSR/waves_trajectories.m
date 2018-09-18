%
% WAVES_TRAJECTORIES script for the analysis of the trajectories in all the
% trials from the initial light to the target light and stores them.
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
    
    t_start = findsame(strmatch('TrialController', m_log{1,2})', ...
        strmatch('Started', m_log{1, 3})');
    t_start = t_start(2:6);
    
    t_end = findsame(strmatch('TrialController', m_log{1,2})', ...
        strmatch('Entering state TrialFinished', m_log{1, 3})');
    t_end = t_end(2:6);
    
    ts_ = cell2mat(m_log{1});
    ts_start = ts_(t_start, :); ts_end = ts_(t_end, :); % gets the timestamps on the log file
    
    % get .mat
    hands_mat = load(fullfile(cacheDirectory, '\', lower(fileName)));
    hands_trajectories = hands_mat.hands;
    
    
    for i_t = 4:8
        close all, 
        fprintf('Reading trial %d\n', i_t);
        
        % Find all the files with the trajectories
        trajectories_files = dir(fullfile(unityFolder, '* Trial*'));
        name_ = fullfile(unityFolder, trajectories_files(i_t).name); % current trial
        fid_ = fopen(name_);
        m_handp = textscan(fid_, '%s %q %f %f %f', 'Delimiter', ',');
        
        % Find the timestamp position
        start_ = strmatch(ts_start((i_t - 3), 1:21), m_handp{1});
        end_ = strmatch(ts_end((i_t - 3), 1:21), m_handp{1});
        
        % Trajectories
        hands_ = hands_trajectories{i_t}(:, 2:4);
        hands_trial = hands_(start_(1):end_(1), :) * 100;
        
        % put in a struc the full trajectories for each subject
        trajectories{order_dyn(i_t - 3)}.(fileName) = hands_trial;
        
        % find the trajectories to target for each trial.
        
        % This gets the indexes for the initial and start of each wave
        % state
        w_start = findsame(...
            strmatch('WaveController', ...
            m_log{1,2}(t_start(i_t - 3):t_end(i_t - 3), 1))', ...
            strmatch('Initial Waved', ...
            m_log{1, 3}(t_start(i_t - 3):t_end(i_t - 3), 1))');
  
        w_end = findsame(...
            strmatch('WaveController',...
            m_log{1,2}(t_start(i_t - 3):t_end(i_t - 3), 1)'), ...
            strmatch('Waved', ...
            m_log{1, 3}(t_start(i_t - 3):t_end(i_t - 3), 1)'));
        
        % Gets the timestamps of the indexes found.
        wts_start = ts_(w_start + t_start(i_t - 3), :); 
        wts_end = ts_(w_end + t_start(i_t - 3), :);
        
        
        % Takes each timestamps from the log file and find the closest
        % timestamp in the handposition file, and returns the index.
        for w = 1:size(wts_start)
            start_w = strmatch(wts_start(w, 1:21), m_handp{1});
            end_w = strmatch(wts_end(w, 1:21), m_handp{1});
            hands_wave = hands_(start_w(1):end_w(1), :) * 100;
            
            fprintf('plotting trajectories for wave %u \n',w);
            figure, clf, plot(hands_wave(:, 1), hands_wave(:, 3)), hold on
            
            % trajectories_wave{order_dyn(i_t - 3)}.(w) = hands_wave;
        end
    end
end

