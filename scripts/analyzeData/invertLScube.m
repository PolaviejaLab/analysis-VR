function [cube_inverted] = invertLScube (cube_toinvert);

%% Invert the Lickert Scale

x = [1, 2, 3, 4, 5, 6, 7]; % value in the means
y = [7, 6, 5, 4, 3, 2, 1]; % new value that I want to get

[p,S] = polyfit(x,y,1);

% eq -> y = -mx + 8

%% Invert values of cube

cube_inverted = zeros (size(cube_toinvert, 1), ...
    size(cube_toinvert, 2), size(cube_toinvert, 3));

for i_x = 1:size(cube_toinvert, 1)
    for i_y = 1:size(cube_toinvert, 2)
        for i_z = 1:size(cube_toinvert, 3)
            cube_inverted(i_x, i_y, i_z) = -cube_toinvert(i_x, i_y, i_z) + 8;
        end 
    end
end
end