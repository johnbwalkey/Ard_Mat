% TEST Med-Assoc pellet feeder
% Cohort 3 Classical Conditioing

clear % clear data and variables
clc   % clear command window

disp('Run 5 trials -- type 1 to drop pellet ');

port='COM4';
board='Mega2560';
a = arduino(port, board); % open and run Mega


% run 5 times
B=0;
for B=1:5
    prompt = 'drop pellet ? ';
    x = input(prompt);
        if x==1
            writeDigitalPin (a,'D8',0);
            pause (0.1); % wait 1/10 second
            writeDigitalPin (a,'D8',1);
                pause(1);
        end
end

% Wiring Connect:

% Mega D8 is run pellet relay ( red to 5 V and black to GND)

