function output_vector = findUsed(input_table, file_column)

vecUsed = table2array(input_table(:, file_column));
output_vector = find(vecUsed == 1);

end
