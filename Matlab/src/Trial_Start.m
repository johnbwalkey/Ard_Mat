clear
clc
% Trial start get info for Trial
x = input('Enter the rat number: ')
date = datestr(now, 'mm/dd/yy');
date

% need time events
starttime=clock();% get the original time 
% DO CODE HERE (call functions, run scripts, etc) 
elapsedtime=etime(clock(), starttime);
fprintf('it took %d seconds\n',elapsedtime);


% Alternatively, you can use the tic and toc commands: 
		
tic
% DO CODE HERE (call functions, run scripts, etc) 
toc % diplays this - Elapsed time is 0.000037 seconds.
