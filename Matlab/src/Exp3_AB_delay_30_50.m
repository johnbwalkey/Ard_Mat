% EXPERIMENT 3  FINAL A/B 30-50 inter-trial interval- Random delay
% 
% Random delay between trials (30-50 sec),
% Random box A or B with LED flashing in - flashes for 10 seconds,
% Stim available while LED flashing in poke box.

% Mega & Uno plugged into computer with Mega doing code & Uno serial Stim
    % pin wiring at end of this code
% store data in XLSX
% Video record behavior and DV is ultravocalizations
% Beep and Light (x3) to signal start and end trial (from Mega)

clear
clc
warning ('off'); % stop serialport message

% set the number of trials
disp('20 - 10 second blocks ');
disp('20 is recommended number - approximately 20 minutes to run)!');
  fprintf('\n')
question='How many trials to run : ';
  z= input(question);

% get Subject number and current date
prompt = 'What is the Subject number? ';
x = input(prompt);
date = datestr(now, 'mm/dd/yy');
% D = date;

s=serial('COM13','BAUDRATE',9600);   % to create the serial port Uno
fopen(s); % open the serial port
m=arduino('com5','Mega2560'); % open and run Mega
DDD=1; % data to send to Arduino uno

% Configure Mega for Nose Poke switch IR
configurePin (m, 'D5', 'DigitalInput'); % box 2 (A)
configurePin(m, 'D5', 'pullup');% set pullup resistor
configurePin (m, 'D6', 'DigitalInput'); % box 3 (B)
configurePin(m, 'D6', 'pullup');% set pullup resistor
i=1; % sequence times
k=1; % codes

ST=tic; % to get times (start)
% turn Light & Beep on then off 3 times to signal Start/End Trial

 SE(i)=toc(ST); %start time
 SC(k)=5;
 i=i+1;k=k+1;

j=0;
for j=1:3
    writeDigitalPin (m,'D3',1);
    pause (0.3); % wait 1/3 second
    writeDigitalPin (m,'D3',0);
    pause (0.3);
end
 SE(i)=toc(ST); %start time
 SC(k)=6;
 i=i+1;k=k+1;

jj=0; % clear loop counter for trials

% A set of "z" - 20 second blocks for 1 trial set
for jj=1:z
 % Random poke box 2 or 3
    r=0;
    r=randi([1,2],1); % output is s 1 or 2 (A-B)
    R=r+1; % makes value 2 or 3 to represent the poke box number
        % start timing, WHICH BOX, lite on, check poked, 
abc=0; % loop for blink LEDs
    % Random Time
    rt=0;
    rt=randi([30,50],1); % DE suggested changing to 30 to 50

% Trial block 2 - B ...........................................
if R == 2 % R is B/2
    Ex=0;
 pause(rt); % seconds random delay time between trials

       SE(i)=toc(ST); % start of trial in box B
       SC(k)=10;
       i=i+1;k=k+1;
tic
 while toc<=10
   % LED flashes in box A every 0.1 seconds for 10 seconds (2 Hz)
   % (code for 10 sec in loop = 17 exactly = 8 sec)
     for j=1:12
       Voltage=readDigitalPin(m, 'D5'); % check IR read
        writeDigitalPin (m,'D8',1);
        pause (0.1); % wait 1/10 second
        writeDigitalPin (m,'D8',0);
        pause (0.1);
        
    if (Voltage <= 0.5)% poke box #2 is poked
        % Stim ON in Poke Box 2/B  
         data = 1;
         fprintf(s,'%i',data); % send data to arduino
          pause(1);
        Ex=1;
        writeDigitalPin (m,'D8',0); % lite off in box 2
       SE(i)=toc(ST); % poked in box B
       SC(k)=20;
       i=i+1;k=k+1;
       break;
      end % end flashes for loop
      writeDigitalPin (m,'D8',0);
     end % end for loop
    
    % DE idea -- here you could grab the time 
   writeDigitalPin (m,'D8',0); % lite off in box 2

if Ex ==0
   SE(i)=toc(ST); % time out in box B
   SC(k)=25;
   i=i+1;k=k+1;
end
   writeDigitalPin (m,'D8',0); % lite off in box 2

 end % end while
end % end main if for B

% Trial block 3 - C ...........................................
if R == 3 % R is C/3
    Ex=0;
 pause(rt); % seconds random delay time between trials

       SE(i)=toc(ST); % start of trial in box B
       SC(k)=10;
       i=i+1;k=k+1;
tic
 while toc<=10
   % LED flashes in box A every 0.1 seconds for 10 seconds (2 Hz)
   % (code for 10 sec in loop = 17 exactly = 8 sec)
        for j=1:12
          Voltage=readDigitalPin(m, 'D6'); % check IR read
            writeDigitalPin (m,'D9',1);
            pause (0.1); % wait 1/10 second
            writeDigitalPin (m,'D9',0);
            pause (0.1);

         if (Voltage <= 0.5)% poke box #2 is poked
           % Stim ON in Poke Box 3/C  
             data = 1;
             fprintf(s,'%i',data); % send data to arduino
             pause(1);
        Ex=1;
        writeDigitalPin (m,'D9',0); % lite off in box 2
       SE(i)=toc(ST); % poked in box B
       SC(k)=30;
       i=i+1;k=k+1;
       break;
      end % end flashes for loop
      writeDigitalPin (m,'D9',0);
    end % end for loop
   writeDigitalPin (m,'D9',0); % lite off in box 2

if Ex ==0
   SE(i)=toc(ST); % time out in box B
   SC(k)=35;
   i=i+1;k=k+1;
end
   writeDigitalPin (m,'D9',0); % lite off in box 2
 end % end while
end % trial block 3 / C if

end % end of z trial blocks 
fclose(s);                          % close  serial port

 SE(i)=toc(ST); %start time
 SC(k)=7;
 i=i+1;k=k+1;
% turn Light & Beep on then off 3 times to signal Start/End Trial Set
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
fclose(s); % end communication with arduino Uno

% write xlsx data

a = num2str(x); % subject number
A=['Experiment 3 - Subject # ',a];
AC=cellstr(A); % subject string
b = num2str(date);
B=['Date ',b];
BC=cellstr(B); % date string

% Total time
tt=num2str(ET);
D=['Total Trial Time ',tt];
DC=cellstr(D); % Total Time string

e=[' Event time codes: 5/6/7/8 is start/end '];
CT=cellstr(e);
g=[' Stim time - after poked in B/C - 20/30 '];
SOn=cellstr(g);
f=[' time out B/C- 25/35'];
CT1=cellstr(f);
h=[' Start time of trial B/C - 10/15'];
TT=cellstr(h);

% Number of Trials
zz=num2str(z);
ZZ=['Number of trials: ',zz];
ZT=cellstr(ZZ);

% sequence times
FS=(SE)';

%Event Code Numbers
GS=(SC)';


FileName=['Exp3_',datestr(now, 'dd-mmm-yyyy'), '_',a];
 % myDir  = 'C:\Users\jbw\Documents\MATLAB';
 myFile = [date '.xlsx'];
 pathAndFilename = fullfile(myFile);xlswrite(FileName,AC, 'Sheet1','A1'); % exp# & subject #
 pathAndFilename = fullfile(myFile);xlswrite(FileName,BC, 'Sheet1','A2'); % date
 pathAndFilename = fullfile(myFile);xlswrite(FileName,ZT, 'Sheet1','A3'); % number of trials
 pathAndFilename = fullfile(myFile);xlswrite(FileName,DC, 'Sheet1','A4'); % total trial time
 pathAndFilename = fullfile(myFile);xlswrite(FileName,CT, 'Sheet1','A6'); % Codes text (Start /end of whole trial)
 pathAndFilename = fullfile(myFile);xlswrite(FileName,TT, 'Sheet1','A5'); % Codes text (B/C start trial time)
 pathAndFilename = fullfile(myFile);xlswrite(FileName,CT1, 'Sheet1','A7'); % Codes text (time out time)
 pathAndFilename = fullfile(myFile);xlswrite(FileName,SOn, 'Sheet1','A8'); % Stim on Times after poke
 pathAndFilename = fullfile(myFile);xlswrite(FileName,FS, 'Sheet1','A9'); % Sequence times
 pathAndFilename = fullfile(myFile);xlswrite(FileName,GS, 'Sheet1','B9'); % Code numbers


% Indicate end of script:
clc
fprintf ('The total time to run was %0.1f seconds\n',ET)

% Misc Notes:
% UPLOAD "Button_OR_Mat_stim" code to Arduino Uno
% maybe shape by S going to lite nose-poke with sugar pellets - Criteria?

% Uno - pin 9 to stim red and other to GND (black)
% Mega - D3 is start & end beep & lite + GND

% Mega pins for box 2 lite (D8) [GREEN]
% Mega pin to power and read IR switch broken in Box 2 (D5) [GREEN]
% Mega pins for box 3 lite (D9) [YELLOW]
% Mega pin to power and read IR switch broken in Box 3 (D6) [ORANGE]

% IR detectors to Mega board
% Connect transmitter (2 wires) to Ground & +5V
% Connect receiver to GND, +5V from data digital pins 4-5
% RED is + 5 V & BLACK is GND
