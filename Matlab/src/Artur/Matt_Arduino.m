% Matt - Arduino - 1st - blink with LED and resistor
clear

% make arduino object
a=arduino('com4','uno');
% done=0;
% while (~done);
%     writeDigitalPin(a,13,1)
%     pause(1);
%     writeDigitalPin(a,13,0)
%    pause(1);
% end 


% Analog ambient light sensor from DFRobot - 3 pin
% plug into analog in pin - 
bufferSize=200; % change buffer size
buffer=zeros(1,bufferSize);
counter=1;

done=0;
while (~done);
    buffer=circshift(buffer,[0 -1]);
    buffer(1,end)=readVoltage (a,3);
%display(v);
plot (counter,mean(buffer), 'o');
ylim([0 5]);
hold on;
drawnow;
counter=counter+1;
% above works when change light amount - but can filter
% use moving average
% first create a buffer


end 

