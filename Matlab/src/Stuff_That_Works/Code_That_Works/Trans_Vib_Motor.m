clear
a=arduino('com9');
for loop=1:5
   writeDigitalPin (a,'D3',1);
   pause(2);
   writeDigitalPin (a,'D3',0);
   pause(2);
end
% vibrates about 2 seconds - 4 times