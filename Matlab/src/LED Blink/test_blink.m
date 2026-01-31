clc
clear
a=arduino('com3');
for i=1:20
    writeDigitalPin(a,'D9',1);
    pause(1);
    writeDigitalPin(a,'D9',0);
    pause(1);
end
