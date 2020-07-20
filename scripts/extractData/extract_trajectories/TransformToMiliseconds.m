function [totalmiliseconds] = TransformToMiliseconds (timestamps_string)

hourInSeconds = str2num(timestamps_string(12:13)) * 3600;
minutesInSeconds = str2num(timestamps_string(15:16)) * 60;
seconds = str2num(timestamps_string(18:19));

totalmiliseconds = (hourInSeconds + minutesInSeconds + seconds)*1000 + str2num(timestamps_string(21:23));



end