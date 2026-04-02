% run stimulator from code her
clear

freqCount=0;
for  freqCount < 76.429;
   
 for ii=1; ii<2; i++;
     % generate double pulses  for bipolar setting on WPI 365 stimulator
    writeDigitalPin(a,'D9',1)
    pause(us 200/1000000); % 200 micro sec
    writeDigitalPin(a,'D9',0)
    pause(us 20/1000000); % 20 micro sec
    writeDigitalPin(a,'D9',1)
    pause(us 200/1000000); % 200 micro sec
    writeDigitalPin(a,'D9',0)
    pause(us 6500/1000000); % 6500 micro sec
    
    
    pause(3); % do not allow another pulse for 3 seconds
freqCount ++;

pause (0.01); % sample button state at 100 Hz frequency
end  