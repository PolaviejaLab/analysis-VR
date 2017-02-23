load('..\data\drift.mat');
load('E:\GitHub\analysis-VR\data\type_trial_participant.txt');

trial_type = type_trial_participant([1:9 11:20 22],:);

drift_ = zeros(20, 6);
handp_ = zeros(20, 6);

drift_(:, 1) = drift(:, 1);

for i = 1:size(trial_type, 1)
    for j = 4:8
        if trial_type(i, j) == 1
            drift_(i,3) = drift(i,j-2);
            handp_(i,3) = handp(i,j-2);
        elseif trial_type(i, j) == 11
            drift_(i,6) = drift(i,j-2);
            handp_(i,6) = handp(i,j-2);
        elseif trial_type(i, j) == 101
            drift_(i,5) = drift(i,j-2);
            handp_(i,5) = handp(i,j-2);
        elseif trial_type(i,j) == 1001
            drift_(i,4) = drift(i,j-2);
            handp_(i,4) = handp(i,j-2);
        elseif trial_type(i,j) == 0
            drift_(i,2) = drift(i,j-2);
            handp_(i,2) = handp(i,j-2);
        end
    end
end

