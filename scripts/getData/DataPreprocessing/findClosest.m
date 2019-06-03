function [closestNumber] = findClosest(numbertocheck, arraytocheck)

% This function will find the closest timestamps and then it will find
% which of the wave indices is the closest. It will also check that they
% make sense in terms that it is actually inside the trial.
  
for w = 1:size(arraytocheck, 1)
    try
        aux_(w) = datenum8601(arraytocheck(w, 1:22));
    catch
        aux_(w) = nan;
    end
end


[~, closestNumber] = min(abs(aux_ -numbertocheck));



end