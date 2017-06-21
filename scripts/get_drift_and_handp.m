function [drift, handp, n_participants] = get_drift_and_handp ()
global config_;

n_participants = size(config_.participants, 1);
n_conditions = numel(config_.conditionsShort);

% Construct two matrices, one for drift and the other for hand position
% participant x condition

drift = nan(n_participants, n_conditions);
handp = nan(n_participants, n_conditions);

for i_participant = 1:n_participants
    % Load data for participant
    participant = lower(config_.participants{i_participant, 1}); % searches for the name of the participant
    data = load(fullfile(config_.cacheDirectory, [participant '.mat']));
    
    t_drift = [NaN, NaN, data.log.time_drift];
    
    drift(i_participant, :) = [data.results.proprioceptive_drift];
    
    % Load the protocol
    
    %     protocol = [1 2 3 (data.protocol + 3)];
    protocol = data.protocol;
    drift(i_participant, :) = drift(i_participant, protocol); % uncomment for new data
    
    %     [~, ~, mat_order] = get_data_pilots();
    %     mat_order(mat_order == 6) = 5;
    %     mat_order(mat_order == 8) = 6;
    %     drift(i_participant, 2:7) = drift(i_participant, mat_order(i_participant, :)); % uncomment for old data
    
    for i_condition = 1:n_conditions
        
        try
            % Remove nans
            invalid = any(isnan(data.hands{i_condition}), 2);
            data.hands{i_condition}(invalid, :) = [];
            
            [~, I] = min(abs(data.hands{i_condition}(:, 1) - t_drift(i_condition)));
            
            dt = (data.hands{i_condition}(I, 1) - t_drift(i_condition)) * 3600 * 24 * 1000;
            
            order = [data.protocol]; % uncomment for new data
            
            if(dt > 100)
                warning('No sample found within 10ms (%f)', dt);
            else
                handp(i_participant, order(i_condition)) = ...
                    data.hands{i_condition}(I, 2); % uncomment for new data
                %                 handp(i_participant, i_condition) = data.hands{i_condition}(I, 2); % uncomment for old data
            end
        catch
            warning('Skipping participant %d because hand data is missing', i_participant);
            handp(i_participant, i_condition) = NaN;
        end
    end
end

drift(:, 1:2) = []; % uncomment for new data
handp(:, 7:8) = []; % uncomment for new data
% handp(:, 1) = []; % uncomment for previous data
% drift(:, 1) = []; % uncomment for previous data
end