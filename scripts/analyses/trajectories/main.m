%
% MAIN script for the analysis of the trajectories after the knife falls
% into the hand.
%

%% Get the data

dataDirectory = 'V:\Data\04. Exp1_Frontiers';
filesSubjects = dir(fullfile(dataDirectory, 'Subject*'));

n_subjects = size(filesSubjects, 1);

trajectories = {};

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
    
    i_start = findsame(strmatch('Threat', m_log{1,2})', ...
        strmatch('Started', m_log{1, 3})');
    
    i_end = findsame(strmatch('TrialController', m_log{1,2})', ...
        strmatch('Entering state TrialFinished', m_log{1, 3})');
    i_end = i_end(2:6);
    
    ts_ = cell2mat(m_log{1});
    ts_start = ts_(i_start, :); ts_end = ts_(i_end, :);
    
    
    % Find all the files with the trajectories
    trajectories_files = dir(fullfile(unityFolder, '* Trial*'));
    
    for i_files = 4:8;
        fprintf('Reading trial %d\n', i_files);
        name_ = fullfile(unityFolder, trajectories_files(i_files).name);
        fid_ = fopen(name_);
        m_handp = textscan(fid_, '%s %q %f %f %f', 'Delimiter', ',');
        
        handp = [m_handp{3}, m_handp{4}, m_handp{5}];
        
        % find the closest indexes to ts_start and ts_finish
        start_ = strmatch(ts_start((i_files - 3), 1:21), m_handp{1});
        end_ = strmatch(ts_end((i_files - 3), 1:21), m_handp{1});
        
        
        % get the values
        threat_handp = handp(start_(1):end_(1), :);
        
        % transform
        M = [0 0 1 -0.184;
            0 1 0 -0.499;
            -1.11 0 0 -3.822;
            0 0 0 1]';
        
        N = size(threat_handp, 1);
        trans_handp = [threat_handp ones(N, 1)] * M;
        trans_handp = trans_handp(:, 1:3) * 100;
        
        trajectories{i_files - 3}.(fileName) = trans_handp;
        
        % order
        
    end 

end