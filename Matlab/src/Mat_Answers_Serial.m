% https://arduino.stackexchange.com/questions/34752/sending-values-from-matlab-to-arduino-using-serial-communication
doi = 1;
arduino=serial('COM3','BaudRate',9600); % create serial communication object 
fopen(arduino); % initiate arduino communication
pause(2);
fprintf(arduino, '%i', doi); % send answer variable content to arduino
fclose(arduino);