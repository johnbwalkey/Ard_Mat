% in click 6 game start by devising a program flow idea
% objective to create game where user clicks on dot appearing
% after 6 hits their time is displayed.

% start timer - figure - Rand table (xrand & yrand)random circle on figure-
% user input - loop to check if hit - maybe a range so can 'be close' -
% display new target 6x - then loop - new user input
% stop timer - display total time
clear all; clc
start_time = clock(); % get the original time
figure; hold on
title('click on target')
axis ([0 1 0 1])
x = rand(1,6);
y = rand(1,6);

% need to calculate distance between 2 points and determine error margin
e=0.1  % +/- error use

for i = 1:1:6 % could comment out loop while debugging
plot (x(i),y(i), 'o')
[x2 y2] = ginput(1);
plot (x2, y2, '+')
%check if close to target
   if x2 <= x(i)+e & y2 >= y(i)-e;
   end
  
end

elapsed_time = etime(clock(), start_time); 
fprintf('it took %d seconds\n', elapsed_time); 
