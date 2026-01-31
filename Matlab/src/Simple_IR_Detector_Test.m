% Simple IR detector test
%
clear
a=arduino('COM6','UNO');
configurePin (a, 'D4', 'DigitalInput'); 
configurePin(a, 'D4', 'pullup');% set pullup resistor

test=0;

while(test <50) % 
    Voltage=readDigitalPin(a, 'D4');
    if (Voltage <= 0.5)
          fprintf('broken \n');
    elseif (Voltage >= 0.6)
          fprintf('unbroken \n');
    end
 
 pause (0.5); % this slows or sppeds read sensor

test=test+1;
end

% Connect transmitter (2 wires) to Ground & +5V
% Connect receiver to GND, +5V and data to pin 4