% https://hasisyed.medium.com/arduino-serial-communication-with-matlab-6268957233d2

clear; clc;

%MATLAB Code for Serial Communication with Arduino
fclose(instrfind);
delete(instrfind);
x=serial('COM1,'BaudRate', 9600);
fopen(x)
go = true;
while go
                 
a = input('Enter 1 to turn ON LED & 0 to turn OFF or 2 to exit, press: ');
fwrite(x, a, 'char'); 
if (a == 2)
  go=false;
end
end
fclose(x)
fclose(x)
