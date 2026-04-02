%https://www.mathworks.com/support/search.html/answers/178504-how-to-sending-data-from-matlab-to-arduino.html?fq%5B%5D=asset_type_name:answer&fq%5B%5D=category:support/matlab-su6911&page=1

clear;clc;
a= serial('COM3','BAUDRATE',9600);

fopen(a);
pause(2);% this must be here or doesn't send data
data = 1;
 fprintf(a,'%i',data); % send data to arduino
 
fclose(a); % end communication with arduino 


% this works with uploaded arduino code to Uno == Button_OR_Mat_Stim.ino


