load('knnModel.mat');

sampleRate=500;
nfft=128;

memMapFileName='memFile.dat';
numChans=2;
useChan=1;
frameSize=500;
frameDuration=frameSize/sampleRate;

dataWindowSize=frameSize*1; %how many samples you want to view

global memFile;
memFile=memmapfile(memMapFileName,'format',{'double' [numChans frameSize] 'd'}, 'writable',false);  %the +1 is the timestamps channel.  Mac OS and Unix let you memmory map more than one file for writting.  I think Windows complains about this.
display('succesfully memmapped the EEG data');

dataWindow=zeros(numChans,dataWindowSize);

done=0;
while(~done)
   
    t=tic;
    data=memFile.Data(1,1).d;
    
    p=periodogram(data(useChan,:),[],nfft,sampleRate,'one-sided');
    feature=p(4); %bin 4 is alpha power at 12hz
    
    %classify this power
    prediction=predict(knnModel,feature);

    display(['that looks like ' prediction]);
    
    %for plotting
    dataWindow=circshift(dataWindow,[0 -frameSize]);
    dataWindow(:,end-frameSize+1:end)=data;
    subplot(2,1,1);
    plot(dataWindow(1,:));
    ylim([-2 2]);
    subplot(2,1,2);
    plot(dataWindow(2,:));
    ylim([-2 2]);
    drawnow;
    while(toc(t)<frameDuration)
        %wait
    end
    
end