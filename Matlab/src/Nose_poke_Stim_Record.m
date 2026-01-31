clear
clc

% Mega for nose poke, cue light, run stim, log time
% LOAD arduino code to Mega prior to running
% x=serial('COM8','BaudRate',9600);
x=serial('com3','BaudRate',9600); % ,'Mega2560');
fopen (x);

% Puts out PWM sine wave, DC, or pulses on pin 9 of Mega board
  
for jj=1:5 % run trial 5 times

% get time stamp and store as variable - date is char variable
 date = datestr(now, 'mm/dd/yy-HH:MM:SS');
D= datenum(date);

% turn on chamber cue light for 7 seconds - 0 is ground so light on
writeDigitalPin (x,'D3',0);

% set nose poke to lo (0) then create voltage variable to read numeric
% configurePin(a,'D5','DigitalOutput');
% writePWMVoltage(a,'D5',1);% nose poke hi so off in numeric input 1 volt
% configurePin(a,'D5', 'DigitalInput');
% voltage = readDigitalPin(a,'D5');% read digital nose poke pin in numeric

% time cue light on and check for nose poke to break, if poke then
% stimulation on for 1 second then off and light off

time_delay = 1;

while(time_delay <6) % after 7 seconds nose poke ends to next trial
   if time_delay <7 
        configurePin(x,'D5','DigitalOutput');
        writePWMVoltage(x,'D5',1)
        configurePin(x,'D5', 'DigitalInput');
        voltage= readDigitalPin(x,'D5');
      if voltage == 0
          %fprintf(x,1);
          %doi = doi - 48; % send 1
          doi=1;
          fprintf(x,'%s', char(doi)); % send answer variable content to arduino
      end
    end
pause (1); % delay betweene loops
time_delay= time_delay +1;
end

writeDigitalPin (x,'D3',1); % turn cue light off

% Store date num to vector
vec=(D);
D=D+1;
mat(jj,:)=datevec(vec);

pause(1); % wait 1 second with light off before running loop again
 
end

% get data from vector - row 1 all columns - Write XLS file
dat=string(mat);'mm/dd/yy-HH:MM:SS';
filename = 'testdata.xlsx';
A=(dat);
xlswrite(filename,A);
% Saves in Matlab working folder

fclose (x)
delete (x)
clear x
