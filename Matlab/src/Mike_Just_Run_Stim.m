% just run stimulator - to oscilloscope
% UPLOAD code to Mega and stim to pin 9 (and connect a ground on Mega)

session.ard = serial('com8','baudrate',115200);
fopen(session.ard);
if ~strcmp(session.ard.status,'open')
    fprintf(1, 'Could not open arduino serial port.\n');
end

% Send 3 Pulses with 1 second delay
for j=1:3

% session.stimpar = 'sf0.8;a46;'; 
session.stimpar = 'bw200;a255;g20;z3000;';
% bw is biphasic width (b is biphasic; width in micro seconds)
% a is amps in bits
% g is gap -- gap between plus minus pluses
    %change g20 to 0,10 and look at scope
% z is pulse interval in milliseconds

pause(1); % wait 1 second between pulses

end

fclose(session.ard); % end communication with arduino stim code

