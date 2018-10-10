function [totalSeconds] = TransformToSeconds (timestamps_string)

hourInSeconds = str2num(timestamps_string(1:2)) * 3600;
minutesInSeconds = str2num(timestamps_string(4:5)) * 60;
seconds = str2num(timestamps_string(7:8));

totalSeconds = hourInSeconds + minutesInSeconds + seconds;

end