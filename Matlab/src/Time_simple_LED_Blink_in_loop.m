% Simple Test to time blinking LED

clear
clc
m=arduino('com4','Uno'); % open and run Uno
j=0;
tic
        for j=1:31
            writeDigitalPin (m,'D9',1);
            pause (0.1); % wait 1/10 second
            writeDigitalPin (m,'D9',0);
            pause (0.1);
        end % end flashes
t=toc;
clc
fprintf ('The total time to run was %0.1f seconds\n',t)
