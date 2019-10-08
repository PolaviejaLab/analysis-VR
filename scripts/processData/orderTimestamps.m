function [orderedTimestamps] = orderTimestamps (timestamps, order)

try
    start = timestamps.trial_start
    finish = timestamps.trial_end
catch
    orderedTimestamps = [];
    return,
end

for i = 1:size(start, 1)
    orderedTimestamps{order(i), 1} = start(i, :);
    orderedTimestamps{order(i), 2} = finish(i, :);
end

end