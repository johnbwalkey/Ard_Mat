% 6 Click Game Homework #4 - John Walkey

clear all; clc
start_time = clock(); % get the original time

figure; hold on
title('Click on Target - You have 15 seconds to click them!');

axis([0 1 0 1])
x = rand(1,6);
y = rand(1,6);
err_marg = 0.02;
i = 1;
dist_total = 0; dist_sub=0;
ms = 12; % initial MarkerSize

t1=now; % initial time
elapsed_sec=0;
elapsed_days=0;

while i <= 6
    plot(x(i),y(i),'o', 'markersize',(ms));
    ms = (ms - 1);
    [x2 y2] = ginput(1);
    plot( x2, y2, '+')
    dist = sqrt((x(i)-x2)^2 + (y(i)-y2)^2);% calculate distance to target
    dist_total= dist_sub + dist;

%   hit = dist <= err_marg;  
    if dist<= err_marg;  
        hit = 1;
        i = i+1;
    else
        hit = 0;
       %hit ==1  inside ; hit = 0;

    end
    
    if elapsed_sec >= 15;
        t2=now;
        elapsed_days = t2-t1;
        elapsed_sec = elapsed_days *24*60*60;
      fprintf 'You have execeeded the time limit \n'
      break;
    end

end


elapsed_time = etime(clock(), start_time); 
fprintf('It took %d seconds\n', elapsed_time); 
fprintf('Total error distance %d units \n', dist_total); 

% Add this games score to high score file
filename = 'high_scores.mat';
save ('filename', 'elapsed_time');

load ('filename', 'elapsed_time');

save ('filename', 'elapsed_time', '-append');
fprintf ('Best score is %d \n', elapsed_time);
