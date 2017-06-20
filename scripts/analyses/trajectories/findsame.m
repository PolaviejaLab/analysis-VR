function [same] = findsame (vect1, vect2)

i_same = 1; 
same = [];

for i = 1:length(vect1)
    for j = 1:length(vect2)
        if (vect1(i) == vect2(j))
            same(i_same) = vect1(i);
            i_same = i_same + 1;
        end    
    end
end

if (length(same) == 0)
    fprintf('no equal numbers\n')
end

end