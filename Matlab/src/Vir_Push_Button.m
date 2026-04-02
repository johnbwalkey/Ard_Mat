% simulate pushed button 
clear
clc
tic
% a=arduino('com3'); % Mega board
for jj=1:5;
    
    doi = 'a' ;
arduino=serial('COM3','BaudRate',9600); % create serial communication object 
fopen(arduino); % initiate arduino communication
fprintf(arduino, '%s',(doi)); % send answer variable content to arduino
fclose(arduino);
pause(2);
end