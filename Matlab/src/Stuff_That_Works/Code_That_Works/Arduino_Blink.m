% Arduino Blink - 1/60 of a second
clear
a=arduino('com7');
for i=0:20
    writeDigitalPin(a,13,1);
    pause(.01);
    writeDigitalPin(a,13,0);
    pause(.01);
end
