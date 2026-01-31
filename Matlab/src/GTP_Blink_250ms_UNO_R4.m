%// ChatGTP - blink 250 ms for Uno R4
% Create an Arduino object
a = arduino('com1','uno');

% Define the pin for the LED
ledPin = 'D13';

% Set the pin mode to output
configurePin(a, ledPin, 'DigitalOutput');

% Blink the LED every 250 milliseconds
while true
    writeDigitalPin(a, ledPin, 1);  % Turn ON the LED
    pause(0.25);                    % Pause for 250 milliseconds
    writeDigitalPin(a, ledPin, 0);  % Turn OFF the LED
    pause(0.25);                    % Pause for 250 milliseconds
end
