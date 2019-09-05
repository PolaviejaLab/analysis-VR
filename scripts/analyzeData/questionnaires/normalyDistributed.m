function [normality] = normalyDistributed (data)

for i = size(data,1)
[~, normality(i), ~] = swtest(data(1, :), 0.05);
end
end 