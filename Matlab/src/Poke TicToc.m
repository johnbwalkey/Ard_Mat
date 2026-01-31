clear
clc

% Mega for nose poke and cue light
a=arduino('com8'); % set a to board

% turns on stimulator - LOAD arduino code to Mega pre testing
% Puts out PWM sine wave, DC, or pulses on pin 9 of Mega board
  
for j=1:5 % run trial 5 times

% get time stamp and store as variable - date is char variable
 date = datestr(now, 'mm/dd/yy-HH:MM:SS');
D= datenum(date);

% turn on chamber cue light for 7 seconds - 0 is ground so light on
writeDigitalPin (a,'D3',0);

% set nose poke to lo (0) then create voltage variable to read numeric
% configurePin(a,'D5','DigitalOutput');
% writePWMVoltage(a,'D5',1);% nose poke hi so off in numeric input 1 volt
% configurePin(a,'D5', 'DigitalInput');
% voltage = readDigitalPin(a,'D5');% read digital nose poke pin in numeric

% time cue light on and check for nose poke to break, if poke then
% stimulation on for 1 second then off and light off
% time_delay = 1;
           session.ard=serial('com3');%,'baudrate',115200); % set com (try 9600 ?)
              fopen(session.ard);% open Stim code on arduino
%                 if ~strcmp(stim.status,'open')
%                 fprintf(1, 'Could not open arduino serial port.\n');
%                 end
tic; % start timer
while toc <7; 
%     (time_delay <6) % after 7 seconds nose poke ends to next trial
%     if time_delay <7 
        configurePin(a,'D5','DigitalOutput');
        writePWMVoltage(a,'D5',1)
        configurePin(a,'D5', 'DigitalInput');
        voltage= readDigitalPin(a,'D5');
        if voltage == 0
              session.stimpar = 'bw200;a255;g20;z3000;';
              break;
                % change g20 to 0,10 and look at scope
              % fclose(session.ard); % end communication with arduino stim code
        else
            break;
       end
    end
pause (1); % delay betweene loops
% time_delay= time_delay +1;
end

writeDigitalPin (a,'D3',1); % turn cue light off
fclose(session.ard); % end communication with arduino stim code
% Store date num to vector
vec=(D);
D=D+1;
mat(j,:)=datevec(vec);

pause(1); % wait 1 second with light off before running loop again
 
end

% Write XLS file
% get data from vector - row 1 all columns
dat=string(mat);'mm/dd/yy-HH:MM:SS';
filename = 'testdata.xlsx';
A=(dat);
xlswrite(filename,A);
% Saves in Matlab working folder


% General Notes
% write to "ard" is arduino mega; "3" is digital pin; 1-or-0 is high or low
% pause(n) pauses execution for n seconds before continuing,
% where n can be any real number
