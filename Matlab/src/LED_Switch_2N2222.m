% 2N222 to LED switch

clc
clear

tic

m=arduino('com3','Mega2560'); 

for i = 1:10
      writeDigitalPin(m, 'D3', 0);
      pause(1);
      writeDigitalPin(m, 'D3', 1);
      pause(1);
end

toc