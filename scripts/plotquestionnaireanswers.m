global config_;

addpath('getData\') 

[~, cube] = get_data_pilots();

conditions = [1 3 4 6];
questions = [1 1 1 1 2 2 3 3 3 4 4 4 5 5];

type = 1;

data_vector = zeros (1, size (cube, 3));
condition_matrix = zeros (size (cube, 1), size (cube, 3));

for i = 1:numel(conditions)
    i_condition = conditions(i);
    
    figure (1), % boxplot + scatter plot with separated dots
    
    subplot (2, numel(conditions)/2, i);
    for i_question = 1:size(cube, 1)
        type_question = questions(i_question);
        
        [colordots, colorrectangle] = formatquestionnaireplot ...
            (type_question);
        
        rectangle ('position', [(i_question - 0.5) 0 1 8], ...
            'facecolor', colorrectangle, 'linestyle', 'none'); hold on;
        
        for i_subject = 1:size(cube, 3)
            data_vector(i_subject) = cube(i_question, i_condition, ...
                i_subject);
        end
        
        condition_matrix (i_question, :) = data_vector;
        
        scatter (((i_question-0.02*length(data_vector)) + ...
            (1:length(data_vector))*0.04), data_vector, colordots); hold on
        
    end
    
    formataxis(i_condition, type);
    boxplot (condition_matrix', 'colors', 'k');
    
end
