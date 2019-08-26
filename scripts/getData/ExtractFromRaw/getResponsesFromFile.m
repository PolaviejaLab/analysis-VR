function [responses] = getResponsesFromFile (input)



resMat(:, 1) = str2num(char(input{1, 1}));

responseArray = char(input{1, 2});

% Check if all Alpha

for n = 1:size(responseArray, 1)
    if (strmatch('Alpha', responseArray(n, :)))
        resMat(n,2) = str2num(responseArray(n, 6));
    else
        resMat(n,2) = nan;
    end
end

sortedMat = sortrows(resMat, 1);
responses = sortedMat(:, 2);

end 