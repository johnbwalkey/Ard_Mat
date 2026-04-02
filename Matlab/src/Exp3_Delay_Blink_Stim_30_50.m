% EXPERIMENT FINAL - Random delay - flash LEDs 10 sec - stim available
% Random delay between trials (30-50 sec)
% LED in box A flashes for 10 seconds, THEN, 
% Led off and stim available for 10 seconds in poke box A

% Mega & Uno plugged into computer with Mega doing code & Uno serial Stim
    % pin wiring at end of this code
% store data in XLSX
% Video record behavior and DV is ultravocalizations - Note WHEN
% Beep and Light to signal start and end trial (from Mega)

clear
clc
warning ('off'); % stop serialport message

% set the number of trials
disp('Run 20 trials (takes about 20 minutes to run) ');
  fprintf('\n')
question='How many trials to run : ';
  z= input(question);

% get Subject number and current date
prompt = 'What is the Subject number? ';
x = input(prompt);
date = datestr(now, 'mm/dd/yy');
% D = date;

s=serial('COM4','BAUDRATE',9600);   % to create the serial port Uno
fopen(s); % open the serial port
m=arduino('com5','Mega2560'); % open and run Mega
DDD=1; % data to send to Arduino uno

i=1; % sequence times
k=1; % codes

ST=tic; % to get times (start)
% turn Light & Beep on then off 3 times to signal Start/End Trial

 SE(i)=toc(ST); %start time
 SC(k)=5;
 i=i+1;k=k+1;

j=0;

 SE(i)=toc(ST); %start time
 SC(k)=6;
 i=i+1;k=k+1;

% Configure Mega for Nose Poke switch IR
configurePin (m, 'D4', 'DigitalInput'); % box 1
configurePin(m, 'D4', 'pullup');% set pullup resistor
configurePin (m, 'D5', 'DigitalInput'); % box 2
configurePin(m, 'D5', 'pullup');% set pullup resistor
configurePin (m, 'D6', 'DigitalInput'); % box 3
configurePin(m, 'D6', 'pullup');% set pullup resistor

jj=0; % clear loop counter for trials
B=0;
% Start LED BEEP
for B=1:3
    writeDigitalPin (m,'D3',1);
    pause (0.3); % wait 1/3 second
    writeDigitalPin (m,'D3',0);
    pause(0.3);
end
cts=datetime; % computer time as start time (after beep/LED start)
B=0;
pause(5); % pause 5 seconds after start signal.

% A set of "z" - blocks
for jj=1:z
 % LED flashing loop counter
 j=0;
    % Random Time
    r=0;
    r=randi([30,50],1); %DE suggested changing to 30 to 50 -20 min to run
% Trial block ...........................................
pause(r); % seconds random delay time between trials
    Ex=0;
     writeDigitalPin (m,'D7',1); % start time LED blinking in box A
       SE(i)=toc(ST); 
       SC(k)=10;
       i=i+1;k=k+1;
   % LED flashes in box A every 0.1 seconds for 10 seconds
   % (code for 10 sec = 31 exactly 9.7 sec)
        for j=1:31
            writeDigitalPin (m,'D7',1);
            pause (0.1); % wait 1/10 second
            writeDigitalPin (m,'D7',0);
            pause (0.1);
        end % end flashes
    writeDigitalPin (m,'D7',0); % lite off in box A
     % End of Blink & start time of stim available
          SE(i)=toc(ST); 
          SC(k)=15;
          i=i+1;k=k+1;

  % If Poke box A = true
   tic
  	 while (toc<=10)
        Voltage=readDigitalPin(m, 'D4');
       
       	 if (Voltage <= 0.5) % if yes to nose poke then stim on
             SE(i)=toc(ST); % poke time
             SC(k)=20;
             i=i+1;k=k+1;
           Ex=1;

         % Stim ON in Poke Box 1  
         data = 1;
         fprintf(s,'%i',data); % send data to arduino
          pause(1);
         break
        end % end if
     end % end while

    writeDigitalPin (m,'D7',0); % lite off in box A

if Ex ==0
   SE(i)=toc(ST); % time out in box A
   SC(k)=30;
   i=i+1;k=k+1;
   writeDigitalPin (m,'D7',0); % lite off in box A
end % end Ex if
 end % end if for stim
% end % end main if for trial

% end % end of z trial blocks

fclose(s);         % close  serial port

 SE(i)=toc(ST); %start time
 SC(k)=7;
 i=i+1;k=k+1;

pause (5); % pause 5 seconds at end before LED & BEEP

% turn Light & Beep on then off 3 times to signal Start/End Trial Set
B=0;
for B=1:3
    writeDigitalPin (m,'D3',1);
    pause (0.3); % wait 1/3 second
    writeDigitalPin (m,'D3',0);
    pause(0.3);
end
 SE(i)=toc(ST); % start time
 SC(k)=8;

ET=toc(ST); % get total time
fclose(s); % end communication with arduino Uno

% write xlsx data ---------------------------------------------------------

a = num2str(x); % Subject number
A=['Experiment 3 - Subject # ',a];
AC=cellstr(A); % subject string
b = num2str(date);
B=['Date ',b];
BC=cellstr(B); % date string

% Total time
tt=num2str(ET);
D=['Total Trial Time ',tt];
DC=cellstr(D); % Total Time string

e=['  Event time codes: 5/6 - 7/8 is start/end '];
CT=cellstr(e);
g=['  Time of poke (IF poked) in A = 20 '];
SOn=cellstr(g);
f=['  Time out (no poke) in box A = 30 '];
CT1=cellstr(f);
h=['  Start time 10 sec blinking LED = 10 (end Blink = 15) '];
LOn=cellstr(h);

% Number of Trials
zz=num2str(z);
ZZ=['Number of trials: ',zz];
ZT=cellstr(ZZ);

% Sequence times
FS=(SE)';

% Event Code Numbers
GS=(SC)';

% Computer time as start time
CoT=datestr(cts); % start time string
COT=['Computer time start: ',CoT];
CTS=cellstr(COT);

FileName=['Exp3_',datestr(now, 'dd-mmm-yyyy'), '_',a];
 % myDir  = 'C:\Users\jbw\Documents\MATLAB';
 myFile = [date '.xlsx'];
 pathAndFilename = fullfile(myFile);xlswrite(FileName,AC, 'Sheet1','A1'); % exp# & subject #
 pathAndFilename = fullfile(myFile);xlswrite(FileName,BC, 'Sheet1','A2'); % date
 pathAndFilename = fullfile(myFile);xlswrite(FileName,ZT, 'Sheet1','A3'); % number of trials
 pathAndFilename = fullfile(myFile);xlswrite(FileName,DC, 'Sheet1','A4'); % total trial time
 pathAndFilename = fullfile(myFile);xlswrite(FileName,CT, 'Sheet1','A5'); % Codes text
 pathAndFilename = fullfile(myFile);xlswrite(FileName,LOn, 'Sheet1','A6'); % Codes text
 pathAndFilename = fullfile(myFile);xlswrite(FileName,SOn, 'Sheet1','A7'); % Codes text
 pathAndFilename = fullfile(myFile);xlswrite(FileName,CT1, 'Sheet1','A8'); % Codes text
 pathAndFilename = fullfile(myFile);xlswrite(FileName,CTS, 'Sheet1','A9'); % Computer start time
 pathAndFilename = fullfile(myFile);xlswrite(FileName,FS, 'Sheet1','A11'); % Times
 pathAndFilename = fullfile(myFile);xlswrite(FileName,GS, 'Sheet1','B11'); % Codes

% Indicate end of script:
clc
fprintf ('The total time to run was %0.1f seconds\n',ET)

% Misc Notes:
% UPLOAD "Button_OR_Mat_stim" code to Arduino Uno
% RTC shield on Uno (use battery to power) upload code=Log+RTC_IR_Break_to_SD
%  if delete SD card file then must re-upload code before using

% Uno - pin 9 to stim red and other to GND (black)
% Mega - D3 is start & end beep & lite + GND

% Mega pins for box 1 LED (D7) [RED]
% Mega pin to power and read IR switch broken in Box A (D4) [PURPLE]

% IR detectors to Mega board
% Connect transmitter (2 wires) to Ground & +5V
% Connect receiver to GND & +5V then data from digital pin 4
% RED is + 5 V  &  BLACK is GND
% RTC split digital pin 4 from IR data to shield digital pin #4