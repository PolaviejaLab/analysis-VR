

fileName = 'V:\Data\04. Exp1_Frontiers\Subject08\Bonsai_Files\screenrecording_video2016-07-05T09_24_06.avi';
newName = 'gap_condition.avi';

video_object = VideoReader(fileName);
new_object = VideoWriter(newName);

new_object.FrameRate = 45;

% vidHeight = video_object.Height; 
% vidWidth = video_object.Width;

nFrames = video_object.NumberOfFrames;
start_frame = 43000;
end_frame = start_frame + 600;

open(new_object);

for i= start_frame:end_frame
  
    videoFrame=read(video_object,i);
    
    writeVideo(new_object, videoFrame);
    
%     imshow(videoFrame);

end



