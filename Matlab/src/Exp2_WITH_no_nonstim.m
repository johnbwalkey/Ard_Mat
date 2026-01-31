% Experiment 2 - Classical conditioning 
% This script generates random intervals with a
% specified average interval length. It also contains code to
% deliver a cue light and stim using these intervals.

% we want an average interval between of 90 seconds between cue onsets
% _____________this takes over 1/2 hour to run __________________________
clear
clc
warning ('off'); % stop serialport message

% set the number of trials
disp('The optimal number is 32');
disp('This will take about 20 min to run!');
  fprintf('\n')
question='How many trials to run : ';
  z= input(question);

  % sequence Increment Totals
IT=1:2*z;

avg_interval = 15; % was 90 *** JW __ change from 30 to 15 to see if 45 sec instead of 90
t = 3600; % 3600 is number of seconds in 2 hours
N = 2*t/(avg_interval); % Number of cues/stims in 2 hours if spaced 90 seconds apart
                        % We will generate this many intervals. This is
                        % twice as many as we are likely to need, but this
                        % over-preparation allows picking enough
                        % intervals to cover a 1 hour session without
                        % worrying about running out
              

% set up a stim array with one entry for every second indicating if a cue/stim will 
% presented at that time point
stim_array = rand(2*t,1)<(N/(2*t));

% find the actual intervals
intervals = diff(find(stim_array));
intervals = intervals(intervals>10 & intervals<205); % this limits extreme
        % values but still gives a mean of roughly 90 seconds.
        % determined these values through trial and error                                                   
% ------------------------------------------------------------------------

% get Subject number and current date
prompt = 'What is the Subject number? ';
x = input(prompt);
date = datestr(now, 'mm/dd/yy');
% D = date;
% time = datestr(now,'HH:MM:SS'); NOT LONGER Needed

s=serial('COM4','BAUDRATE',9600);   % to create the serial port Uno
fopen(s);
m=arduino('com7','Mega2560'); % open and run Mega

i=1; % sequence times
k=1; % codes

ST=tic; % to get times (start)
% turn Light & Beep on then off 3 times to signal Start/End Trial

 SE(i)=toc(ST); %start time
 SC(k)=5;
 i=i+1;k=k+1;

% turn Light & Beep on then off to signal trial set 
j=0;
for j=1:3
    writeDigitalPin (m,'D3',1);
    pause (0.3); % wait 1/3 second
    writeDigitalPin (m,'D3',0);
    pause(0.3);
end
 SE(i)=toc(ST); %start time
 SC(k)=6;
 i=i+1;k=k+1;


% ------------------------------------------------------------------------
% Deliver cues and stim with the intervals we've created
% The cue lites are on for 8 sec. then off for stim delivery.
% A quick review of Pavlovian conditioning suggests that a
% 8 second delay between cue and stim coupled with a 90 second inter-trial
% interval will result in strong acquisition of the cue-stim association (see Lattal 1999).

for pl = 1:z  % 40 is 3600/90, so average number of stims expected in an hour
   pause(intervals(pl)); % wait time !!

      % turn on all 3 nose-poke LED's
 SE(i)=toc(ST); %start lights on time
 SC(k)=2;
 i=i+1;k=k+1;
   writeDigitalPin (m,'D5',1);
   writeDigitalPin (m,'D6',1);
   writeDigitalPin (m,'D7',1);

   pause(8); % wait 8 seconds

 % turn off all 3 nose-poke LED's
   writeDigitalPin (m,'D5',0);
   writeDigitalPin (m,'D6',0);
   writeDigitalPin (m,'D7',0);

 SE(i)=toc(ST); % stim time
 SC(k)=1;
 i=i+1;k=k+1;
   % turn on Stimulator - output UNO from pin 9 + GND to A365
    data = 1;
    fprintf(s,'%i',data); % send data to arduino
    pause(1);
% data=0;
end 

fclose(s); % end communication with arduino 

 SE(i)=toc(ST); %start time
 SC(k)=7;
 i=i+1;k=k+1;
% turn Light & Beep on then off to signal trial set 
j=0;
for j=1:3
    writeDigitalPin (m,'D3',1);
    pause (0.3); % wait 1/3 second
    writeDigitalPin (m,'D3',0);
    pause(0.3);
end
 SE(i)=toc(ST); %start time
 SC(k)=8;

 ET=toc(ST); % get total time
%-------------------------------------------------------------------------
% get data and write to xlsx file

a = num2str(x); 
A=['Experiment 2 -- Subject # ',a];
AC=cellstr(A);
b = num2str(date);
B=['Date ',b];
BC=cellstr(B);

% total trial length
c=num2str(ET);
C=['Trial time ',c];
ST=cellstr(C);

% Event code text
e=['Event time codes: 5/6/7/8 is start/end, 2 is LEDs on, 1 is stim on'];
E=cellstr(e);

% sequence times
FS=([SE])';

%Event Code Numbers
GS=([SC])';

FileName=['Exp2_',datestr(now, 'dd-mmm-yyyy'), '_',a];
 % myDir  = 'C:\Users\jbw\Documents\MATLAB';
 myFile = [date '.xlsx'];
 pathAndFilename = fullfile(myFile);xlswrite(FileName,AC, 'Sheet1','A1'); 
 pathAndFilename = fullfile(myFile);xlswrite(FileName,BC, 'Sheet1','A2'); 
 pathAndFilename = fullfile(myFile);xlswrite(FileName,ST, 'Sheet1','A3'); % Total trial time
 pathAndFilename = fullfile(myFile);xlswrite(FileName,E, 'Sheet1','A4'); % Event codes
 pathAndFilename = fullfile(myFile);xlswrite(FileName,GS, 'Sheet1','B5'); % event codes
 pathAndFilename = fullfile(myFile);xlswrite(FileName,FS, 'Sheet1','A5'); % Sequ times

% Indicate end of script:
clc
fprintf ('The total time to run was %0.1f seconds\n',ET);

% Misc Notes: ------------------------------------------------------------
% UPLOAD "Button_OR_Mat_stim" code to Arduino Uno
%  Runs from serial port connection

% Uno - pin 9 to stim red and other to GND (black)
% Mega - D3 is start & end beep & lite + GND
% Mega - D5 is nosepoke #1 lite + GND (Red light wire)
% Mega - D6, D7 are nosepoke lites #2 & #3