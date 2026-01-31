% [wave,fs]=audioread('R2D4C2.wav'); % read file into memory
% sound(wave,fs); % see what it sounds like
% t=0:1/fs:(length(wave)-1)/fs; % and get sampling frequency
% plot(t,wave); % graph it – try zooming while its up…not much visible until you do
% 
% n=length(wave)-1; 
% f=0:fs/n:fs;
% wavefft=abs(fft(wave));  % perform Fourier Transform
% plot(f,wavefft);  % plot Fourier Transform


% Example 1 -- https://www.mathworks.com/help/audio/ug/plot-large-audio-files.html
% filename = "R2D4C2.wav";
% [y,fs] = audioread(filename);
% 
% t = seconds(0:1/fs:(size(y,1)-1)/fs);
% 
% plot(t,y)
% title(filename)
% xlabel("Time")
% ylabel("Amplitude")
% legend("Channel 1", "Channel 2")
% xlim("tight")
% ylim([-1 1])


% % Example 2 % requires audio toolbox
% 
% % filename = "R2D4C2.wav";
% % auInfo = audioinfo(filename)
% % [envMin,envMax,loc] = audioEnvelope(filename,NumPoints=2000);
% % nChans = size(envMin,2);
% % envbars = [shiftdim(envMin,-1);
% %     shiftdim(envMax,-1);
% %     shiftdim(NaN(size(envMin)),-1)];
% % ybars = reshape(envbars,[],nChans);
% % t = seconds(loc/auInfo.SampleRate);
% % tbars = reshape(repmat(t,3,1),[],1);
% % plot(tbars,ybars);
% % title(filename,Interpreter="none")
% % xlabel("Time")
% % ylabel("Amplitude")
% % xlim("tight")
% % ylim([-1 1])
% 
% 
% % from chat GPT (graph bat ultrasound matlab audioread -mathworks)
% % Load the ultrasound audio file
% % [file, path] = uigetfile('*.wav', 'Select the ultrasound audio file');
% % filename = fullfile(path, file);
% filename = ('C:\Users\john\OneDrive\Documents\MATLAB\Rat_USV_Sound_analysis\R2D4C2.wav')
% % Read the audio data
% [data, fs] = audioread(filename);
% 
% % Time vector for plotting
% t = (0:length(data)-1) / fs;
% 
% % Plot the waveform
% figure;
% plot(t, data);
% xlabel('Time (s)');
% ylabel('Amplitude');
% title('Ultrasound Signal Waveform');
% 
% % Spectrogram (for frequency analysis)
% figure;
% spectrogram(data, 256, 250, 256, fs, 'yaxis');
% title('Ultrasound Signal Spectrogram');

% More ChatGTP (matlab graph rat ultrasound for 10 minute file showing
% spectrogram to identify call subtypes)

% Load the ultrasound file
% [file, path] = uigetfile('*.wav', 'Select the ultrasound audio file');
% filePath = fullfile(path, file);
% filename = "R2D4C2.wav";
% [audio, fs] = audioread (filename); %(filePath);
% 
% % Check the audio sampling rate
% disp(['Sampling rate: ', num2str(fs), ' Hz']);
% 
% % Parameters for spectrogram
% windowSize = 256;      % Size of the window
% noverlap = 200;        % Overlap between segments
% nfft = 512;            % FFT size
% 
% % Compute the spectrogram
% [S, F, T, P] = spectrogram(audio, windowSize, noverlap, nfft, fs);
% 
% % Convert power to dB
% PdB = 10*log10(P);
% 
% % Display the spectrogram
% figure;
% imagesc(T, F, PdB);
% axis xy;   % Flip the y-axis for proper orientation
% colormap jet;
% colorbar;
% xlabel('Time (s)');
% ylabel('Frequency (Hz)');
% title('Spectrogram of Rat Ultrasound Calls');
% 
% % Zoom into the frequency band of interest (e.g., 20-100 kHz)
% ylim([20000 100000]);
% saveas(gcf, 'rat_ultrasound_spectrogram.png');



% Grayscale
% Load the ultrasound file
filename = "R2D4C2.wav";

[audio, fs] = audioread(filename);

% Check the audio sampling rate
disp(['Sampling rate: ', num2str(fs), ' Hz']);

% Parameters for spectrogram
windowSize = 256;      % Size of the window
noverlap = 200;        % Overlap between segments
nfft = 512;            % FFT size

% Compute the spectrogram
[S, F, T, P] = spectrogram(audio, windowSize, noverlap, nfft, fs);

% Convert power to dB
PdB = 10*log10(P);

% Display the spectrogram
figure;
imagesc(T, F, PdB);
axis xy;   % Flip the y-axis for proper orientation
colormap gray;   % Use grayscale colormap
colorbar;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Spectrogram of Rat Ultrasound Calls (Grayscale)');

% Zoom into the frequency band of interest (e.g., 20-100 kHz)
ylim([20000 100000]);