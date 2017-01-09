figure
for i = 3:8
    subplot(3,2,i-2);
    T = data.hands{i}(:, 1);
    xyz = data.hands{i}(:, 2:4);
    plot(T, xyz(:, 1)); hold on;
    
    plot(data.log(i-2).time_drift, 0, 'rx');
   
end



