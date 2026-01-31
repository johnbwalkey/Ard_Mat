%% Solenoid In/Out with 5 Volt Power Supply
clear all
a=arduino('com7');
writeDigitalPin(a,9,1);
writeDigitalPin(a,9,0);
pause(1);
