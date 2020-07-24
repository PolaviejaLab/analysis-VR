 figure, hold on,

cond_wave_duration =  [];
cond_max_displacement = [];

for t = 1:size(traj_handpByTrial, 2)
    
    all_av_velocity = [];
    all_t_vector = [];
    %subplot(1, size(traj_handpByTrial, 2), t), hold on,
    subplot(2, size(traj_handpByTrial, 2)/2, t), hold on,
    
    
    trial_wave_durations = [];
    trial_max_displacement = [];
    
    for s = 1:size(traj_handpByTrial, 1)
        
        wave_duration = [];
        max_displacement = [];
        for w = 1:size(traj_handpByTrial, 3)
            aux_trash = traj_handpByTrial{s, t, w};
            wave_duration = vertcat(wave_duration, length(aux_trash.a));
        end
        
        max_duration = max(wave_duration);
        
        mat_wave_a_left = [];
        mat_wave_a_right = [];
        mat_wave_c_left = [];
        mat_wave_c_right = [];
        mat_wave_t_left = [];
        mat_wave_t_right = [];
        
        trial_vel_vector = [];
        trial_t_vector = [];
        
        for w = 1:size(traj_handpByTrial, 3)
            aux_trash = traj_handpByTrial{s, t, w};
            
            ind_zeros = find(aux_trash.a == 0 & aux_trash.c == 0);
            aux_trash.a(ind_zeros) = NaN;
            aux_trash.c(ind_zeros) = NaN;
            
            wave_dir = sign(aux_trash.a(end));
            
            if wave_dir < 0
                if length(aux_trash.a) < max_duration
                    wave_a = vertcat(aux_trash.a, nan*ones(max_duration-length(aux_trash.a),1));
                    wave_c = vertcat(aux_trash.c, nan*ones(max_duration-length(aux_trash.c),1));
                    wave_t = vertcat(aux_trash.t, nan*ones(max_duration-length(aux_trash.t),1));
                else
                    wave_a = aux_trash.a;
                    wave_c = aux_trash.c;
                    wave_t = aux_trash.t;
                end
                mat_wave_a_left = horzcat(mat_wave_a_left, wave_a);
                mat_wave_c_left = horzcat(mat_wave_c_left, wave_c);
                mat_wave_t_left = horzcat(mat_wave_t_left, wave_t);
            else
                if length(aux_trash.a) < max_duration
                    wave_a = vertcat(aux_trash.a, nan*ones(max_duration-length(aux_trash.a),1));
                    wave_c = vertcat(aux_trash.c, nan*ones(max_duration-length(aux_trash.c),1));
                    wave_t = vertcat(aux_trash.t, nan*ones(max_duration-length(aux_trash.t),1));
                else
                    wave_a = aux_trash.a;
                    wave_c = aux_trash.c;
                    wave_t = aux_trash.t;
                end
                mat_wave_a_right = horzcat(mat_wave_a_right, wave_a);
                mat_wave_c_right = horzcat(mat_wave_c_right, wave_c);
                mat_wave_t_right = horzcat(mat_wave_t_right, wave_t);
                
                %                 % plot all one individuals waves
                %                 plot(mat_wave_a_left, -mat_wave_c_left, 'color', [1 0 0]); hold on,
                %                 plot(mat_wave_a_right, -mat_wave_c_right, 'color', [0 0 1]);
                %                 axis([-250 250 -200 75])
                %                 xlabel('x')
                %                 ylabel ('y')
            end
            
            % Get kinematics for each wave
            kinematics = get_kinematics_parameters(wave_a, -wave_c, wave_t);
         
            max_displacement = vertcat(max_displacement, kinematics.wavemaxdisplacement);
%             trial_vel_vector = horzcat(trial_vel_vector, kinematics.vel_vector); % uncomment to plot velocity
            trial_t_vector = horzcat(trial_t_vector, wave_t-wave_t(1));
            trial_vel_vector = horzcat(trial_vel_vector, kinematics.turtu_vector); % uncomment to plot turtu
            wave_duration = vertcat(wave_duration, kinematics.waveduration);
            
        end
        
        trial_wave_durations = horzcat(trial_wave_durations, wave_duration);
        trial_max_displacement = horzcat(trial_max_displacement, max_displacement);
        
        % Calculate averages
        av_wave_a_left = nanmedian(mat_wave_a_left, 2);
        std_wave_a_left = nanstd(mat_wave_a_left, 1, 2);
        
        av_wave_a_right = nanmedian(mat_wave_a_right, 2);
        std_wave_a_right = nanstd(mat_wave_a_right, 1, 2);
        
        av_wave_c_left = nanmedian(mat_wave_c_left, 2);
        std_wave_c_left = nanstd(mat_wave_c_left, 1, 2);
        
        av_wave_c_right = nanmedian(mat_wave_c_right, 2);
        std_wave_c_right = nanstd(mat_wave_c_right, 1, 2);
        
        av_velocity = nanmedianthr(trial_vel_vector, 0.25);
        av_t_vector = nanmedian(trial_t_vector,2);
        pad_av_velocity = vertcat(av_velocity, nan*ones(300-length(av_velocity),1));
        pad_t_vector = vertcat(av_t_vector, nan*ones(300-length(av_t_vector),1));
        
        %         % Plot average for all participants
        %         plot(av_wave_a_left, -av_wave_c_left, 'color', [1 0 0]);
        %         plot(av_wave_a_right, -av_wave_c_right, 'color', [0 0 1]);
        %         axis([-250 250 -200 75])
        
        all_av_velocity = horzcat(all_av_velocity, pad_av_velocity);
        all_t_vector = horzcat(all_t_vector, pad_t_vector);
        
    end
    
    cond_wave_duration = vertcat(cond_wave_duration, nanmean(trial_wave_durations));
    cond_max_displacement = vertcat(cond_max_displacement, nanmean(trial_max_displacement));
    
    %     cond_wave_duration = horzcat(cond_wave_duration, wave_duration);
    
    % Plot mean velocity or turtu
%     plot(nanmedian(all_t_vector,2), nanmedianthr(all_av_velocity,0.25), 'k', 'LineWidth', 2)
%     hold on,
%     plot(nanmedian(all_t_vector,2), nanmedianthr(all_av_velocity,0.25) - nanstdthr(all_av_velocity,0.25)/sqrt(43), 'k')
%     plot(nanmedian(all_t_vector,2), nanmedianthr(all_av_velocity,0.25) + nanstdthr(all_av_velocity,0.25)/sqrt(43), 'k')
%     axis([0 3000 0 750]) % Uncomment to plot velocity
%     axis([0 3000 0 6]) % Uncommment to plot turtu
end

