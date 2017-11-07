function [output] = removeCloseNumbers (input)

for i = 1:numel(input)-1
    a = input(i); b = input(i + 1);
    if (b == a + 1 || b == a + 2)
        input(i + 1) = nan;
    end
    output = input;
    output(isnan(output)) = [];
end

end