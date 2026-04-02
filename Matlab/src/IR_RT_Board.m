% IR ReactionTime Finger Board
% unpredictable nose-poke light comes on in poke box 2 or 3 
    % to signal stim available in Poke box 1
        % rat pokes where lite on then goes to #1 and pokes for stim
% within a 20 second block, random number for 'which' lite on in 2 or 3
% A set of 16 -20 second blocks for 1 test set PLUS
    % 16 possible 20 second blocks for lite/stim ON
% 32 - 20 sec blocks is 6 minutes per trial
% No predictive cues. Rat pairs lite in 2 or 3 with stim in box 1
    % works for stim in instrumental conditioned test

% store data in XLSX

% Beep and Light to signal start and end trial (from Mega)

clear
clc
warning ('off'); % stop serialport message

% set the number of trials
disp('32 - 20 second blocks is 6 minutes per trial');
disp('try 64 (instead of 32) - recommended number (could take 20 minutes to run)!');
  fprintf('\n')
question='How many trials to run : ';
  z= input(question);

% get Subject number and current date
prompt = 'What is the Subject number? ';
x = input(prompt);
date = datestr(now, 'mm/dd/yy');
% D = date;

m=arduino('com7','Mega2560'); % open and run Mega

% turn Light & Beep on then off 3 times to signal Start/End Trial
j=0;
for j=1:3;
    writeDigitalPin (m,'D3',1);
    pause (0.3); % wait 1/3 second
    writeDigitalPin (m,'D3',0);
end

% Configure Mega for Nose Poke switch IR
configurePin (m, 'D4', 'DigitalInput'); % box 1
configurePin(m, 'D4', 'pullup');% set pullup resistor
configurePin (m, 'D5', 'DigitalInput'); % box 2
configurePin(m, 'D5', 'pullup');% set pullup resistor
configurePin (m, 'D6', 'DigitalInput'); % box 3
configurePin(m, 'D6', 'pullup');% set pullup resistor

k=1 ; kk=1; % set initial values for loop counters(Codes & Times)

STT=tic; % to get total time (start)

i=0; % clear loop counter for trials

% A set of "z" - 20 second blocks for 1 trial set
for i=1:z
 % Random poke box 2 or 3
    r=0;
    r=randi([1,2],1); % output is s 1 or 2
    R=r+1; % makes value 2 or 3 to represent the poke box number
        % start timing, WHICH BOX, lite on, check poked, 
        % if poked lite/stim on in #1

% Trial block 2 ...........................................
tic 
if R == 2 % R is 2
     BST=tic; % B block Start Time
     writeDigitalPin (m,'D8',1); % lite on in box 2
   while (toc<20); % if poke record time and lite off -then to poke 1
      Voltage=readDigitalPin(m, 'D5');
    if (Voltage <= 0.5)% poke box #2 is poked    
            writeDigitalPin (m,'D8',0); % lite off in box 2
    Code(k)=20;
    SeqT(kk)=toc(BST);
    k=k+1; kk=kk+1;
    writeDigitalPin (m,'D8',0); % lite off box #2
    break
    else
     Code(k)=25;
     SeqT(kk)=20;
     k=k+1; kk=kk+1;
    end
     % Poke box #1 - test & record time
        A1=tic % start time in Box 1
        writeDigitalPin (m,'D7',1); % lite on in box 1
   tic
   while (toc<20)
         % if yes to nose poke then stim on
           Voltage=readDigitalPin(m, 'D4');
      if (Voltage <= 0.5)
         % Stim ON in Poke Box 1  
           % turn on Stimulator - output UNO from pin 9 + GND to A365
            s=serial('COM3','BAUDRATE',9600);   % create serial port Uno
            fopen(s);                           % open the serial port
            pause (1);                        % wait 1/2 second
            fclose(s);                          % close  serial port
        Code(k)=10;
        SeqT(kk)=toc(A1);
        k=k+1; kk=kk+1;
          writeDigitalPin (m,'D7',0); % lite off inbox 1
        break
      else
        Code(k)=15;
        SeqT(kk)=20;
        k=k+1; kk=kk+1; 
      end
   end
   end
 end % end if - trial block 2






TT = toc(STT); % total time end

% write xlsx data
% x is subject #, D is date, BT is total time begin to end
% ST1(i) is box 1 time, ST2(i) is box 2 time, ST3(i) is box 3 time

a = num2str(x); % subject number
A=['Experiment 3 - Subject # ',a];
AC=cellstr(A); % subject string
b = num2str(date);
B=['Date ',b];
BC=cellstr(B); % date string

% Total time
tt=num2str(TT);
D=['Total Trial Time ',tt];
DC=cellstr(D); % Total Time string

e=['Codes: 20 is pokebox B(#2), 30 is pokebox C(#3), 10 is pokebox A(#1)'];
CT=cellstr(e);
f=['Codes: 25 is timeout B(#2), 35 is timeout C(#3), 15 is timeout A(#1)'];
CT1=cellstr(f);
g=['Sequences times'];
CT2=cellstr(g);

% convert Code var to column
Codes=(Code)';

% Sum times
for ii=1:length(SeqT), seqTimes(ii)=sum(SeqT(1:ii)); end
ST=(seqTimes)';

FileName=['Exp3_',datestr(now, 'dd-mmm-yyyy'), '_',a];
 % myDir  = 'C:\Users\jbw\Documents\MATLAB';
 myFile = [date '.xlsx'];
 pathAndFilename = fullfile(myFile);xlswrite(FileName,AC, 'Sheet1','A1'); % exp# & subject #
 pathAndFilename = fullfile(myFile);xlswrite(FileName,BC, 'Sheet1','A2'); % date
 pathAndFilename = fullfile(myFile);xlswrite(FileName,DC, 'Sheet1','A3'); % total trial timee
 pathAndFilename = fullfile(myFile);xlswrite(FileName,CT, 'Sheet1','A4'); % code text 1
 pathAndFilename = fullfile(myFile);xlswrite(FileName,CT1, 'Sheet1','A5'); % code text 2
 pathAndFilename = fullfile(myFile);xlswrite(FileName,CT2, 'Sheet1','A6'); % seq time text
 pathAndFilename = fullfile(myFile);xlswrite(FileName,Codes, 'Sheet1','A7'); % codes
 pathAndFilename = fullfile(myFile);xlswrite(FileName,ST, 'Sheet1','B7'); % Sequence times


 % Indicate end of script:
clc
fprintf ('The total time to run was %0.1f seconds\n',TT)

% Misc Notes:
% maybe shape by S going to lite nose-poke with sugar pellets - Criteria?

% Uno - pin 9 to stim red and other to GND (black)
% Mega - D3 is start & end beep & lite + GND

% Mega pins for box 1 lite (D7) [RED]
% Mega pin to power and read IR switch broken in Box 1 (D4) [PURPLE]
% Mega pins for box 2 lite (D8) [GREEN]
% Mega pin to power and read IR switch broken in Box 2 (D5) [GREEN]
% Mega pins for box 3 lite (D9) [YELLOW]
% Mega pin to power and read IR switch broken in Box 3 (D6) [ORANGE]

% IR detectors to Mega board
% Connect transmitter (2 wires) to Ground & +5V
% Connect receiver to GND, +5V from data digital pins 4-5-6
% RED is + 5 V & BLACK is GND
