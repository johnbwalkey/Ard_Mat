[wave,fs]=audioread('C:\Users\jbw\Documents\MATLAB\brown-bat.wav'); % read file into memory
sound(wave,fs); % see what it sounds like
t=0:1/fs:(length(wave)-1)/fs; % and get sampling frequency
% plot(t,wave); % graph it – try zooming while its up…not much visible until you do


n=length(wave)-1;
f=0:fs/n:fs;
wavefft=abs(fft(wave));
plot(f,wavefft);