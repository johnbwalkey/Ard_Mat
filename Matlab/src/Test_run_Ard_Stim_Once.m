%MATLAB Code for Serial Communication between Arduino and MATLAB
close all
clear all % may need all for serial connection
clc
tic
m=arduino('com4','Mega2560'); % open and run Mega

for jj=1:3
s=serial('COM5','BAUDRATE',9600);   % to create the serial port Uno
 fopen(s);                           % open the serial port
pause (1);
 fclose(s); 
 pause(3);
end

% s = serial('COM3','BAUDRATE',9600); % to create the serial port in MATLAB
% fopen(s);                           % open the serial port
% % fwrite(s,'int8',1);% send 1 through Serial port to Arduino
% % write(s,data,"uint8") % was 1:5 and I changed to 1:1
% % fprintf(s,'%i',1);
% % writePWMVoltage(s,'D11',0);
% fclose(s);                          % after completing your work close the port
% data

% s = serial('COM5');
% set(s,'BaudRate',9600);
% fopen(s);
% fprintf(s,'*IDN?')
% out = fscanf(s);
% fclose(s)
% delete(s)
% clear s

toc