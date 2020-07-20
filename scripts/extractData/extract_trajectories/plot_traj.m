% Plot raw data

cmap = jet(size(traj_handpByTrial, 3));

condtype = {'full arm - movement'; 'full arm - incongruent movement'; ...
    'full arm - incongruent outcome'; 'full arm - incongruent'};

for s = 1%:size(traj_handpByTrial, 1)
    figure, hold on,
    for t = 1:size(traj_handpByTrial, 2)
        subplot(1, size(traj_handpByTrial, 2), t), hold on,
        for w = 1:size(traj_handpByTrial, 3)
            
            aux_trash = traj_handpByTrial{s, t, w};
            
            ind_zeros = find(aux_trash.a == 0 & aux_trash.c == 0);
            aux_trash.a(ind_zeros) = NaN;
            aux_trash.c(ind_zeros) = NaN;
            
            plot(aux_trash.a, -aux_trash.c, 'color', cmap(w, :))
            axis([-150 150 -200 50])
        end
        title(condtype{t});
        xlabel('x [mm from origin]'); ylabel('y [mm from origin]')
    end
end
