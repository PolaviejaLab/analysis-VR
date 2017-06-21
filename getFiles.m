% GETFILES should be used to get all the files, now it does not do that

dataDirectory = 'V:\Data\05. Experiment2_PilotsOfNoise';
filesSubjects = dir(fullfile(dataDirectory, 'Subject*'));

n_subjects = size(filesSubjects, 1);

staticArray = zeros(8, 2, n_subjects);
dynamicArray = zeros (14, 7, n_subjects);

% E:\GitHub\analysis-VR\scripts\getData\getOrderFromLog.m
load('E:\GitHub\analysis-VR\data\Exp_PilotsNoise\order.mat');

%% get Questionnaire Arrays

for i_subject = 1:n_subjects
    % subject folder
    subjectFolder = fullfile(dataDirectory, filesSubjects(i_subject).name, '\');
    fileName = filesSubjects(i_subject).name;
    
    fprintf('Reading data for %s\n', fileName);
    
    questionnaireFolder = fullfile(dataDirectory, filesSubjects(i_subject).name, '\Questionnaires\');
    
    try
        % Static File
        static_ = csvread(strcat(questionnaireFolder, 'staticblock.csv'));
        order_ = orderMatrix(1:2, i_subject);
        static_ = static_(:, order_);
        staticArray(:, :, i_subject) = static_;
        
        % Dynamic File
        dynamic_ = csvread(strcat(questionnaireFolder, 'dynamicblock.csv'));
        order_ = orderMatrix(4:10, i_subject);
        dynamic_ = dynamic_(:, order_ - 3);
        dynamicArray(:, :, i_subject) = dynamic_;
    catch
        staticArray(:, :, i_subject) = nan;
        dynamicArray(:, :, i_subject) = nan;
    end
    
end

save('E:\GitHub\analysis-VR\data\Exp_PilotsNoise\static.mat', 'staticArray');
save('E:\GitHub\analysis-VR\data\Exp_PilotsNoise\dynamic.mat', 'dynamicArray');
