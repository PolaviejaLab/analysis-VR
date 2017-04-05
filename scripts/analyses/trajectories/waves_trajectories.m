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

for i_subject = 1:1
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
    i_start = i_start(2:6);
    
    i_end = findsame(strmatch('TrialController', m_log{1,2})', ...
        strmatch('Entering state TrialFinished', m_log{1, 3})');
    i_end = i_end(2:6);
    
    ts_ = cell2mat(m_log{1});
    ts_start = ts_(i_start, :); ts_end = ts_(i_end, :); % gets the timestamps on the log file
    
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
        
        start_ = strmatch(ts_start((i_t - 3), 1:21), m_handp{1});
        end_ = strmatch(ts_end((i_t - 3), 1:21), m_handp{1});
        
        % Trajectories
        hands_ = hands_trajectories{i_t}(:, 2:4);
        hands_trial = hands_(start_(1):end_(1), :) * 100;
        
        % put in a struc
        trajectories{order_dyn(i_t - 3)}.(fileName) = hands_trial;
        
        % waves
        for i = 1:25
            w_start = findsame(...
                strmatch('WaveController', ...
                m_log{1,2}{i_start(i_t - 3):i_end(i_t - 3)})', ...
                strmatch('Initial Waved', ...
                m_log{1, 3}{i_start(i_t - 3):i_end(i_t - 3)})');
                        
            w_end = findsame(...
                strmatch('WaveController',...
                m_log{1,2}{i_start(i_t - 3):i_end(i_t - 3)})', ...
                strmatch('Entering state Waved', ...
                m_log{1, 3}{i_start(i_t - 3):i_end(i_t - 3)})');
        end
        
    end
    
end

