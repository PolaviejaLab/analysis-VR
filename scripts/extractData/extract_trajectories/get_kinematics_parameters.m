function [kinematics] = get_kinematics_parameters (x, y, t)

kinematics.waveduration = t(end) - t(1);

disp_vector = sqrt((x-x(1)).*(x-x(1)) + (y-y(1)).*(y-y(1)));
kinematics.wavemaxdisplacement = max(disp_vector);

vel_vector = 0;
for ti = 1:length(t)-1
    vel_vector = vertcat(vel_vector, sqrt((x(ti+1) - x(ti))^2 + (y(ti+1) - y(ti))^2)/(t(ti +1) - t(ti)));
end

kinematics.vel_vector = vel_vector*1000;

kinematics.turtu_vector = (cumsum(vel_vector)./disp_vector).*vertcat(0, diff(t));

end