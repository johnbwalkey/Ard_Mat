
%load the data
load('eegData.mat');
load('time.mat');
load('eyesClosedTimes.mat');
load('eyesOpenTimes.mat');

%segment the EEG
numSegments=length(eyesClosedTimes); %numSegments per class
segmentLength=500; %in samples (500 = 1 second)
openSegments=zeros(numSegments,segmentLength); 
openSegmentLabels=cell(numSegments,1);
closedSegments=zeros(numSegments,segmentLength); 
closedSegmentLabels=cell(numSegments,1);

%pull out the eyesOpen segments
for i=1:numSegments
    
    thisTimeIndex=find(time<=eyesOpenTimes(i),1,'last');
    openSegments(i,:)=eeg(1,thisTimeIndex:thisTimeIndex+segmentLength-1);
    openSegmentLabels{i,1}='open';
end

%now pull out the eyesClosed segments
for i=1:numSegments
    
    thisTimeIndex=find(time<=eyesClosedTimes(i),1,'last');
    closedSegments(i,:)=eeg(1,thisTimeIndex:thisTimeIndex+segmentLength-1);
    closedSegmentLabels{i,1}='closed';
end

%concatenate the labels and the segments
segments=[openSegments;closedSegments];
labels=[openSegmentLabels;closedSegmentLabels];

%now build feature vectors
%if you use periodogram() with a 128-point fft @ 500hz sample rate, theta
%power will be in bin 3 and alpha will be in bin 4...trust me
nfft=128;
numFeatures=1;
features=zeros(size(segments,1),numFeatures);
for j=1:size(segments,1)
    [p freqs]=periodogram(segments(j,:),[],nfft,500,'one-sided');
    features(j,1)=p(4); %alpha power in bin 4
end

%now we can build a model
knnModel=fitcknn(features,labels);

save('knnModel.mat','knnModel');




