sampleRate=48000;
row1=rand(1,48000);
row2=row1;
theSound=[row1;row2];
theSound=theSound.*2;
theSound=theSound-1;

%shift bottom

theSound(2,:)=circshift(theSound(2,:),[0,20]);
%play
sound(theSound,sampleRate);
% neg would move left