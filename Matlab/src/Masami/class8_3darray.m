% Summer Computational Neuroscience Workshop 2019
% MATLAB Tutorial #3
% June 10, 2019
% Class 8
% Masami Tatsuno
%
% manipulating 3D array 
%

%% Create 3x3 UINT8 matrix
% display matrix
test_disp = uint8(zeros(3,3,3));
figure;
subplot(2,2,1);
image(test_disp);

%% Change diagonal elements into white.
for ii=1:3
    test_disp(ii,ii,:)=255;
end
subplot(2,2,2);
image(test_disp);

%% Change the lower-left element into red.
test_disp(3,1,1)=255; 
subplot(2,2,3);
image(test_disp);

%% Exercise 1
% Change the center element into Green and the upper-right elment into Blue
test_disp(2,2,:)=0;
test_disp(2,2,2)=255; 
test_disp(1,3,3)=255;
subplot(2,2,4);
image(test_disp);

%% Reading images
temp = imread('banff_960_640.jpg');
whos

%% plot the image
figure; image(temp); axis image;

%% subplot the image
figure;
subplot(2,2,1);
image(temp);axis image;

%% Red channel
tempR=temp;
tempR(:,:,2:3)=0;
subplot(2,2,2);
image(tempR); axis image;

%% Green channel
tempG=temp;
tempG(:,:,1)=0;
tempG(:,:,3)=0;
subplot(2,2,3);
image(tempG); axis image;

%% Exercise 2
% Blue channel
tempB=temp;
tempB(:,:,1:2)=0;
subplot(2,2,4);
image(tempB); axis image;

%% Add red and green channels
figure;
subplot(2,2,1);
image(temp); axis image;

tempRG=tempR + tempG;
subplot(2,2,2);
image(tempRG); axis image;

%% Exercise 3
% Add green & Blue
tempGB=tempG + tempB;
subplot(2,2,3);
image(tempGB); axis image;

% Add red & blue
tempRB=tempR + tempB;
subplot(2,2,4);
image(tempRB); axis image;



%% Filtering

pic = imread('star_wars_800_600.jpg');
figure;
image(pic); axis image;

%%
figure;
subplot(2,2,1);
image(pic); axis image;
axis off;

%%
filter=ones(3,3);
lp3=convn(pic, filter, 'same');
lp3=lp3./(3^2);
subplot(2,2,2);
image(uint8(lp3));axis image;
axis off;

%%
filter=ones(25,25);
lp25=convn(pic, filter, 'same');
lp25=lp25./(25^2);
subplot(2,2,3);
image(uint8(lp25));axis image;
axis off;

%%
whos lp25
hp=pic-uint8(lp25);
subplot(2,2,4);
hp=hp+127;
image(hp);axis image;
axis off;

%% Reading audio files
[amp, Fs] = audioread('handel.wav');
t = (1:length(amp))'/Fs;
figure; plot(t, amp);
xlabel('Time (secs)');
ylabel('Amplitude');
sound(amp, Fs);
figure; spectrogram(amp, 256,[],[],Fs,'yaxis');
% colormap(jet);



