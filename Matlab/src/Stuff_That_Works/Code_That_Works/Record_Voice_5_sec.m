%%  Record Voice from Microphone, play & save file
clear all; % Removes all variables, functions, etc.
close all; % deletes all figures whose handles are not hidden.

% Set values for sound
Fs = 8000;      %  Sampling rate -Eg 8000-11025-22050-44100
T = 5;          %  Recording time in seconds
nbits = 16;     %  Bits per sample EG-8-16-24-32
% channels (1=mono; 2=stereo)


%  Check that input  device exists
if ( audiodevinfo(1,0,Fs,nbits,1) == 1) % is True
    fprintf('Audio input device found\n');
else
    fprintf('No audio input device found\n') %  is False
return
end

%  Check that output audiodevice exists
if ( audiodevinfo(0,2,Fs,nbits,1) == 1) % T
    fprintf('Audio output device found\n');
else
    fprintf('No audio output device found\n') % F
    return
end


%FS- sample frequency; nbits- bit sample; channels- mono/stereo; device_ID
recorder = audiorecorder(Fs,nbits,1,0); 


fprintf('Prepare to record your voice.\n');
fprintf('The recording will run for %d seconds\n', T)
fprintf('click in the Command window, then \n'); 
fprintf('Hit spacebar when ready and begin to speak\n');
pause

%  Record for T seconds
recordblocking(recorder,T);
fprintf('Finished recording\n');  
myvoice = getaudiodata(recorder); 
player = audioplayer(myvoice,Fs,nbits,2);
playblocking(player);

%  Plot my voice as a function of time
plot(myvoice);
title('My Voice')
xlabel('Time')
ylabel('myvoice(t)')

hold all % holds the plot and properties of it
figure; % Create figure

%  Fourier transform my voice
L = size(myvoice,1);
NFFT = 2^nextpow2(L);
fftmyvoice = fft(myvoice,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1); 

% Plot
plot(f,2*abs(fftmyvoice(1:NFFT/2+1)));
title('Fourier Transform of My Voice')
xlabel('Frequency (Hz)')
ylabel('|myvoice(f)|')  

% save audio file
filename = 'example_audio5.wav';
audiowrite(filename, myvoice, Fs)