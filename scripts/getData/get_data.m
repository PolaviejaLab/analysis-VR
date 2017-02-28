function [static_array, dynamic_array] = get_data (order)

dataDirectory = 'V:\Data\05. Experiment2_PilotsOfNoise';

filesSubjects = dir(fullfile(dataDirectory, 'Subject*'));

% declare variables
nSubjects = length(filesSubjects);

static_array = zeros (8, 2, nSubjects);     % 2 static conditions
dynamic_array = zeros (14, 7, nSubjects);   % 7 dynamic conditions

for i_subject = 1:nSubjects
    
    % subject folder
    subjectFolder = fullfile(dataDirectory, filesSubjects(i_subject).name, '\');
    questionnaireFolder = fullfile(dataDirectory, filesSubjects(i_subject).name, '\Questionnaires\');
    
    % get questionnaire file
    files_static = dir(fullfile(questionnaireFolder, 'staticblock.csv'));
    files_dynamic = dir(fullfile(questionnaireFolder, 'dynamicblock.csv'));
    
    fileName_static = fullfile(questionnaireFolder, files_static(1).name);
    fileName_dynamic = fullfile(questionnaireFolder, files_dynamic(1).name);
    
    static_table = csvread(fileName_static);
    dynamic_table = csvread(fileName_dynamic);
    
    if (order == 1)
        [order_static, order_dynamic] = get_order_perl (subjectFolder); 
    else
        order_static = [1, 2];
        order_dynamic = [1, 2, 3, 4, 5, 6];
    end
    
    static_table = static_table(1:8, order_static);
    dynamic_table = dynamic_table(:, order_dynamic);
    
    static_array(:, :, i_subject) = static_table;
    dynamic_array(:, :, i_subject) = dynamic_table;
    
end

end
