% Arduino Blink pin 13 every second 10 times
clear
a=arduino('com7');
% on - off
for i=1:10 
    writeDigitalPin(a,13,0);
    pause(1);
    writeDigitalPin(a,13,1); 
    pause(1); 
end
