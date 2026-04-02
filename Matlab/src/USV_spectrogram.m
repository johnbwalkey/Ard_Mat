clc
clear
%graph ultrasound spectrogram

% read sound file in same directory into memory
[wave,Fs]=audioread('brown-bat.wav');

% hear the sound ...
sound(wave, Fs);

clc
N=input ('Press any key to continue','s');
pause (5);

%get sampling frequency
t=0:1/Fs:(length(wave)-1)/Fs;

% zoom in on plot or don't see much
plot(t,wave);

clc
N=input ('Press any key to continue','s');
pause (5);
spectrogram(wave);



n=length(wave)-1;
f=0:Fs/n:Fs;

%perform Fourier Transform
wavefft=abs(fft(wave));

clc
N=input ('Press any key to continue','s');
pause (5);

%Transform
plot(f,wavefft);

pause(5)
clc