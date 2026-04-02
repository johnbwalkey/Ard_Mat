% game which displays 6 consecutuve points
% click and next appears
% timer scores speed

clear
close all

err = 0.05; % size of error allowed set to 0.01 & check bootom of code

figure; hold on
xlim ([0 1]);
ylim ([0 1]);

% timer
tic;

% main loop
for ii=1:6;
% display random location 
xloc=rand;
yloc=rand;
plot (xloc, yloc, 'b+', 'MarkerSize', 10); % marker 50/ii makes smaller

% mouse click location
[x,y] = ginput(1);

% display mouse click location
plot (x, y , 'rx');

% calculate error DISTANCE
diffX= abs(x-xloc);
diffY= abs(y-yloc);
diff = sqrt (diffX^2 + diffY^2);

% loop until good hit
while diff >= err
    [x,y] = ginput(1);
    plot (x, y , 'rx');
    diffX= abs(x-xloc);
    diffY= abs(y-yloc);
    diff = sqrt (diffX^2 + diffY^2);
end
% err=err -0.01 to make smaller target hit required
end % end for loop
t=toc; % stop timer
title (t);

% may add image and sound, moving target, 3 strikes out, target size

