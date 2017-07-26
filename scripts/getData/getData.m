function [static_array, dynamic_array] = getData (dataDirectory)
orderArray = getOrderFromLog(dataDirectory);

filesSubjects = dir(fullfile(dataDirectory, 'Subject*'));
nSubjects = length(filesSubjects);

for i_subject = 1:nSubjects
    
    % subject folder
  
    questionnaireFolder = fullfile(dataDirectory, filesSubjects(i_subject).name, '\Questionnaires\');
    
    % get questionnaire file
    files_static = dir(fullfile(questionnaireFolder, 'staticblock.csv'));
    files_dynamic = dir(fullfile(questionnaireFolder, 'dynamicblock.csv'));
    
    fileName_static = fullfile(questionnaireFolder, files_static(1).name);
    fileName_dynamic = fullfile(questionnaireFolder, files_dynamic(1).name);
    
    static_table = csvread(fileName_static);
    dynamic_table = csvread(fileName_dynamic);

    order_ = orderArray(:, i_subject);
    
    static_table = [static_table(:, order_(1:2)), static_table(:,3)];
    dynamic_table = [dynamic_table(:, order_(3:4)-2), dynamic_table(:,3)];

end
static_array(:,:, i_subject) = static_table;
dynamic_array(:,:, i_subject) = dynamic_table;

end