% Simple Voltage Divider
% Arduino, USB cable,  resistor, flex sensor, breadboard, wiring
clear
a=arduino; %(may not need to specify port)
thePin=0;
a.configureAnalogPin(thePin,'input');
done=0;
t=0

while(~done)

    t=t+1
    V=a.readVoltage(thePin); % pull voltage from Arduino
plot(t,V,'r.','markersize',12); 
hold on
pause(1);
   end
% should get something between 0 & 5 - then turn pot



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

%%% could put potentiometer or photo-sensor between