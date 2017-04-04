function [trajectories] = get_trajectories(n_subjects, filesSubjects, dataDirectory, cacheDirectory)

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
    
    i_start = findsame(strmatch('WaveController', m_log{1,2})', ...
        strmatch('Initial Waved', m_log{1, 3})');
    
    i_end = findsame(strmatch('WaveController', m_log{1,2})', ...
        strmatch('Entering state Waved', m_log{1, 3})');
    
    
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
        
        for i_w = 1:25
            start_ = strmatch(ts_start((((i_t-1)*25)+i_w), 1:21), m_handp{1});
            end_ = strmatch(ts_end((((i_t-1)*25)+i_w), 1:21), m_handp{1});
            
            % Trajectories
            hands_ = hands_trajectories{i_t}(:, 2:4);
            hands_trial = hands_(start_:end_, :) * 100;
            
        end
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

end