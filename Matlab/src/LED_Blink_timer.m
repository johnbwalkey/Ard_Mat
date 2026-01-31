a = arduino();
clear a;
a = arduino('COM4', 'Uno');

%{
Turn LED on and off. Write value 1 or true to digital pin 11
turns on the built-in LED and write a value of 0 or false turns it off.
Execute the following command at the MATLAB prompt to turn the LED off and on 
- Configure the LED to blink at a period of 1/100 second - ten times
%}

for i = 1:10
      writeDigitalPin(a, 'D9', 0);
      pause(0.1);
      writeDigitalPin(a, 'D9', 1);
      pause(0.1);
end

clear // clear variables