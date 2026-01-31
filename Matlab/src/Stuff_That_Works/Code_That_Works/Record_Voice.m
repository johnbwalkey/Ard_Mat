% set recorder
voice = audiorecorder(22050, 16, 1);
get(voice)

%Collect a sample of your speech with a microphone, and plot the signal data:
% Record your voice for 5 seconds.
voice = audiorecorder;
disp('Start speaking.')
recordblocking(voice, 5);
disp('End of Recording.');

% Play back the recording.
play(voice);

% Store data in double-precision array.
myRecording = getaudiodata(voice);

% Plot the waveform.
plot(myRecording);

