function [ts_array] = order_data(inputArray, i_subj)
% ORDER_DATA takes a cell input and reorders it according to the trial
% order of each participant
% 
%       ts_array is the output cell, ordered. 
%       inputArray is the cell without being ordered by trial
%       i_subj is the subject index

% load order files
trial_participant =load('..\..\data\type_trial_participant.txt');
trialArray = trial_participant(i_subj, :);

ind_ts = zeros(1, 8);

aux_stat = trialArray(1, 1:2);
aux_dyn = trialArray(1, 4:8);

% find index order
for ind = 1:size(aux_stat, 2)
    if aux_stat(1, ind) == 0
        ind_ts(ind) = 1;
    elseif aux_stat(1, ind) == 100
        ind_ts(ind) = 2;
    end
end

if trialArray(1, 3) == 0
    ind_ts(3) = 3;
end

for ind = 1:size(aux_dyn, 2)
    if aux_dyn(1, ind) == 0
        ind_ts(1, ind+3) = 4;
    elseif aux_dyn(1, ind) == 1
        ind_ts(1, ind+3) = 5;
    elseif aux_dyn(1, ind) == 1001
        ind_ts(1, ind+3) = 6;
    elseif aux_dyn(1, ind) == 11
        ind_ts(1, ind+3) = 8;
    elseif aux_dyn(1, ind) == 101
        ind_ts(1, ind+3) = 7;
    end
end

% add trials without timestamps
c = cell(8, 1);
c{1} = 0;
c{2} = 0;
c{3} = 0;
c{4} = inputArray{1};
c{5} = inputArray{2};
c{6} = inputArray{3};
c{7} = inputArray{4};
c{8} = inputArray{5};

% order timestamps by: (static) basal, gap, (dynamic) habituation,
% no-offset, basal, on-real, gap, noise.
ts_array = cell(8, 1);
for i = 1:size(c, 1)
    ts_array{ind_ts(i)} = c{i};
end

end