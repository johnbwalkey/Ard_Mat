

%build an array of EEG data out of sinusoids to practice building a kNN
%classifier


%first build an array of 12hz sinusoids
sampleRate=500;
numTrials = 10;  %a trial consists of one cycle of opening and closing eyes, 1 second each
duration = numTrials*sampleRate*2;

t=linspace(0,2*pi*numTrials*2,duration);
noise=rand(1,duration)*2-1; %noise between +/- 1
noiseFactor=1; %so you can adjust how much noise to add
eeg=sin(12*t)+noise*noiseFactor; %a 20-second long sinusoid
time=linspace(0,duration*2-2,duration); %times by 2 because the sample rate is once every 2 ms

%now we'll simulate times at which the user closed eyes
eyesClosedTimes=[1000 3000 5000 7000 9000 11000 13000 15000 17000 19000];
eyesOpenTimes=[0 2000 4000 6000 8000 10000 12000 14000 16000 18000];

%now go through the sinusoid and boost the signal at the eyesClosedTimes
for i=1:length(eyesClosedTimes)
    thisTimeIndex=find(time<eyesClosedTimes(i),1,'last');%find the nearest time stamp
    eeg(thisTimeIndex:thisTimeIndex+sampleRate-1)= eeg(thisTimeIndex:thisTimeIndex+sampleRate-1)*2;
end

save('eegData.mat','eeg');
save('eyesOpenTimes.mat','eyesOpenTimes');
save('eyesClosedTimes.mat','eyesClosedTimes');
save('time.mat','time');