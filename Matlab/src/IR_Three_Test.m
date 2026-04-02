% Simple IR detector test with 3 IR devices
%
clear
a=arduino('COM7','Mega2560');
configurePin (a, 'D4', 'DigitalInput'); 
configurePin(a, 'D4', 'pullup');% set pullup resistor
configurePin (a, 'D5', 'DigitalInput'); 
configurePin(a, 'D5', 'pullup');% set pullup resistor
configurePin (a, 'D6', 'DigitalInput'); 
configurePin(a, 'D6', 'pullup');% set pullup resistor

test=0;

while(test <200) % 
    Voltage=readDigitalPin(a, 'D4');
    if (Voltage <= 0.5)
          fprintf('broken 4\n');
    elseif (Voltage >= 0.6)
          fprintf('unbroken 4\n');
    end
 
        Voltage=readDigitalPin(a, 'D5');
    if (Voltage <= 0.5)
          fprintf('broken 5\n');
    elseif (Voltage >= 0.6)
          fprintf('unbroken 5\n');
    end
        Voltage=readDigitalPin(a, 'D6');
    if (Voltage <= 0.5)
          fprintf('broken 6\n');
    elseif (Voltage >= 0.6)
          fprintf('unbroken 6\n');
    end
    
 pause (1); % this slows or speeds read sensor

test=test+1;
end

% Connect transmitter (2 wires) to Ground & +5V
% Connect receiver to GND, +5V and data to pins 4-5-6