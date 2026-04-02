% Blink LED from Chat GTP
clc
clear
% Define the Arduino object
arduinoObj = arduino('COM5', 'Mega2560'); % Replace 'COMx' with the appropriate COM port

% Define the pin connected to the LED
ledPin = 'D13';

% Set up the LED pin as an output
configurePin(arduinoObj, ledPin, 'DigitalOutput');

% Blink the LED every 250 milliseconds
while true
    writeDigitalPin(arduinoObj, ledPin, 1); % Turn the LED on
    pause(0.25); % Pause for 250 milliseconds
    writeDigitalPin(arduinoObj, ledPin, 0); % Turn the LED off
    pause(0.25); % Pause for 250 milliseconds
end

% Clean up when done
clear arduinoObj;

