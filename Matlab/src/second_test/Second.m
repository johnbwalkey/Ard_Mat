% Load and preprocess data
T = readtable('combined_rat_delays.csv');
T.Properties.VariableNames = matlab.lang.makeValidName(T.Properties.VariableNames);

% Check for delay_s column
if ~ismember('delay_s', T.Properties.VariableNames)
    error('Column delay_s not found.');
end

% Create 'rat' categorical variable if missing, based on integer part of day
if ~ismember('rat', T.Properties.VariableNames)
    T.rat = categorical(floor(T.day));
end

% Extract integer day number and create categorical daynum_cat
if ~ismember('daynum', T.Properties.VariableNames)
    T.daynum = round(mod(T.day,1)*100);
    T.daynum(T.daynum==0) = 1;
end
T.daynum_cat = categorical(T.daynum);

% Remove missing delay_s rows
T = T(~isnan(T.delay_s), :);

% Fit Linear Mixed-Effects Model with categorical daynum and random rat intercept
lme = fitlme(T,'delay_s ~ daynum_cat + (1|rat)');
disp(lme);

% Perform ANOVA on fixed effects with Satterthwaite correction
ranovatbl = anova(lme, 'DFMethod','satterthwaite');
disp(ranovatbl);
fprintf('Overall effect of daynum (categorical): p = %.4g\n', ranovatbl.pValue(1));

% Friedman test per rat (nonparametric repeated measures)
fprintf('\nFriedman test per rat:\n');
for r = categories(T.rat)'
    subData = T(T.rat == r, :);
    uniqueDays = unique(subData.daynum);
    maxTrials = max(histcounts(subData.daynum));
    delayMat = nan(numel(uniqueDays), maxTrials);
    for i=1:numel(uniqueDays)
        dayDelays = subData.delay_s(subData.daynum == uniqueDays(i));
        delayMat(i,1:numel(dayDelays)) = dayDelays;
    end
    delayMat = delayMat(:,any(~isnan(delayMat)));
    if size(delayMat,2) > 1
        pFriedman = friedman(delayMat', 1, 'off');
        fprintf('Rat %s: p = %.4g\n', string(r), pFriedman);
    end
end

% Wilcoxon signed-rank test first vs last day per rat
fprintf('\nWilcoxon test first vs. last day per rat:\n');
for r = categories(T.rat)'
    subData = T(T.rat == r, :);
    uniqueDays = unique(subData.daynum);
    if numel(uniqueDays) < 2
        continue
    end
    d1 = subData.delay_s(subData.daynum == uniqueDays(1));
    d2 = subData.delay_s(subData.daynum == uniqueDays(end));
    n = min(numel(d1), numel(d2));
    if n > 0
        pWilcoxon = signrank(d1(1:n), d2(1:n));
        fprintf('Rat %s: p = %.4g\n', string(r), pWilcoxon);
    end
end

% Plot mean ± SEM delay across days for each rat
figure; hold on;
for r = categories(T.rat)'
    subData = T(T.rat == r, :);
    uniqueDays = unique(subData.daynum);
    means = zeros(numel(uniqueDays), 1);
    sems = means;
    for i=1:numel(uniqueDays)
        vals = subData.delay_s(subData.daynum == uniqueDays(i));
        means(i) = mean(vals);
        sems(i) = std(vals)/sqrt(numel(vals));
    end
    errorbar(uniqueDays, means, sems, '-o', 'DisplayName', char(r));
end
xlabel('Day');
ylabel('Mean Delay (s)');
title('Mean ± SEM Delay by Rat and Day');
legend('Location','northeast');
hold off;
saveas(gcf,'plot_combined_rat_delays_meanSEM.png');

% Save summary statistics to Excel file
summaryData = {};
for r = categories(T.rat)'
    subData = T(T.rat == r, :);
    uniqueDays = unique(subData.daynum);
    for i=1:numel(uniqueDays)
        vals = subData.delay_s(subData.daynum == uniqueDays(i));
        summaryData = [summaryData; {char(r), uniqueDays(i), mean(vals), std(vals)/sqrt(numel(vals)), numel(vals)}];
    end
end
summaryTable = cell2table(summaryData, 'VariableNames', {'Rat','Day','MeanDelay','SEMDelay','N'});
writetable(summaryTable,'combined_rat_delays_stats.xlsx');

fprintf('\nAnalysis complete. Results saved to combined_rat_delays_stats.xlsx and plot_combined_rat_delays_meanSEM.png\n');
