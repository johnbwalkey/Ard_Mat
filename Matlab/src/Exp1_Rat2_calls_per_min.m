% code from chatGPT to do Burg exp 1 calls per min
% for rat 2 4 days

% Load the data
data = readtable('Rat 2 Exp1 4 days USVs.csv');

% Convert begin times to minutes
data.BeginMinutes = data.begin times / 60;

% Group data by minute
minutes = floor(data.BeginMinutes);
unique_minutes = unique(minutes);

% Analyze calls per minute
calls_per_minute = arrayfun(@(x) sum(minutes == x), unique_minutes);

% Plot the results
figure;
plot(unique_minutes, calls_per_minute, '-o');
title('Number of Calls per Minute');
xlabel('Time (minutes)');
ylabel('Number of Calls');
grid on;


