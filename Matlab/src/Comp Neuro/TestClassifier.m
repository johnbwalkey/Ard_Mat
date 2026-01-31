

load ('memFile.dat');

%test the classifier
load('knnModel.mat');
%make 2 different sinusoids 1-second long
t=linspace(0,2*pi,500);
closed=sin(12*t)*2;
open=sin(12*t);

nfft=128;
done=0;
while(~done)
    
   %pass a randomly selected sinusoid
   if(randi(2)==1)
       actualSignal='open';
       p=periodogram(open,[],nfft,500,'one-sided');
       feature=p(4); %alpha in bin 4
   else
       actualSignal='closed';
       p=periodogram(closed,[],nfft,500,'one-sided');
       feature=p(4); %alpha in bin 4
   end
       
   prediction=predict(knnModel,feature);
   display(['actual signal: ' actualSignal 'classifier predictioin: ' prediction]);
   
   pause(1);
    
end