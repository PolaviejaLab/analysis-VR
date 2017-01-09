function [order_static, order_dynamic] = get_order_perl (subjectFolder)

% addpath(fullfile(subjectFolder));
addpath(fullfile(subjectFolder, '\Unity_Files\'));

mat_code = csvread('protocol_code.txt');

%static 

if (mat_code(1) == 0)
    order_static = [1 2];
elseif(mat_code(1) == 100)
    order_static = [2 1];
else 
    order_static = [NaN NaN];
end

% dynamic

order_dynamic = [NaN NaN NaN NaN NaN];

for i_cond = 4:8
    if (mat_code(i_cond) == 0)
        order_dynamic(i_cond - 3) = 1;
    elseif(mat_code(i_cond)  == 1)
        order_dynamic(i_cond - 3) = 2;
    elseif(mat_code(i_cond) == 1001)
        order_dynamic(i_cond - 3) = 3;
    elseif(mat_code(i_cond) == 101)
        order_dynamic(i_cond - 3) = 4;
    elseif(mat_code(i_cond) == 11)
        order_dynamic(i_cond - 3) = 5;
    else
        order_dynamic(i_cond - 3) = NaN;
    end
end 


end 

