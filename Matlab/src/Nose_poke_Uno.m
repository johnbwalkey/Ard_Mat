clear
clc

a=arduino('com3'); % Uno for nose poke and cue light

% turn light on then off and end

for j=1:5 % run trial 5 times

% get time stamp and store as variable - date is char variable
 date = datestr(now, 'mm/dd/yy-HH:MM:SS');
D= datenum(date);

% turn on chamber cue light for 5 seconds - 0 is ground so light on
writeDigitalPin (a,'D3',0);
% set nose poke to lo (0) then create voltage variable to read numeric
configurePin(a,'D5','DigitalOutput');
writePWMVoltage(a,'D5',1);% nose poke hi so off in numeric input 1 volt
configurePin(a,'D5', 'DigitalInput');
voltage = readDigitalPin(a,'D5');% read digital nose poke pin in numeric

% time cue light on and check for nose poke to break
time_delay = 1;
tic
while( true )% after 5 seconds nose poke ends to next trial
    if( toc >= time_delay )
        configurePin(a,'D5','DigitalOutput');
        writePWMVoltage(a,'D5',1)
        configurePin(a,'D5', 'DigitalInput');
        voltage= readDigitalPin(a,'D5');
        if voltage == 0
        else
            break;
       end
    end
end

writeDigitalPin (a,'D3',1); % turn cue light off

% Store date num to vector
vec=[D];
D=D+1;
mat(j,:)=datevec(vec);

pause(1); % wait 1 second with light off before running loop again
 
end

% Write XLS file
% get data from vector - row 1 all columns
dat=string(mat);'mm/dd/yy-HH:MM:SS';
filename = 'testdata.xlsx';
A=[dat];
xlswrite(filename,A);
% Saves in Matlab working folder


% General Notes
% write to "a" is arduino mega; "3" is digital pin; 1-or-0 is high or low
% pause(n) pauses execution for n seconds before continuing,
% where n can be any real number
