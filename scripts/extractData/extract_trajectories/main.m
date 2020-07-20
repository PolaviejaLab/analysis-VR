addpath('..\..\');

%% Variables
[params] = GetParameters();

filesSubjects = dir(fullfile(params.dataDirectory, params.experimentTypes{2}));
filesSubjects = filesSubjects(3:end);


% load the sociodem from main

%% Extract from one subject
traj_handpByTrial = cell(numel(subjectData.subjectID), 4, 30);
for subnum = 1:numel(subjectData.subjectID)
    for s = 1:length(filesSubjects)
        if strcmp(filesSubjects(s).name, char(subjectData.subjectID(subnum)))
            % Getting trial timestamps
            fullfile(params.dataDirectory, params.experimentTypes{2}, filesSubjects(s).name)
            logFile = dir(fullfile(params.dataDirectory, params.experimentTypes{2}, filesSubjects(s).name, '*.log'));
            logFile_name = fullfile(params.dataDirectory, params.experimentTypes{2}, filesSubjects(s).name, logFile.name);
            try
                % Start and end of the trials
                [~, trialTimestampsStart] = get_timestamps (logFile_name, 'TrialController', ...
                    'Started');
                [~, trialTimestampsEnd] = get_timestamps (logFile_name, 'TrialController', ...
                    'Event SpTrialFinished');
                fprintf('Trial timestamps data extracted \n');
            catch
                trialTimestampsStart = NaN;
                trialTimestampsEnd = NaN;
                fprintf('No trial timestamps data available \n');
            end
            
            
            % Extract waves timestamps
            try
                % Start and end of the individual waves
                [~, wavesTimestampsStart] = get_timestamps(logFile_name, 'WaveController', ...
                    'Entering state Target');
                [~, wavesTimestampsEnd] = get_timestamps(logFile_name, 'WaveController', ...
                    'Entering state Feedback');
                fprintf('Wave timestamps data extracted \n');
            catch
                wavesTimestampsStart = NaN;
                wavesTimestampsEnd = NaN;
                fprintf('No waves timestamps data available \n');
            end
            
            % Divide waves by trial
            wavesStartByTrial = cell(4, 1);
            wavesEndByTrial = cell(4, 1);
            
            for t = 1:4
                wavesStartByTrial{t} = wavesTimestampsStart(find(wavesTimestampsStart > trialTimestampsStart(t) & ...
                    wavesTimestampsStart < trialTimestampsEnd(t)));
                wavesEndByTrial{t} = wavesTimestampsEnd(find(wavesTimestampsStart > trialTimestampsStart(t) & ...
                    wavesTimestampsStart < trialTimestampsEnd(t)));
            end
            
            % Get trajectory data
            trajectory_files = dir(fullfile(params.dataDirectory, params.experimentTypes{2}, filesSubjects(s).name, '* Trial *.csv'));
            trajectory_files = trajectory_files(1:4);
            
            for t = 1:numel(trajectory_files)
                fprintf('Reading data for trial %u \n', t);
                
                fid = fopen(fullfile(params.dataDirectory, params.experimentTypes{2}, filesSubjects(s).name, trajectory_files(t).name));
                try
                    traject_file = textscan(fid, '%s %q %f %f %f', 'Delimiter', ',');
                    
                    handp_a = traject_file{1, 3};
                    handp_b = traject_file{1, 4};
                    handp_c = traject_file{1, 5};
                    
                    handp_t = [];
                    
                    for ht = 1:length(handp_a)
                        handp_t = vertcat(handp_t, TransformToMiliseconds(char(traject_file{1, 1}(ht))));
                    end
                catch
                    handp_trials{s, t} = NaN;
                    timestamps_trials{s, t} = NaN;
                    fprintf('no trajectory file for trial %u in subject %u \n', ...
                        t, s);
                end
                fclose(fid);
                
                trial_order = var.orderTrials.outcomeOwnership(:, subnum);
                % divide trajectory by waves
                for w = 1:30
                    
                    aux_start = find(handp_t > wavesStartByTrial{t}(w),1);
                    aux_end = find(handp_t < wavesEndByTrial{t}(w));
                    aux_end = aux_end(end);
                    
                    traj_handpByTrial{subnum, trial_order(t), w}.a =  handp_a(aux_start : aux_end);
                    traj_handpByTrial{subnum, trial_order(t), w}.b =  handp_b(aux_start : aux_end);
                    traj_handpByTrial{subnum, trial_order(t), w}.c =  handp_c(aux_start : aux_end);
                    traj_handpByTrial{subnum, trial_order(t), w}.t =  handp_t(aux_start : aux_end);
                end
                
            end
            
        end
        
    end
    
end


