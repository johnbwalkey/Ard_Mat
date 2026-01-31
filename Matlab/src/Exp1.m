% EXPERIMENT 1.
% Replicate Burgdorf 2000 - but hypothesis - look at sub-types of vocal
% Uncued stim on a fixed-time schedule
% every 20 sec get 1 second of stim for 10 min every second day for 8 Days
% So 3 per min is 30 stimulations for 10 minutes - in one day trial
% No cues, predictive only. Rat anticipates stimulation (Fixed Time)
% Video record behavior and DV is ultravocalizations
% Beep and Light sets to signal start and end trial (from Mega)

clear
clc
arduinoio.IDERoot = 'C:\Program Files (x86)\Arduino';
warning ('off'); % stop serialport message
% set the number of trials
disp('Based on Burgdorff 2000 - run 1 sec stim every 20 sec (lite paired) for 10 min.');
disp('Thus - trials = 30 -- recommended number !');
  fprintf('\n')
question='How many trials to run : ';
  z= input(question);

% get Subject number and current date
prompt = 'What is the Subject number? ';
x = input(prompt);
date = datestr(now, 'mm/dd/yy');
% D = date;


s=serialport("COM3",9600);
fopen (s);
% s=serial('COM3','BAUDRATE',9600);   % to create the serial port Uno
m=arduino('com5','Mega2560'); % open and run Mega
% s = arduino('COM3', 'Uno');
i=1; % sequence times
k=1; % codes

ST=tic; % to get times (start)
% turn Light & Beep on then off 3 times to signal Start/End Trial

 SE(i)=toc(ST); %start time
 SC(k)=5;
 i=i+1;k=k+1;

j=0;
for j=1:3;
    writeDigitalPin (m,'D3',1);
    pause (0.3); % wait 1/3 second
    writeDigitalPin (m,'D3',0);
    pause(0.3);
end

 SE(i)=toc(ST); %start time
 SC(k)=6;
 i=i+1;k=k+1;

jj=0;
for jj=1:z; % run test 30 times (+4 to hold start/stop beep/lite)

% wait 19 seconds then loop again
pause(19);

SE(i)=toc(ST); % start stim time
SC(k)=1; % 1 is stim start code
i=i+1;k=k+1;

% turn on Stimulator - output on arduino from pin 9 to stimulator + GND
writeDigitalPin (m,'D7',1); % LED on to see when stim on in video
data = 1;
 fprintf(s,'%i',data); % send data to arduino
writeDigitalPin (m,'D7',0); % LED off
end
fclose(s); % end communication with arduino Uno

% Signal end of trial with light and beep on/off pulses
SE(i)=toc(ST); % time of end signal
SC(k)=7; % start end beep/lite time
 i=i+1;k=k+1;

j=0;
for j=1:3;
    writeDigitalPin (m,'D3',1);
    pause (0.3); % wait 1/3 second
    writeDigitalPin (m,'D3',0);
    pause (0.3); %before back on
end
SE(i)=toc(ST); % end end
SC(k)=8; % end end code

ET=toc(ST); % get total time

% write xlsx data

a = num2str(x); 
A=['Experiment 1 -- Subject # ',a];
AC=cellstr(A); % subject string

b = num2str(date);
B=['Date ',b];
BC=cellstr(B); % date string

%number of trials
nt=num2str(z);
ntt=['Number of trials = ',nt];
NT=cellstr(ntt);

% Total time
c = num2str(ET);
D=['Total Trial Time ',c];
DC=cellstr(D); % Total Time string

e=['Event time codes: 5/6/7/8 is start/end times, 1 is stim on times'];
TT=cellstr(e); % Sequence text to string

% sequence times
FS=([SE])';

%Event Code Numbers
GS=([SC])';

FileName=['Exp1_',datestr(now, 'dd-mmm-yyyy'), '_',a];
 % myDir  = 'C:\Users\jbw\Documents\MATLAB';
 myFile = [date '.xlsx'];
 pathAndFilename = fullfile(myFile);xlswrite(FileName,AC, 'Sheet1','A1'); 
 pathAndFilename = fullfile(myFile);xlswrite(FileName,BC, 'Sheet1','A2'); 
 pathAndFilename = fullfile(myFile);xlswrite(FileName,DC, 'Sheet1','A3');
 pathAndFilename = fullfile(myFile);xlswrite(FileName,NT, 'Sheet1','A4');
 pathAndFilename = fullfile(myFile);xlswrite(FileName,TT, 'Sheet1','A5');
 pathAndFilename = fullfile(myFile);xlswrite(FileName,FS, 'Sheet1','A6');
 pathAndFilename = fullfile(myFile);xlswrite(FileName,GS, 'Sheet1','B6');

% Indicate end of script:
clc
fprintf ('The total time to run was %0.1f seconds\n',ET)

% WIRING NOTES:
% Arduino Mega
% LED and BEEP signal device - connect - Pin D3 (red) & GND (black)
% writeDigitalPin (m,'D7',1/0); LED on to see when stim on in video
% Arduino Uno
% Stim Pin - Pin 9 (red) and GND (black)

% UPLOAD "Button_OR_Mat_stim" code to Arduino Uno
% Runs from serial port connection

% NOTES ON STIMULATION:
% want 500 ms stimulation (1/2 second).
% sending 2 - 200 uS pulses with 20 uS gap between 
% PLUS 6.5 mS between pulses for 1 bipolar pulse
% 500 ms / 6.542 ms = 76.42 pulses (line for FreqCount)
% E=IR = 0.5 mA * 1 K ohm R = 0.5 Volts
% did to oscilloscope as test

% DATA:
% Video - to observe behavior
% Audio - to be analyzed