

%dump simulated EEG into a memmapped file to simulate the behaviour or the
%Avatar toolbox

numChans=2;
sampleRate=500;
f=12;
period=1/f;
numFrames=1;
frameSize=sampleRate/numFrames; %make sure frame size in evenly divisible into sampleRate
duration=frameSize/sampleRate;

fid=fopen('memFile.dat','w');
fwrite(fid,zeros(numChans,frameSize),'double');
fclose(fid);

%open a file for memory mapping
memFile=memmapfile('memFile.dat','format',{'double' [numChans frameSize] 'd'}, 'writable',true);

t=linspace(0,2*pi,sampleRate);
scaleNoise=1; %so you can adjust how much noise to add

s=sin(12*t); %a 1-second long sinusoid
s=repmat(s,[2 1]);

scaleEEG=1;
startTime=tic; %grab a reference time
done=0;
while(~done)
   
    
    if toc(startTime)>5 %after 5 seconds
        if(scaleEEG==2)
            scaleEEG=1; %change the scale factor back and forth
        else
            scaleEEG=2;
        end
        
        startTime=tic; %and reset the clock
    
    end
    
    %build one second worth of EEG data by adding new noise to sinusoids
    %then slide a frame through it
    noise=rand(numChans,sampleRate)*2-1; %noise between +/- 1
    eeg=s*scaleEEG+noise*scaleNoise;
    
    for i=1:numFrames
        memFile.Data(1,1).d=eeg(:,1:frameSize);
        eeg=circshift(eeg,[0 -frameSize]);
        t=tic;
        while(toc(t)<duration)
        end
        
    end
        
   
end