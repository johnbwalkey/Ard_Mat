% STIMULATION EFFICACY TESTING

% want to determine the wire combinations and amps that produce the most
% behavioral effect.

% 1 - in transport cage on cart - attach portable wire set on flower pots
% and then in transport cage swap wires on A-365 using Uno with push button
% stim an observe most behavior influence like whisking, sniffing, etc.
% after determine the best wires run this Matlab program code.

% using BeepWatch 2 on iPhone as timer - set 2 minute gaps - for 10 minutes
% - change 100 microamps - from 50-60-70-80-90 %

% test efficacy of stim at various stim amplitudes
%   && SHAPING rat to nose poke
% 1. Manually set banana plugs on WPI outputs to subjects to see - 
% 2. Response amplitude- change WPI from 50%  to 60-70-80-90
    % within a set of 5 - 2 minute blocks:
    % light comes on (0.5 sec time out) count nose pokes.
% 3. plot frequency response curve for each rat ( # of pokes (Y) over 50-90
% (X) % stim for a particular wire set.

% Mega & Uno plugged into computer with Mega doing code & Uno serial Stim
% store data in XLSX
% Beep and Light to signal start and end trial (from Mega)

clear; clc;
warning ('off'); % stop serialport message

% get Subject number and current date
prompt = 'What is the Subject number? ';
 x = input(prompt);
 date = datestr(now, 'mm/dd/yy');

% get the electode wires having stimulation
prompt = 'What are the wires having stimulation :  ';
prompt = 'Red=1   Black =2   Yellow = 3    Blue = 4 ';
 y = input(prompt);

% get amplitude value
question='Amplitude amount (default 50%) use 50-60-70-80-90 : ';
 z= input(question);

% get time of trials
question='Length of trails in seconds (10 minutes = 600 seconds) : ';
 u= input(question);

% initialize Arduinos
m=arduino('com4','Mega2560'); % open and run Mega
s=serial('COM3','BAUDRATE',9600);   % create serial port Uno
fopen(s);

% Configure Mega for Nose Poke switch IR
configurePin (m, 'D4', 'DigitalInput'); % box 1
configurePin(m, 'D4', 'pullup');% set pullup resistor

% turn Light & Beep on then off 3 times to signal Start of Trial
j=0;
for j=1:3
    writeDigitalPin (m,'D3',1);
    pause (0.3); % wait 1/3 second
    writeDigitalPin (m,'D3',0);
    pause (0.3); %before back on
end

SE=0;
ST=tic; % to get start time
k=1; % init counter
% poking results in stim on
tic
 while toc <u % variable u is time in seconds input
    % if poke record time and lite off -then repeat
     writeDigitalPin (m,'D7',1); % lite on in box 1
      Voltage=readDigitalPin(m, 'D4');
    if (Voltage <= 0.5)% poke box #1 is poked    
     % Stim ON in Poke Box 1  
         data = 1;
         fprintf(s,'%i',data); % send data to arduino

        SE(k)=toc(ST); % stim time
        k=k+1;

      fprintf('poked \n') % print to screen
      writeDigitalPin (m,'D7',0); % lite off in box 1
      pause(1); % this delay is NECESSARY & makes rat back out nosepoke box
    end % end if
 end % while
writeDigitalPin (m,'D7',0); % lite off in box 1

ET=toc(ST); % get total time

% turn Light & Beep on then off 3 times to signal End Trial
j=0;
for j=1:3
    writeDigitalPin (m,'D3',1);
    pause (0.3); % wait 1/3 second
    writeDigitalPin (m,'D3',0);
    pause (0.3); %before back on
end

fclose(s); % end communication with arduino 

% write xlsx data

a = num2str(x); 
A=['Experiment 1 -- Subject # ',a];
AC=cellstr(A); % subject string

b = num2str(date);
B=['Date ',b];
BC=cellstr(B); % date string

% wires used for stim
d = num2str(y);
SW=['Wires used for stimulation : ',d];
WS=cellstr(SW); 

% Amplitude amount value
nt=num2str(z);
ntt=['Amplitude amount value: ',nt];
NT=cellstr(ntt);

% Total time
c = num2str(ET);
D=['Total Trial Time ',c];
DC=cellstr(D); % Total Time string

% Pokes times in time block
e=['Poke times in seconds in a trial'];
TT=cellstr(e); % Sequence text to string

% poke times transposed
 FS=([SE])';

FileName=['Efficacy_Test__',datestr(now, 'dd-mmm-yyyy'), '_',a];
 % myDir  = 'C:\Users\jbw\Documents\MATLAB';
 myFile = [date '.xlsx'];
pathAndFilename = fullfile(myFile);xlswrite(FileName,AC, 'Sheet1','A1');% Subject string
pathAndFilename = fullfile(myFile);xlswrite(FileName,BC, 'Sheet1','A2');% Date string
pathAndFilename = fullfile(myFile);xlswrite(FileName,WS, 'Sheet1','A3');% Wires to stim with
pathAndFilename = fullfile(myFile);xlswrite(FileName,NT, 'Sheet1','A4');% Amplitude amount
pathAndFilename = fullfile(myFile);xlswrite(FileName,DC, 'Sheet1','A5');% Total time
pathAndFilename = fullfile(myFile);xlswrite(FileName,TT, 'Sheet1','A6');% Poke times text
pathAndFilename = fullfile(myFile);xlswrite(FileName,FS, 'Sheet1','B7');% Poke times data

% Misc Notes:
% UPLOAD "Button_OR_Mat_stim" code to Arduino Uno
% Uno - pin 9 to stim red and other to GND (black)

% Mega - D3 is start & end beep & lite + GND
% Mega pins for box 1 lite (D7) [RED]
% Mega pin to power and read IR switch broken in Box 1 (D4) [PURPLE]

% IR detector to Mega board
% Connect transmitter (2 wires) to Ground & +5V
% Connect receiver to GND, +5V and data to digital pin 4
% RED is + 5 V & BLACK is GND