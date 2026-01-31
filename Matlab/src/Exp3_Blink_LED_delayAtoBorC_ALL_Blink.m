% EXPERIMENT 3. BLINK LEDS @1/2 sec on/off 6x that signal AorBorC
% && delay 5 sec after poke A before LED on in BorC

% unpredictable nose-poke light comes on in poke box 2 or 3 
    % to signal stim available in Poke box 1
        % rat pokes where lite on then goes to #1 and pokes for stim
% within a 20 second block, random number for 'which' lite on in 2 or 3
% A set of 16 -20 second blocks for 1 test set PLUS
    % 16 possible 20 second blocks for lite/stim ON
% 32 - 20 sec blocks is 6 minutes per trial
% No predictive cues. Rat pairs lite in 2 or 3 with stim in box 1
    % works for stim in instrumental conditioned test
% When; DOES SUBJECT VOCALIZE ? Did lite get paired to work for stim ?
% Mega & Uno plugged into computer with Mega doing code & Uno serial Stim
    % pin wiring at end of this code
% store data in XLSX
% Video record behavior and DV is ultravocalizations - Note WHEN
% Beep and Light to signal start and end trial (from Mega)

clear
clc
warning ('off'); % stop serialport message

% set the number of trials
disp('32 - 20 second blocks is 6 minutes per trial');
disp('may try 64 (instead of 32 recommended number - approximately 20 minutes to run)!');
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
m=arduino('com7','Mega2560'); % open and run Mega
DDD=1; % data to send to Arduino uno

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

% Configure Mega for Nose Poke switch IR
configurePin (m, 'D4', 'DigitalInput'); % box 1
configurePin(m, 'D4', 'pullup');% set pullup resistor
configurePin (m, 'D5', 'DigitalInput'); % box 2
configurePin(m, 'D5', 'pullup');% set pullup resistor
configurePin (m, 'D6', 'DigitalInput'); % box 3
configurePin(m, 'D6', 'pullup');% set pullup resistor

jj=0; % clear loop counter for trials

% A set of "z" - 20 second blocks for 1 trial set
for jj=1:z
 % Random poke box 2 or 3
    r=0;
    r=randi([1,2],1); % output is s 1 or 2
    R=r+1; % makes value 2 or 3 to represent the poke box number
        % start timing, WHICH BOX, lite on, check poked, 
        % if poked lite/stim on in #1
abc=0; % loop for blink LEDs

% Trial block 2 ...........................................
if R == 2 % R is 2
    Ex=0;
        for abc=1:3
	        writeDigitalPin (m,'D8',1); % lite on-off in box 2
            pause(0.1);
            writeDigitalPin (m,'D8',0); % lite on-off in box 2
            pause(0.1);
        
       SE(i)=toc(ST); % light on in box B time
       SC(k)=10;
       i=i+1;k=k+1;
tic
 while toc<=20
    % writeDigitalPin (m,'D8',1); % lite on in box 2
   Voltage=readDigitalPin(m, 'D5');
    if (Voltage <= 0.5)% poke box #2 is poked
        Ex=1;
        writeDigitalPin (m,'D8',0); % lite off in box 2
       SE(i)=toc(ST); % poke in box B
       SC(k)=20;
       i=i+1;k=k+1;
     break
    end % end inner if
    end % end blink if
    % DE idea -- here you could add a check to see whether there was a poke in box 1
    % or 3.  If so, grab the time 
   end % end while
        
if Ex ==0
   SE(i)=toc(ST); % time out in box B
   SC(k)=25;
   i=i+1;k=k+1;
   writeDigitalPin (m,'D8',0); % lite off in box 2
end
   writeDigitalPin (m,'D8',0); % lite off in box 2

  % Poke box #1 - test
   tic
   if Ex==1
       Ex=0;
        SE(i)=toc(ST); % light on in box C
        SC(k)=50;
        i=i+1;k=k+1;
         for abc=1:3
            writeDigitalPin (m,'D7',1); % lite on-off in box 1
            pause(0.1);
            writeDigitalPin (m,'D7',0); % lite on-off in box 1
            pause(0.1);
        
  	 while (toc<=20)
        writeDigitalPin (m,'D7',1); % lite on in box 1
        Voltage=readDigitalPin(m, 'D4');
       
       	 if (Voltage <= 0.5) % if yes to nose poke then stim on
             SE(i)=toc(ST); %start time
             SC(k)=1;
             i=i+1;k=k+1;
           Ex=1;

         % Stim ON in Poke Box 1  
         data = 1;
         fprintf(s,'%i',data); % send data to arduino
           writeDigitalPin (m,'D7',0); % lite off in box 1
          pause(5);
         break
        end % end if
     end % end while
     end % end blink if
    writeDigitalPin (m,'D7',0); % lite off in box 1
if Ex ==0
   SE(i)=toc(ST); % time out in box B
   SC(k)=45;
   i=i+1;k=k+1;
   writeDigitalPin (m,'D8',0); % lite off in box 2
end % end Ex if
 end % end if for stim
end % end main if for B

  
% Trial block 3 ...........................................
if R == 3 % R is 3
    Ex=0;
        for abc=1:3
            writeDigitalPin (m,'D9',1); % lite on-off in box 3
            pause(0.1);
            writeDigitalPin (m,'D9',0); % lite on-off in box 3
            pause(0.1);
     
      SE(i)=toc(ST); % light on in box C
      SC(k)=15;
      i=i+1;k=k+1;

  tic    
   while toc <=20
       writeDigitalPin (m,'D9',1); % lite on in box 3
    Voltage=readDigitalPin(m, 'D6');
       if (Voltage <= 0.5)% poke box #3 is poked
          Ex=1;
         writeDigitalPin (m,'D9',0); % lite off in box 3
       SE(i)=toc(ST); % poke in box C
       SC(k)=30;
       i=i+1;k=k+1;
         break
       end % end inner if
       end % end blink if
   end % end while

    if Ex==0
     SE(i)=toc(ST); % time out in box C
     SC(k)=35;
     i=i+1;k=k+1;
    writeDigitalPin (m,'D9',0); % lite off in box 3
    end % end if
    writeDigitalPin (m,'D9',0); % lite off in box 3

 % Poke box #1 - test
   tic
if Ex==1
    Ex=0;
       SE(i)=toc(ST); % light on in box C time
       SC(k)=50;
       i=i+1;k=k+1;
        for abc=1:3
            writeDigitalPin (m,'D7',1); % lite on-off in box 1
            pause(0.1);
            writeDigitalPin (m,'D7',0); % lite on-off in box 1
            pause(0.1);
       
   while toc<=20
        writeDigitalPin (m,'D7',1); % lite on in box 1
        Voltage=readDigitalPin(m, 'D4');
   
      if (Voltage <= 0.5) % if yes to nose poke then stim on
            SE(i)=toc(ST); %stim start time
            SC(k)=2;
            i=i+1;k=k+1;
           Ex=1;

        % Stim ON in Poke Box 1  
            data = 1;
            fprintf(s,'%i',data); % send data to arduino
         writeDigitalPin (m,'D7',0); % lite off in box 1
        pause(5);
       break
      end % end if
      end % end blink if
   end % end while
      writeDigitalPin (m,'D7',0); % lite off in box 1
 if Ex==0
     SE(i)=toc(ST); % time out in box C
     SC(k)=55;
     i=i+1;k=k+1;
    writeDigitalPin (m,'D9',0); % lite off in box 3

 end % end ex if
 end % while
end % trial block 3 if

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

e=['Event time codes: 5/6/7/8 is start/end, poke in B/C - 20/30,'];
CT=cellstr(e);
g=[' stim on after poke in B/C - 1/2'];
SOn=cellstr(g);
f=[' time out B/C- 25/35, time out in stim box B/C - 45/55'];
CT1=cellstr(f);
h=[' lite on in B/C - 10/15, lite on in A - 50'];
LOn=cellstr(h);

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
 pathAndFilename = fullfile(myFile);xlswrite(FileName,DC, 'Sheet1','A4'); % total trial timee
 pathAndFilename = fullfile(myFile);xlswrite(FileName,CT, 'Sheet1','A5'); % Codes text
 pathAndFilename = fullfile(myFile);xlswrite(FileName,LOn, 'Sheet1','A6'); % Codes text
 pathAndFilename = fullfile(myFile);xlswrite(FileName,SOn, 'Sheet1','A7'); % Codes text
 pathAndFilename = fullfile(myFile);xlswrite(FileName,CT1, 'Sheet1','A8'); % Codes text
 pathAndFilename = fullfile(myFile);xlswrite(FileName,FS, 'Sheet1','A9'); % Times
 pathAndFilename = fullfile(myFile);xlswrite(FileName,GS, 'Sheet1','B9'); % Codes


 % Indicate end of script:
clc
fprintf ('The total time to run was %0.1f seconds\n',ET)

% Misc Notes:
% UPLOAD "Button_OR_Mat_stim" code to Arduino Uno
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
