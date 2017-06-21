function data = readParticipantData ...
    (participant, datetime, directory, debug)
% READPARTICIPANTDATA  Read all participant data from the directory
%  specified.
%
%  .version     Version number of the structure
%  .result      Data from the CSV results file (see READRESULTSFILE)
%  .log         Data from the trial log (see READTRIALLOG)
%  .hands       Palm positions for every trial (time, x, y, z)
%

    % If no directory is specified, use data directory as default
    if(nargin < 3)
        directory = fullfile('..', 'data', participant);
    end
    
    % Disable debug mode by default
    if(nargin < 4)
        debug = 0;
    end
   
    % Extract time (in hours) from a string (yyyy-MM-dd hh:mm)
    time_from_datetime = @(t) str2double(t(12:13)) + str2double(t(14:15)) / 60;

    % Enumerate all files in data directory that start with date 
    if(~exist(directory, 'dir'))
        error('Directory %s does not exist.', directory);
    end
    
    
    fprintf(datetime)
    pattern = fullfile(directory, [datetime(1:10) '*']);
    
    files = dir(pattern);
    
    if numel(files) == 0
        error('Could not find any files: %s', pattern);
    end
    
    % Get time of first file in dataset
    time = time_from_datetime(datetime);    
    results = {};
    hand_positions = cell(0, 1);
    
    for i_file = 1:numel(files)
        % Skip files that have a timestamp in the past
        file_name = files(i_file).name;
        file_time = time_from_datetime(file_name);
        
        if(file_time < time)
            if(debug), fprintf('Skipping file %s because it is older than %s\n', file_name, datetime); end
            continue;
        else
            fprintf('Processing file %s\n', file_name);
        end

        fullfilename = fullfile(directory, file_name);
        [~, ~, ext] = fileparts(files(i_file).name);
        
        if(strcmp(ext, '.log'))
            if(debug), fprintf('Reading trial log: %s\n', file_name); end
            
            log = readTrialLog(fullfilename);
        else
            if(strcmp(ext, '.csv'))
                tokens = regexp(files(i_file).name, 'Trial ([0-9]*).csv', 'tokens');
            
                % Contains Trial # in the name, this is a hand positions file
                if(numel(tokens) == 1)
                    trial_nr = str2double(tokens{1});

                    fprintf('Reading hand positions for trial %d\n', trial_nr);
                    hand_positions{trial_nr} = readHandPositions(fullfilename);
                else
                    results{end + 1} = readResultsFile(fullfilename);
                end            
            end
        end        
    end
    
    % Convert Unity coordinates into LEAP coordinates
%     Ntrials = min(numel(results), numel(hand_positions));
%     for i = 1:Ntrials
%         N = size(hand_positions{i}, 1);
%         M = [0 0 1 -0.184 + results{i}.offset; 
%              0 1 0 -0.499; 
%              -1.11 0 0 -3.822; 
%              0 0 0 1]';
% 
%         
%          
%         Tr = [hand_positions{i}(:, 2:4) ones(N, 1)] * M;        
%         hand_positions{i}(:, 2:4) = Tr(:, 1:3);
%     end
    
      % Get the protocol
    addpath('..\getData\');
%     [ ~, order_dynamic] = get_order_perl (directory);
[orderArray] = getOrderFromLog (participant);

    
    
    % Combine results (drift) from all files
    results = [results{:}];

    data = struct( ...
        'version', 1, ...
        'results', results, ...
        'log', log, ...
        'protocol', orderArray);

    data.hands = hand_positions;
end
