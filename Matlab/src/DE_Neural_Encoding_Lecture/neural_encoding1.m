% NEURAL ENCODING I

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STRUCTURES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear

S.name = 'Ed Plum';
S.scores = [83 82 88];

S(2).name = 'Toni Miller';
S(2).scores = [89 91];

S(3) = struct('name','Jerry Garcia',...
              'scores',70)

S
S(1)
S(3).name

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARTITION SPIKES INTO TRIALS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
load raster_example1  % contains spikes and stim
                      % which are times of each spike and 
                      % time of each stimulus event

spike = [];  % make sure spike array is empty
count_before = 100; % ms
count_after = 200;  % ms
for ii = 1:length(stim_array)  % cycle through each stimulus time
    
    % specify start and end of trial using parameters above
    start_count = stim_array(ii,1)-count_before;  
    end_count = stim_array(ii,1)+count_after;

    % create an index which will select the spikes for this trial
    include_i = spike_times>=start_count & spike_times<=end_count;
    
    % now get the spikes, subtract off stim time and store in struct array
    spike(ii).times = spike_times(include_i) - stim_array(ii,1);  
    
end;

% lets check what we got
spike(1).times(1:20)
save make_exp1_partitioned_spikes_example1 spike

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT RASTERS FOR A COUPLE OF TRIALS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
load make_exp1_partitioned_spikes_example1
t1=spike(1).times;
t2=spike(2).times;

figure 
hold on %Allow multiple plots on the same graph
for i=1:length(t1) %Loop through each spike time
    line([t1(i) t1(i)], [0 1]) %Create a tick mark at t1(i) with a height of 1
end
for i=1:length(t2)
    line([t2(i) t2(i)], [1 2])
end
hold off;
axis([-100 200 0 5 ]) %Reformat axis limits for legibility
xlabel('Time (msec)'); ylabel('Trial #')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HISTCOUNTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

doc histcounts
x = -2.5:0.5:2.
y = randn(10000,1);

figure
[counts] = histcounts(y,x)
bar(x(1:end-1) + .25, counts, 'BarWidth',1);  % we add .25 so we are plotting
                                     % each bin count at the center of the bin

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT RASTERS FOR ALL TRIALS USING HISTCOUNTS METHOD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
load partitioned_spikes_example1
edges=[-100:1:200]; %Define bin edges
raster=zeros(40, length(edges)-1); %Initialize raster matrix
for j=1:40 %Loop over all trials
            %Count how times fall in each bin
    raster(j,:)=histcounts(spike(j).times,edges);
end
figure %Create figure for plotting
imagesc(raster);  % display matrix as an image with auto scaling
colormap(1-gray) %invert color map so that darker values are higher

% excercise:  try different bin sizes: 2, 5, 20

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MEAN AND STD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = rand(1,6)
mean(x)
std(x)

x = [1 2 3; 4 5 6]
mean(x)
std(x)

% now take row means
% use the transpose operator ' to flip rows and columns
mean(x')
std(x')

x = magic(4)
mean(x)
mean(x')
std(x)
std(x')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PETH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
load partitioned_spikes_example1
edges=[-100:5:200]; %Define bin edges
raster=zeros(40, length(edges)-1); %Initialize raster matrix
for j=1:40 %Loop over all trials
            %Count how times fall in each bin
    raster(j,:)=histcounts(spike(j).times,edges);
end
peth = mean(raster);

figure 
bar(edges(1:end-1), peth);
xlabel('time');
ylabel('mean spikes/bin')

% excercise:  try different bin sizes: 2, 5, 20

% estimate baseline mean and std of firing
% first we create a raster for only those spikes which occurred before the
% stimulus
baseline_i = edges<0;  % count spikes occurring before the stimulus
baseline_raster = raster(:, baseline_i);
figure;
imagesc(edges(baseline_i), 1:size(baseline_raster,1), baseline_raster);  % display matrix as an image with auto scaling
colormap(1-gray) %invert color map so that darker values are higher

% we treat every bin during this time as an independent measurement of 
% spontaneous activity - hence we can use all bins to get mean and std
baseline_rate = mean(baseline_raster(:));  % note that (:) unwraps matrix
baseline_std = std(baseline_raster(:));
z_score_peth = (peth - baseline_rate)/baseline_std;

figure;
bar(edges(1:end-1), z_score_peth);
xlabel('time');
ylabel('z-score firing rate')




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FREQUENCY TUNING CURVE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
load raster_example2_freq.mat
spike_times(1:10)'  % these are the spike times
stim_array(1:10,:)  % this gives [start_time end_time freq] 
                     % for each tone presented

start_count = 0; % start counting this many ms after stim onset
end_count = 100; % end counting at this time, in ms
freq_vals = unique(stim_array(:,3));  % extract frequencies used for test
                                      % unique eliminates redundant entries 
                                      % and sorts in ascending order - handy
spike_rate = zeros(1,length(freq_vals)); % mean spikes per second,
                                         % averaged across repetitions
spike_std = zeros(1,length(freq_vals));  % std of spikes across
                                         % repetitions of the stimulus
                                     
for fi = 1:length(freq_vals)
    cur_freq_i = find(stim_array(:,3)==freq_vals(fi)); % find all trials 
                                                        % which used the 
                                                        % current frequency
    nreps = length(cur_freq_i);  % find number of stimulus presentations
    tr_spikes = zeros(nreps,1);  % spikes for each rep @ specific freq
    % count spikes for each rep at current frequency
    for tri = 1:nreps
        cur_trial = cur_freq_i(tri);  % trial number (index into stim_array)
        stim_time = stim_array(cur_trial,1); % stimulus onset time
                                             % for this trial
        shifted_spikes = spike_times - stim_time; % express all spike times relative to stim time
        tr_spikes(tri) = sum(shifted_spikes>start_count & shifted_spikes<end_count); 
    end;
    spike_rate(fi) = mean(tr_spikes/(end_count - start_count));  
    spike_std(fi) = std(tr_spikes/(end_count - start_count));
end;

% basic frequency tuning
figure;
plot(freq_vals, spike_rate);

% deluxe frequency tuning - with errorbars
% convert to spikes/second, the more common measure of spike rate
figure;
errorbar(freq_vals, spike_rate*1000, spike_std*1000);
xlabel('frequency');
ylabel('spikes/sec')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ERRORBAR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = 0:10;
y = (x-5).^2;
err = std(y)*rand(size(x));
figure;
errorbar(x,y,err) 

% exercise: create errorbar plot for mean and std of 4x4 magic square
x = magic(4);
mean_x = mean(x);
std_x = std(x);
figure;
errorbar(1:4, mean_x, std_x)


