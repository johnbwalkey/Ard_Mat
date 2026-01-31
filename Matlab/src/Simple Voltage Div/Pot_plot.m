% Simple Voltage Divider
% USb cable, pot, breadboard wired ( on pot the middle pin is the variable)
a=arduino; %(may not need to specify port)
thePin=0;
a.configureAnalogPin(thePin,'input');
done=0;
t=0

while(~done)

    t=t+1
    V=a.readVoltage(thePin); % pull voltage from Arduino
plot(t,V,'markerFaceColor',[0 0 0]); %black RGB
hold on
pause(.5);
   end
% should get something between 0 & 5 - then turn pot

% can just replace pot with analog light sensor

%% quick and dirty technique to do low pass filter
% take a messy signal and a chunk of it then average the data in the chunk.
% then move a sample
% use circ shift
window=zeros(1,5); % what if make this 10 or 20 (creates phase lag)
done=0;
while (~done)
    t=t+1;
    window=circshift(window,[0 1]);
    window(1,end)=a.readVoltage(thePin)
    V=mean(window,2);
    
end

%%% could put flexsensor between photsensor and plus power
