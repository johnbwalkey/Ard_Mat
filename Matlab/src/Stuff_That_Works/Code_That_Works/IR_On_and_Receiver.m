% Arduino IR Emitter & Detector
clear
a=arduino('com7');
done = 0;

% Turn transmit IR on and leave on
  % seaparate power on
% Power receiver on
%  writeDigitalPin(a,11,1);
% Read reciver    
disp ('Press Ctrl+C to exit');
while (~done);
    IR= readDigitalPin(a,'D3');
   if IR>0
       disp ('on');
   else
        disp('off');
    % pause(.5);
   end
end
% Before end could turn off IR trasmit, and Receiver
  % writeDigitalPin(a,9,0);
  % writeDigitalPin(a,5,0);