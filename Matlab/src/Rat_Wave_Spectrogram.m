% Make Spectrogram of sample rat ultrasound file from Candace
% open wave file
clear
clc

[wave,fs]=audioread('C:\Users\jbw\Documents\MATLAB\rat.wav'); % read file into memory

spectrogram(wave,fs) % this gives no error but not neat plot

