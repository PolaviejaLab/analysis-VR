function [results, cube, mat_order] = GetData()

% ORDERESPONSES Takes the questionnaire responses of all the subjects and
% generates a matrix/condition
%
% results is a struct with fields condition1 to condition6
% every field is a n-by-m matrix with
%  n questions and m participants
%
% cube is a 3d matrix question-by-condition-by-subject

addpath('..\');

params = GetParameters ();

files = dir(fullfile(params.dataDirectory, 'Subject*'));

nSubjects = numel (files);
results = struct();

map = [1 2 3 4 0 5 0 6];
cube = nan(14, 6, nSubjects);

for i_subject = 1:nSubjects
    answersFile = fullfile(params.dataDirectory, files(i_subject).name, 'answers.csv');
    protocolFile = fullfile(params.dataDirectory, files(i_subject).name, 'protocol.csv');
    
    [conditionOrder] = getconditionorder(protocolFile);
    mat_order(i_subject, :) = conditionOrder;
    questionnaireResponses = csvread(answersFile);
    
    nTrials = size(questionnaireResponses, 2);
    
    for i_trial = 1:nTrials
        name = ['condition' num2str(conditionOrder(i_trial))];
        results.(name)(:, i_subject) = questionnaireResponses(:, i_trial);
        
        cube(:, i_trial, i_subject) = questionnaireResponses(:, map(conditionOrder(i_trial)));
    end
    
end

end

