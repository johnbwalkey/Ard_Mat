% walkey_stim_voc_peth3
% generated PETH of vocalizations with respect to stim events

peth_bin = 1;  % in seconds
time_before = 25;  % extend peth this far before (positive number, in seconds)
time_after = 25;  % extend peth this far after (seconds)

stim_file = 'C:\Users\john\OneDrive\Documents\MATLAB\DE_Analysis_JW_PETH\EXP3_Stim_Times.xlsx';
voc_file ='C:\Users\john\OneDrive\Documents\MATLAB\DE_Analysis_JW_PETH\EXP3_USV.xlsx';
include_data = [1 1;  % data to include in analysis, has format [rat day]
                1 2;
                1 3;
                1 4;
                2 1;
                2 2;
                2 3;
                2 4;
                3 1;
                3 2;
                3 3;
                3 4];

% read stim times
tab_labels_stim = sheetnames(stim_file);  % returns string array with the labels for each sheet (tab)
for shi = 1:numel(tab_labels_stim);
    Dstim{shi}=readtable(stim_file, 'Sheet', tab_labels_stim(shi));
    Cout = textscan(tab_labels_stim(shi),'R%d_D%d_C%d');  % extract rat, day and cohort from tab label
    Dstim_rat(shi) = Cout{1}; % this is rat number
    Dstim_day(shi) = Cout{2}; % this is day
end

% read vocalization times
tab_labels_voc = sheetnames(voc_file);  % returns string array with the labels for each sheet (tab)
for shi = 1:numel(tab_labels_voc);
    Dvoc{shi}=readtable(voc_file, 'Sheet', tab_labels_voc(shi));
    Cout = textscan(tab_labels_voc(shi),'R%d_D%d_C%d');  % extract rat, day and cohort from tab label
    Dvoc_rat(shi) = Cout{1}; % this is rat number
    Dvoc_day(shi) = Cout{2}; % this is day
end

disp('done reading files')

rat_n = 0;  % counter to keep track of rat processing order, in case rat numbers are not sequential
% ndays = length(valid_days);
nrats = length(unique(include_data(:,1)));
for rati = unique(include_data(:,1))' % extracts list of all rats to analyze
    rat_n = rat_n+1;  
    valid_days = include_data(include_data(:,1)==rati,2); % list of valid days for that animal
    for dayi = 1:length(valid_days)
        cur_day = valid_days(dayi);
        disp(['processing rat ' num2str(rati) ' day ' num2str(cur_day)])

        stim_si = Dstim_rat==rati & Dstim_day==cur_day;
        voc_si = Dvoc_rat==rati & Dvoc_day==cur_day;

        raw_stim_t = Dstim{stim_si}.Stim_Times; % raw means before adjusting for offset
        stim_offset =  Dstim{stim_si}.Offset_Last_Beep(1);  % this is the offset recorded in the file
        stim_t = raw_stim_t - stim_offset;  % adjust stim times for offset
        if isempty(raw_stim_t)
            disp(['error:  no stim for rat ' num2str(rati) ' day ' num2str(cur_day)'])
        end

        raw_voc_t = [Dvoc{voc_si}.Start_Time Dvoc{voc_si}.Stop_Time]; % raw means before adjusting for offset
        voc_offset = Dvoc{voc_si}.Offset_Last_Beep(1); % this is the offset recorded in the file
        voc_mid_t = mean(raw_voc_t,2) - voc_offset;  % take midpoint of each vocalization as time and adjust by offset

        [M, edges] = peth_fast(voc_mid_t, stim_t, peth_bin, time_before, time_after);
        bin_centers = edges(1:end-1) + diff(edges)/2;
        
        voc_minute = (60/peth_bin)*M/numel(stim_t); % convert raw histogram counts to vocalizations per minute
                                                    % numel(stim_t) is number of stims

       % subplot(ndays, nrats, (dayi-1)*(ndays-1) + rat_n)
        bar(bin_centers, voc_minute);
        xlabel('time rel to stim onset (sec)');
        ylabel('call rate (voc/min)')
        title(['R' num2str(rati) ' D' num2str(cur_day)])
        
    end
end



% PLOT
figure
peth_bin = 5;  % in seconds
time_before = 20;  % extend peth this far before (positive number, in seconds)
time_after = 0;  % extend peth this far after (seconds)

rat_n = 0;  % counter to keep track of rat processing order, in case rat numbers are not sequential
ndays = length(valid_days);
nrats = length(unique(include_data(:,1)));
voc_rate_all = zeros(ndays, nrats,(time_before-time_after)/peth_bin);  % third dimension is for data from each bin in histogram
for rati = unique(include_data(:,1))' % extracts list of all rats to analyze
    rat_n = rat_n+1;  
    valid_days = include_data(include_data(:,1)==rati,2); % list of valid days for that animal
    for dayi = 1:length(valid_days)
        cur_day = valid_days(dayi);
        disp(['processing rat ' num2str(rati) ' day ' num2str(cur_day)])

        stim_si = Dstim_rat==rati & Dstim_day==cur_day;
        voc_si = Dvoc_rat==rati & Dvoc_day==cur_day;

        raw_stim_t = Dstim{stim_si}.Stim_Times; % raw means before adjusting for offset
        stim_offset =  Dstim{stim_si}.Offset_Last_Beep(1);  % this is the offset recorded in the file
        stim_t = raw_stim_t - stim_offset;  % adjust stim times for offset
        if isempty(raw_stim_t)
            disp(['error:  no stim for rat ' num2str(rati) ' day ' num2str(cur_day)'])
        end

        raw_voc_t = [Dvoc{voc_si}.Start_Time Dvoc{voc_si}.Stop_Time]; % raw means before adjusting for offset
        voc_offset = Dvoc{voc_si}.Offset_Last_Beep(1); % this is the offset recorded in the file
        voc_mid_t = mean(raw_voc_t,2) - voc_offset;  % take midpoint of each vocalization as time and adjust by offset

        [M, edges] = peth_fast(voc_mid_t, stim_t, peth_bin, time_before, time_after);
        bin_centers = edges(1:end-1) + diff(edges)/2;
        
        voc_rate_all(dayi, rat_n,:) = (60/peth_bin)*M/numel(stim_t); % convert raw histogram counts to vocalizations per minute
                                                    % numel(stim_t) is number of stims

        subplot(ndays, nrats, (dayi-1)*(ndays-1) + rat_n)
        bar(bin_centers, squeeze(voc_rate_all(dayi, rat_n,:)));
        xlabel('time rel to stim onset (sec)');
        ylabel('call rate (voc/min)')
        title(['R' num2str(rati) ' D' num2str(cur_day)])
        
    end
end

% now average data from last two days for all rats
figure
voc_rate_rat_avg(1,:) = squeeze(mean(voc_rate_all(2:3,1,:),1))';
voc_rate_rat_avg(2,:) = squeeze(mean(voc_rate_all(2:3,2,:),1))';
voc_rate_rat_avg(3,:) = squeeze(mean(voc_rate_all(2:3,3,:),1))';
errorbar(bin_centers, mean(voc_rate_rat_avg), std(voc_rate_rat_avg)/sqrt(nrats));
ah = gca; % get axis handle
ah.XLim = [-20 0];
ah.XTick = [-20:5:0];
xlabel('time rel to stim onset (sec)');
ylabel('mean call/min')
title('Exp 1 grand avg with SEM')