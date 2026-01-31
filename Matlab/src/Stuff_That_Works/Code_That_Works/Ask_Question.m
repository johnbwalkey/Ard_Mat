% ask Question to Variable
clear all
clc
 
answer=1; % this is where we'll store the user's answer
arduino=serial('COM7','BaudRate',9600); % create serial communication object on port COM4
 
fopen(arduino); % initiate arduino communication
 
while answer
    fprintf(arduino,'%s',char(answer)); % send answer variable content to Arduino
    answer=input('Enter led value 1 or 2 (1=ON, 2=OFF, 0=EXIT PROGRAM): '); % ask user to enter value for variable
end
