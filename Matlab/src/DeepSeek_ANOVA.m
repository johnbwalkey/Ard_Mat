% Load the dataset
filename = 'combined_rat_delays.csv';
tbl = readtable(filename);

% Add rat ID column - assuming rats are labeled 1-6 across days
rat_ids = repmat((1:6)', 15, 1); % 6 rats, 15 trials each
tbl.rat = rat_ids;

% Only select trials 1-6 for each rat
nTrials = 6;
mask = tbl.trial <= nTrials;
tbl = tbl(mask, :);

% Find unique rat IDs and days
rats = unique(tbl.rat);
nRats = numel(rats);
days = unique(tbl.day);
nDays = numel(days);

% Initialize 3D matrices for data (rats x days x trials)
led_on = nan(nRats, nDays, nTrials);
arrival = nan(nRats, nDays, nTrials);
latency = nan(nRats, nDays, nTrials);

% Fill matrices by rat, day, and trial
for i = 1:nRats
    for d = 1:nDays
        for t = 1:nTrials
            idx = (tbl.rat == rats(i)) & (tbl.day == days(d)) & (tbl.trial == t);
            if sum(idx) > 0
                led_on(i, d, t) = tbl.led_on_time_s(idx);
                arrival(i, d, t) = tbl.arrival_time_s(idx);
                latency(i, d, t) = tbl.delay_s(idx);
            end
        end
    end
end

% MIXED-EFFECTS MODELS (Most Appropriate Analysis)
fprintf('=== MIXED-EFFECTS MODELS (Most Appropriate Analysis) ===\n');

% Count total non-NaN observations first
total_obs = 0;
for i = 1:nRats
    for d = 1:nDays
        for t = 1:nTrials
            if ~isnan(led_on(i, d, t))
                total_obs = total_obs + 1;
            end
        end
    end
end

fprintf('Total non-missing observations: %d\n', total_obs);

% Pre-allocate table with correct size
long_data = table('Size', [total_obs, 6], ...
    'VariableTypes', {'double', 'double', 'double', 'double', 'double', 'double'}, ...
    'VariableNames', {'rat', 'day', 'trial', 'led_on', 'arrival', 'latency'});

% Fill the table
counter = 1;
for i = 1:nRats
    for d = 1:nDays
        for t = 1:nTrials
            if ~isnan(led_on(i, d, t))
                long_data.rat(counter) = i;
                long_data.day(counter) = d;
                long_data.trial(counter) = t;
                long_data.led_on(counter) = led_on(i, d, t);
                long_data.arrival(counter) = arrival(i, d, t);
                long_data.latency(counter) = latency(i, d, t);
                counter = counter + 1;
            end
        end
    end
end

% Convert to categorical variables
long_data.rat = categorical(long_data.rat);
long_data.day = categorical(long_data.day);
long_data.trial = categorical(long_data.trial);

% Create output directory
output_dir = 'analysis_results';
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
    fprintf('Created output directory: %s\n', output_dir);
end

% SAVE DATA TABLES AS XLSX FILES
fprintf('\n=== SAVING DATA TABLES AS XLSX FILES ===\n');

% Save the processed long format data
output_xlsx = fullfile(output_dir, 'processed_data.xlsx');
writetable(long_data, output_xlsx, 'Sheet', 'All_Data');
fprintf('Saved processed data: %s\n', output_xlsx);

% Save trial-averaged data (rats x trials)
led_on_trials = squeeze(mean(led_on, 2, 'omitnan')); % rats x trials
arrival_trials = squeeze(mean(arrival, 2, 'omitnan'));
latency_trials = squeeze(mean(latency, 2, 'omitnan'));

% Create tables for trial-averaged data
rat_ids_table = table((1:nRats)', 'VariableNames', {'RatID'});
led_on_table = [rat_ids_table, array2table(led_on_trials, 'VariableNames', {'Trial1','Trial2','Trial3','Trial4','Trial5','Trial6'})];
arrival_table = [rat_ids_table, array2table(arrival_trials, 'VariableNames', {'Trial1','Trial2','Trial3','Trial4','Trial5','Trial6'})];
latency_table = [rat_ids_table, array2table(latency_trials, 'VariableNames', {'Trial1','Trial2','Trial3','Trial4','Trial5','Trial6'})];

% Save trial-averaged data
trial_avg_xlsx = fullfile(output_dir, 'trial_averaged_data.xlsx');
writetable(led_on_table, trial_avg_xlsx, 'Sheet', 'LED_On_Time');
writetable(arrival_table, trial_avg_xlsx, 'Sheet', 'Arrival_Time');
writetable(latency_table, trial_avg_xlsx, 'Sheet', 'Latency');
fprintf('Saved trial-averaged data: %s\n', trial_avg_xlsx);

% Save 3D data structure (rats x days x trials)
data_3d_xlsx = fullfile(output_dir, '3d_data_structure.xlsx');

% Save LED data by day
for d = 1:nDays
    sheet_name = sprintf('LED_Day%d', d);
    day_data = array2table(squeeze(led_on(:,d,:)), 'VariableNames', {'Trial1','Trial2','Trial3','Trial4','Trial5','Trial6'});
    day_data = [rat_ids_table, day_data];
    writetable(day_data, data_3d_xlsx, 'Sheet', sheet_name);
end

% Save arrival data by day
for d = 1:nDays
    sheet_name = sprintf('Arrival_Day%d', d);
    day_data = array2table(squeeze(arrival(:,d,:)), 'VariableNames', {'Trial1','Trial2','Trial3','Trial4','Trial5','Trial6'});
    day_data = [rat_ids_table, day_data];
    writetable(day_data, data_3d_xlsx, 'Sheet', sheet_name);
end

% Save latency data by day
for d = 1:nDays
    sheet_name = sprintf('Latency_Day%d', d);
    day_data = array2table(squeeze(latency(:,d,:)), 'VariableNames', {'Trial1','Trial2','Trial3','Trial4','Trial5','Trial6'});
    day_data = [rat_ids_table, day_data];
    writetable(day_data, data_3d_xlsx, 'Sheet', sheet_name);
end
fprintf('Saved 3D data structure: %s\n', data_3d_xlsx);

% Mixed-effects models
fprintf('\nMixed-effects model for LED on time:\n');
fprintf('LED ~ Day + Trial + (1|Rat)\n');
try
    mixed_led = fitlme(long_data, 'led_on ~ day + trial + (1|rat)');
    disp(mixed_led);
    fprintf('ANOVA for LED model:\n');
    anova_led = anova(mixed_led);
    disp(anova_led);
    
    % Save model results
    model_results_xlsx = fullfile(output_dir, 'model_results.xlsx');
    anova_table_led = array2table(anova_led{:,:}, 'VariableNames', anova_led.Properties.VariableNames, 'RowNames', anova_led.Properties.RowNames);
    writetable(anova_table_led, model_results_xlsx, 'Sheet', 'LED_ANOVA', 'WriteRowNames', true);
    
catch ME
    fprintf('Error in LED model: %s\n', ME.message);
end

fprintf('\nMixed-effects model for arrival time:\n');
fprintf('Arrival ~ Day + Trial + (1|Rat)\n');
try
    mixed_arr = fitlme(long_data, 'arrival ~ day + trial + (1|rat)');
    disp(mixed_arr);
    fprintf('ANOVA for arrival model:\n');
    anova_arr = anova(mixed_arr);
    disp(anova_arr);
    
    % Save model results
    anova_table_arr = array2table(anova_arr{:,:}, 'VariableNames', anova_arr.Properties.VariableNames, 'RowNames', anova_arr.Properties.RowNames);
    writetable(anova_table_arr, model_results_xlsx, 'Sheet', 'Arrival_ANOVA', 'WriteRowNames', true);
    
catch ME
    fprintf('Error in arrival model: %s\n', ME.message);
end

fprintf('\nMixed-effects model for latency:\n');
fprintf('Latency ~ Day + Trial + (1|Rat)\n');
try
    mixed_lat = fitlme(long_data, 'latency ~ day + trial + (1|rat)');
    disp(mixed_lat);
    fprintf('ANOVA for latency model:\n');
    anova_lat = anova(mixed_lat);
    disp(anova_lat);
    
    % Save model results
    anova_table_lat = array2table(anova_lat{:,:}, 'VariableNames', anova_lat.Properties.VariableNames, 'RowNames', anova_lat.Properties.RowNames);
    writetable(anova_table_lat, model_results_xlsx, 'Sheet', 'Latency_ANOVA', 'WriteRowNames', true);
    
catch ME
    fprintf('Error in latency model: %s\n', ME.message);
end

fprintf('Saved model results: %s\n', model_results_xlsx);

% SIMPLE DESCRIPTIVE ANALYSIS BY TRIAL
fprintf('\n=== DESCRIPTIVE STATISTICS BY TRIAL ===\n');

% Remove rats with any NaN values for Friedman test
fprintf('\nChecking for complete cases...\n');
complete_cases_led = all(~isnan(led_on_trials), 2);
complete_cases_arr = all(~isnan(arrival_trials), 2);
complete_cases_lat = all(~isnan(latency_trials), 2);

fprintf('Rats with complete LED data: %d/%d\n', sum(complete_cases_led), nRats);
fprintf('Rats with complete arrival data: %d/%d\n', sum(complete_cases_arr), nRats);
fprintf('Rats with complete latency data: %d/%d\n', sum(complete_cases_lat), nRats);

% Calculate means & SEM across rats
mean_led = mean(led_on_trials, 1, 'omitnan');
sem_led = std(led_on_trials, 0, 1, 'omitnan') / sqrt(sum(~isnan(led_on_trials(:,1))));
mean_arr = mean(arrival_trials, 1, 'omitnan');
sem_arr = std(arrival_trials, 0, 1, 'omitnan') / sqrt(sum(~isnan(arrival_trials(:,1))));
mean_lat = mean(latency_trials, 1, 'omitnan');
sem_lat = std(latency_trials, 0, 1, 'omitnan') / sqrt(sum(~isnan(latency_trials(:,1))));

% Create and save descriptive statistics table
desc_stats = table();
desc_stats.Trial = (1:nTrials)';
desc_stats.LED_Mean = mean_led';
desc_stats.LED_SEM = sem_led';
desc_stats.Arrival_Mean = mean_arr';
desc_stats.Arrival_SEM = sem_arr';
desc_stats.Latency_Mean = mean_lat';
desc_stats.Latency_SEM = sem_lat';

desc_stats_xlsx = fullfile(output_dir, 'descriptive_statistics.xlsx');
writetable(desc_stats, desc_stats_xlsx);
fprintf('Saved descriptive statistics: %s\n', desc_stats_xlsx);

% Display trial means
fprintf('\nTrial means for LED On Time (s):\n');
for t = 1:nTrials
    n_valid = sum(~isnan(led_on_trials(:,t)));
    fprintf('Trial %d: %.3f ± %.3f (n=%d)\n', t, mean_led(t), sem_led(t), n_valid);
end

fprintf('\nTrial means for Arrival Time (s):\n');
for t = 1:nTrials
    n_valid = sum(~isnan(arrival_trials(:,t)));
    fprintf('Trial %d: %.3f ± %.3f (n=%d)\n', t, mean_arr(t), sem_arr(t), n_valid);
end

fprintf('\nTrial means for Latency (s):\n');
for t = 1:nTrials
    n_valid = sum(~isnan(latency_trials(:,t)));
    fprintf('Trial %d: %.3f ± %.3f (n=%d)\n', t, mean_lat(t), sem_lat(t), n_valid);
end

% SAVE PLOTS AS PNG IMAGES
fprintf('\n=== SAVING PLOTS AS PNG IMAGES ===\n');

% Plot 1: LED On Time and Arrival Time
figure('Position', [100, 100, 1200, 500], 'Visible', 'off');
subplot(1,2,1);
hold on;
errorbar(1:nTrials, mean_arr, sem_arr, '-o', 'LineWidth', 2, 'Color', [0 0.4470 0.7410], ...
    'MarkerSize', 8, 'DisplayName', 'Arrival Time');
errorbar(1:nTrials, mean_led, sem_led, '--s', 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980], ...
    'MarkerSize', 8, 'DisplayName', 'LED On Time');
xlabel('Trial');
ylabel('Time (s)');
legend('show', 'Location', 'best');
title('LED On Time vs Arrival Time (Mean ± SEM)');
grid on;
xticks(1:nTrials);

% Plot 2: Latency
subplot(1,2,2);
errorbar(1:nTrials, mean_lat, sem_lat, '-o', 'LineWidth', 2, 'Color', 'r', ...
    'MarkerSize', 8, 'MarkerFaceColor', 'r');
xlabel('Trial');
ylabel('Latency (s)');
title('Latency Across Trials (Mean ± SEM)');
grid on;
xticks(1:nTrials);

% Save plot as PNG
output_png1 = fullfile(output_dir, 'combined_plots.png');
saveas(gcf, output_png1, 'png');
fprintf('Saved plot: %s\n', output_png1);
close(gcf);

% Plot 3: Individual rat trajectories (only complete cases)
figure('Position', [100, 100, 1200, 800], 'Visible', 'off');

% LED times
subplot(2,2,1);
hold on;
colors = lines(nRats);
for i = 1:nRats
    if complete_cases_led(i)
        plot(1:nTrials, led_on_trials(i,:), '-o', 'Color', colors(i,:), 'LineWidth', 1.5, 'MarkerSize', 4);
    else
        plot(1:nTrials, led_on_trials(i,:), ':o', 'Color', [colors(i,:) 0.3], 'LineWidth', 1, 'MarkerSize', 3);
    end
end
xlabel('Trial');
ylabel('LED On Time (s)');
title('Individual Rat LED Times (solid=complete)');
grid on;
xticks(1:nTrials);

% Arrival times
subplot(2,2,2);
hold on;
for i = 1:nRats
    if complete_cases_arr(i)
        plot(1:nTrials, arrival_trials(i,:), '-o', 'Color', colors(i,:), 'LineWidth', 1.5, 'MarkerSize', 4);
    else
        plot(1:nTrials, arrival_trials(i,:), ':o', 'Color', [colors(i,:) 0.3], 'LineWidth', 1, 'MarkerSize', 3);
    end
end
xlabel('Trial');
ylabel('Arrival Time (s)');
title('Individual Rat Arrival Times (solid=complete)');
grid on;
xticks(1:nTrials);

% Latencies
subplot(2,2,3);
hold on;
for i = 1:nRats
    if complete_cases_lat(i)
        plot(1:nTrials, latency_trials(i,:), '-o', 'Color', colors(i,:), 'LineWidth', 1.5, 'MarkerSize', 4);
    else
        plot(1:nTrials, latency_trials(i,:), ':o', 'Color', [colors(i,:) 0.3], 'LineWidth', 1, 'MarkerSize', 3);
    end
end
xlabel('Trial');
ylabel('Latency (s)');
title('Individual Rat Latencies (solid=complete)');
grid on;
xticks(1:nTrials);

% Group means
subplot(2,2,4);
hold on;
plot(1:nTrials, mean_led, '-s', 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980], 'DisplayName', 'LED Time');
plot(1:nTrials, mean_arr, '-o', 'LineWidth', 2, 'Color', [0 0.4470 0.7410], 'DisplayName', 'Arrival Time');
plot(1:nTrials, mean_lat, '-^', 'LineWidth', 2, 'Color', 'r', 'DisplayName', 'Latency');
xlabel('Trial');
ylabel('Time (s)');
title('Group Means Across Trials');
legend('show', 'Location', 'best');
grid on;
xticks(1:nTrials);

% Save plot as PNG
output_png2 = fullfile(output_dir, 'individual_trajectories.png');
saveas(gcf, output_png2, 'png');
fprintf('Saved plot: %s\n', output_png2);
close(gcf);

% Plot 4: Day effects
figure('Position', [100, 100, 1200, 400], 'Visible', 'off');

% Calculate day means
day_means_led = squeeze(mean(mean(led_on, 3, 'omitnan'), 1, 'omitnan'));
day_means_arr = squeeze(mean(mean(arrival, 3, 'omitnan'), 1, 'omitnan'));
day_means_lat = squeeze(mean(mean(latency, 3, 'omitnan'), 1, 'omitnan'));

subplot(1,3,1);
plot(1:nDays, day_means_led, '-o', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', 'b');
xlabel('Day');
ylabel('LED On Time (s)');
title('Day Effects - LED Time');
grid on;
xticks(1:nDays);

subplot(1,3,2);
plot(1:nDays, day_means_arr, '-o', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', 'b');
xlabel('Day');
ylabel('Arrival Time (s)');
title('Day Effects - Arrival Time');
grid on;
xticks(1:nDays);

subplot(1,3,3);
plot(1:nDays, day_means_lat, '-o', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', 'b');
xlabel('Day');
ylabel('Latency (s)');
title('Day Effects - Latency');
grid on;
xticks(1:nDays);

% Save plot as PNG
output_png3 = fullfile(output_dir, 'day_effects.png');
saveas(gcf, output_png3, 'png');
fprintf('Saved plot: %s\n', output_png3);
close(gcf);

% Summary statistics
fprintf('\n=== SUMMARY ===\n');
fprintf('Experimental Design: %d rats × %d days × %d trials\n', nRats, nDays, nTrials);
fprintf('Total observations in analysis: %d\n', total_obs);
fprintf('Overall mean latency: %.3f ± %.3f s (mean ± SD)\n', ...
    mean(long_data.latency, 'omitnan'), std(long_data.latency, 'omitnan'));

fprintf('\n=== OUTPUT FILES SAVED ===\n');
fprintf('Data Tables (XLSX):\n');
fprintf('  - %s\n', output_xlsx);
fprintf('  - %s\n', trial_avg_xlsx);
fprintf('  - %s\n', data_3d_xlsx);
fprintf('  - %s\n', model_results_xlsx);
fprintf('  - %s\n', desc_stats_xlsx);
fprintf('Plots (PNG):\n');
fprintf('  - %s\n', output_png1);
fprintf('  - %s\n', output_png2);
fprintf('  - %s\n', output_png3);
fprintf('\nAll files saved in: %s\n', output_dir);
fprintf('Analysis complete!\n');