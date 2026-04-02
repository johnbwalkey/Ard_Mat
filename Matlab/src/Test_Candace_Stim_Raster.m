% test simple raster with sample Candace data and my exp 1 stim data

clc; clear;

load Experiment1.mat
load Score_Candace_Rat.mat

plot(Experiment1,1, 'g*')
hold on
plot (BeginTimes,1, 'ro', 'markersize',9)


spike = [];  % make sure spike array is empty
count_before = 1;
count_after = 2;
for ii = 1:length(Experiment1)  % cycle through each stimulus time
    
   % specify start and end of trial using parameters above
    start_count = Experiment1(ii,1)-count_before;  
    end_count = Experiment1(ii,1)+count_after;

    %create an index which will select the spikes for this trial
   include_i = BeginTimes>=start_count & BeginTimes<=end_count;
    
   % now get the spikes, subtract off stim time and store in struct array
  spike(ii).times = BeginTimes(include_i) - Experiment1(ii,1);  
    
end;

% lets check what we got
% spike(1).times(1:34)
% save Exp1_Candace_Test