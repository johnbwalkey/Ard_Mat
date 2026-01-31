% pot_Plot.m
% this is basicalyy a Voltage Divider
clear
a=arduino; %(may not need to specify port)

t=100
done=0 
while(~done)
    
    voltage = readVoltage(a, 'A0');
    writePWMVoltage(a,'D9', voltage);
    
% Plot    
plot(t,voltage,'r+:'); % red plus sign to display
hold on
pause(1);
t=t+1
   end
   
% should get something between 0 & 5 - then turn pot
% Ctrl + C to end (click in Command Window)
