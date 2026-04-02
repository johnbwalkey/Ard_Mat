function rat_learning_analysis()
    % RAT LEARNING ANALYSIS
    % Comprehensive analysis of rat learning data with graphs and Excel output
    
    fprintf('🐀 RAT LEARNING DATA ANALYSIS\n');
    fprintf('============================================\n\n');
    
    % Display current working directory
    currentDir = pwd;
    fprintf('Current working directory: %s\n', currentDir);
    
    % Step 1: Load and combine data
    [combinedData, fileInfo] = loadAndCombineData();
    
    % Step 2: Basic statistics and data cleaning
    cleanData = cleanAndPrepareData(combinedData);
    
    % Step 3: Perform statistical analyses
    results = performStatisticalAnalyses(cleanData);
    
    % Step 4: Create comprehensive visualizations
    createAllVisualizations(cleanData, results);
    
    % Step 5: Export results to Excel with better error handling
    exportResultsToExcel(cleanData, results, fileInfo);
    
    fprintf('\n🎉 ANALYSIS COMPLETE!\n');
    fprintf('============================================\n');
end

function [combinedData, fileInfo] = loadAndCombineData()
    % Load and combine all rat data files
    
    fprintf('📁 LOADING AND COMBINING DATA...\n');
    
    ratFiles = {
        'combined_rat_delays_r1.csv', 'combined_rat_delays_r2.csv', ...
        'combined_rat_delays_r3.csv', 'combined_rat_delays_r4.csv', ...
        'combined_rat_delays_r5.csv', 'combined_rat_delays_r6.csv'
    };
    
    allData = [];
    fileInfo.ratCount = 0;
    fileInfo.totalTrials = 0;
    
    for i = 1:length(ratFiles)
        if exist(ratFiles{i}, 'file')
            try
                % Read CSV file
                fprintf('Reading file: %s\n', ratFiles{i});
                data = readtable(ratFiles{i});
                
                % Add rat ID column
                ratID = i;
                data.rat_id = repmat(ratID, height(data), 1);
                
                % Reorder columns to have rat_id first
                columnOrder = {'rat_id', 'day', 'trial', 'led_on_time_s', 'arrival_time_s', 'delay_s'};
                data = data(:, columnOrder);
                
                % Append to combined data
                allData = [allData; data];
                
                fileInfo.ratCount = fileInfo.ratCount + 1;
                fileInfo.totalTrials = fileInfo.totalTrials + height(data);
                
                fprintf('✓ Loaded Rat %d: %d trials\n', i, height(data));
                
            catch ME
                fprintf('✗ Error loading %s: %s\n', ratFiles{i}, ME.message);
            end
        else
            fprintf('✗ File not found: %s\n', ratFiles{i});
            fprintf('  Current directory: %s\n', pwd);
            fprintf('  Files in current directory:\n');
            dir *.csv
        end
    end
    
    if isempty(allData)
        error('No data was successfully loaded!');
    end
    
    % Sort by rat_id, day, and trial
    combinedData = sortrows(allData, [1, 2, 3]);
    
    fprintf('✅ Successfully combined data from %d rats (%d total trials)\n', ...
        fileInfo.ratCount, fileInfo.totalTrials);
end

function cleanData = cleanAndPrepareData(combinedData)
    % Clean data and remove missing values
    
    fprintf('\n🧹 CLEANING DATA...\n');
    
    % Remove rows with missing delay values
    missingDelays = isnan(combinedData.delay_s);
    cleanData = combinedData(~missingDelays, :);
    
    fprintf('Removed %d trials with missing delay values\n', sum(missingDelays));
    fprintf('Working with %d clean trials\n', height(cleanData));
    
    % Calculate basic statistics
    fprintf('\n📊 BASIC STATISTICS:\n');
    fprintf('Mean delay: %.6f seconds\n', mean(cleanData.delay_s));
    fprintf('Std delay:  %.6f seconds\n', std(cleanData.delay_s));
    fprintf('Min delay:  %.6f seconds\n', min(cleanData.delay_s));
    fprintf('Max delay:  %.6f seconds\n', max(cleanData.delay_s));
end

function results = performStatisticalAnalyses(cleanData)
    % Perform various statistical analyses
    
    fprintf('\n📈 PERFORMING STATISTICAL ANALYSES...\n');
    
    results = struct();
    
    % 1. Early vs Late performance (Days 1-2 vs Days 5-6)
    results.earlyLate = earlyVsLateAnalysis(cleanData);
    
    % 2. Daily progression analysis
    results.dailyProgress = dailyProgressionAnalysis(cleanData);
    
    % 3. Individual rat analyses
    results.individualRats = individualRatAnalysis(cleanData);
    
    % 4. First vs Last day analysis
    results.firstLast = firstVsLastDayAnalysis(cleanData);
end

function earlyLateResults = earlyVsLateAnalysis(data)
    % Compare early (Days 1-2) vs late (Days 5-6) performance
    
    fprintf('\n🎯 EARLY VS LATE PERFORMANCE ANALYSIS\n');
    fprintf('----------------------------------------\n');
    
    earlyData = data(ismember(data.day, [1, 2]), :);
    lateData = data(ismember(data.day, [5, 6]), :);
    
    % Overall t-test
    [h, p, ci, stats] = ttest2(earlyData.delay_s, lateData.delay_s, 'Vartype', 'unequal');
    
    % Calculate effect size (Cohen's d)
    n1 = length(earlyData.delay_s);
    n2 = length(lateData.delay_s);
    pooled_std = sqrt(((n1-1)*std(earlyData.delay_s)^2 + (n2-1)*std(lateData.delay_s)^2) / (n1+n2-2));
    cohen_d = (mean(earlyData.delay_s) - mean(lateData.delay_s)) / pooled_std;
    
    earlyLateResults.overall.h = h;
    earlyLateResults.overall.p = p;
    earlyLateResults.overall.t = stats.tstat;
    earlyLateResults.overall.df = stats.df;
    earlyLateResults.overall.cohen_d = cohen_d;
    earlyLateResults.overall.early_mean = mean(earlyData.delay_s);
    earlyLateResults.overall.late_mean = mean(lateData.delay_s);
    earlyLateResults.overall.early_std = std(earlyData.delay_s);
    earlyLateResults.overall.late_std = std(lateData.delay_s);
    earlyLateResults.overall.early_n = n1;
    earlyLateResults.overall.late_n = n2;
    
    fprintf('Overall Analysis (All Rats):\n');
    fprintf('  Early (Days 1-2): %.4f ± %.4f s (n=%d)\n', ...
        earlyLateResults.overall.early_mean, earlyLateResults.overall.early_std, n1);
    fprintf('  Late  (Days 5-6): %.4f ± %.4f s (n=%d)\n', ...
        earlyLateResults.overall.late_mean, earlyLateResults.overall.late_std, n2);
    fprintf('  t(%d) = %.3f, p = %.4f%s\n', stats.df, stats.tstat, p, getSignificanceStars(p));
    fprintf('  Cohen''s d = %.3f\n', cohen_d);
    
    % Individual rat analyses
    ratIDs = unique(data.rat_id);
    individualResults = [];
    
    for i = 1:length(ratIDs)
        ratID = ratIDs(i);
        ratData = data(data.rat_id == ratID, :);
        
        ratEarly = ratData(ismember(ratData.day, [1, 2]), :);
        ratLate = ratData(ismember(ratData.day, [5, 6]), :);
        
        if height(ratEarly) > 1 && height(ratLate) > 1
            [h_rat, p_rat, ~, stats_rat] = ttest2(ratEarly.delay_s, ratLate.delay_s, 'Vartype', 'unequal');
            
            % Store individual results
            individualResults(i).rat_id = ratID;
            individualResults(i).early_mean = mean(ratEarly.delay_s);
            individualResults(i).late_mean = mean(ratLate.delay_s);
            individualResults(i).early_std = std(ratEarly.delay_s);
            individualResults(i).late_std = std(ratLate.delay_s);
            individualResults(i).early_n = height(ratEarly);
            individualResults(i).late_n = height(ratLate);
            individualResults(i).t_stat = stats_rat.tstat;
            individualResults(i).p_value = p_rat;
            individualResults(i).significant = p_rat < 0.05;
            individualResults(i).improved = mean(ratLate.delay_s) < mean(ratEarly.delay_s);
            
            fprintf('Rat %d: p = %.4f%s, Improved: %s\n', ...
                ratID, p_rat, getSignificanceStars(p_rat), boolToYesNo(individualResults(i).improved));
        end
    end
    
    earlyLateResults.individual = individualResults;
end

function dailyResults = dailyProgressionAnalysis(data)
    % Analyze daily progression of performance
    
    fprintf('\n📅 DAILY PROGRESSION ANALYSIS\n');
    fprintf('----------------------------------------\n');
    
    days = unique(data.day);
    dailyMeans = zeros(length(days), 1);
    dailyStd = zeros(length(days), 1);
    dailyCounts = zeros(length(days), 1);
    
    for i = 1:length(days)
        dayData = data(data.day == days(i), :);
        dailyMeans(i) = mean(dayData.delay_s);
        dailyStd(i) = std(dayData.delay_s);
        dailyCounts(i) = height(dayData);
    end
    
    dailyResults.days = days;
    dailyResults.means = dailyMeans;
    dailyResults.std = dailyStd;
    dailyResults.counts = dailyCounts;
    
    % Test for linear trend
    [rho, p_rho] = corr(days, dailyMeans);
    dailyResults.trend_correlation = rho;
    dailyResults.trend_p = p_rho;
    
    fprintf('Daily means: [%s]\n', sprintf('%.4f ', dailyMeans));
    fprintf('Trend correlation: rho = %.3f, p = %.4f%s\n', ...
        rho, p_rho, getSignificanceStars(p_rho));
end

function individualResults = individualRatAnalysis(data)
    % Analyze each rat individually
    
    fprintf('\n🐁 INDIVIDUAL RAT ANALYSES\n');
    fprintf('----------------------------------------\n');
    
    ratIDs = unique(data.rat_id);
    
    for i = 1:length(ratIDs)
        ratID = ratIDs(i);
        ratData = data(data.rat_id == ratID, :);
        
        individualResults(i).rat_id = ratID;
        individualResults(i).mean_delay = mean(ratData.delay_s);
        individualResults(i).std_delay = std(ratData.delay_s);
        individualResults(i).total_trials = height(ratData);
        individualResults(i).days_tested = length(unique(ratData.day));
        
        % Learning rate (correlation between day and performance)
        days = ratData.day;
        delays = ratData.delay_s;
        [rho, p_corr] = corr(days, delays);
        individualResults(i).learning_correlation = rho;
        individualResults(i).learning_p = p_corr;
        
        fprintf('Rat %d: Mean = %.4f ± %.4f s, Learning rho = %.3f%s\n', ...
            ratID, individualResults(i).mean_delay, individualResults(i).std_delay, ...
            rho, getSignificanceStars(p_corr));
    end
end

function firstLastResults = firstVsLastDayAnalysis(data)
    % Compare only Day 1 vs Day 6
    
    fprintf('\n📊 FIRST VS LAST DAY ANALYSIS\n');
    fprintf('----------------------------------------\n');
    
    day1Data = data(data.day == 1, :);
    day6Data = data(data.day == 6, :);
    
    [h, p, ci, stats] = ttest2(day1Data.delay_s, day6Data.delay_s, 'Vartype', 'unequal');
    
    firstLastResults.day1_mean = mean(day1Data.delay_s);
    firstLastResults.day1_std = std(day1Data.delay_s);
    firstLastResults.day1_n = height(day1Data);
    firstLastResults.day6_mean = mean(day6Data.delay_s);
    firstLastResults.day6_std = std(day6Data.delay_s);
    firstLastResults.day6_n = height(day6Data);
    firstLastResults.t_stat = stats.tstat;
    firstLastResults.p_value = p;
    firstLastResults.df = stats.df;
    firstLastResults.significant = p < 0.05;
    
    fprintf('Day 1: %.4f ± %.4f s (n=%d)\n', ...
        firstLastResults.day1_mean, firstLastResults.day1_std, firstLastResults.day1_n);
    fprintf('Day 6: %.4f ± %.4f s (n=%d)\n', ...
        firstLastResults.day6_mean, firstLastResults.day6_std, firstLastResults.day6_n);
    fprintf('t(%d) = %.3f, p = %.4f%s\n', ...
        stats.df, stats.tstat, p, getSignificanceStars(p));
end

function createAllVisualizations(data, results)
    % Create comprehensive visualizations
    
    fprintf('\n📈 CREATING VISUALIZATIONS...\n');
    
    figure('Position', [100, 100, 1400, 1000]);
    
    % Plot 1: Learning curves for each rat
    subplot(2, 3, 1);
    plotIndividualLearningCurves(data);
    
    % Plot 2: Overall daily performance
    subplot(2, 3, 2);
    plotOverallDailyPerformance(results.dailyProgress);
    
    % Plot 3: Early vs Late comparison
    subplot(2, 3, 3);
    plotEarlyVsLateComparison(results.earlyLate);
    
    % Plot 4: Individual rat performance
    subplot(2, 3, 4);
    plotIndividualRatPerformance(results.individualRats);
    
    % Plot 5: Distribution analysis
    subplot(2, 3, 5);
    plotDelayDistributions(data);
    
    % Plot 6: Statistical significance summary
    subplot(2, 3, 6);
    plotStatisticalSummary(results);
    
    sgtitle('Comprehensive Rat Learning Analysis', 'FontSize', 16, 'FontWeight', 'bold');
    
    % Save the main figure
    saveas(gcf, 'rat_learning_analysis.png');
    fprintf('✓ Saved main analysis figure as "rat_learning_analysis.png"\n');
    
    % Create additional detailed figures
    createDetailedFigures(data, results);
end

function plotIndividualLearningCurves(data)
    % Plot learning curves for each rat
    
    ratIDs = unique(data.rat_id);
    days = unique(data.day);
    
    hold on;
    colors = lines(length(ratIDs));
    
    for i = 1:length(ratIDs)
        ratID = ratIDs(i);
        ratData = data(data.rat_id == ratID, :);
        
        dailyMeans = zeros(length(days), 1);
        for j = 1:length(days)
            dayData = ratData(ratData.day == days(j), :);
            if ~isempty(dayData)
                dailyMeans(j) = mean(dayData.delay_s);
            else
                dailyMeans(j) = NaN;
            end
        end
        
        plot(days, dailyMeans, 'o-', 'Color', colors(i,:), 'LineWidth', 2, ...
            'MarkerSize', 6, 'DisplayName', sprintf('Rat %d', ratID));
    end
    
    xlabel('Day');
    ylabel('Mean Delay (seconds)');
    title('Individual Rat Learning Curves');
    legend('show', 'Location', 'best');
    grid on;
    hold off;
end

function plotOverallDailyPerformance(dailyResults)
    % Plot overall daily performance with error bars
    
    errorbar(dailyResults.days, dailyResults.means, dailyResults.std, 'o-', ...
        'LineWidth', 2, 'MarkerSize', 8, 'CapSize', 10);
    
    xlabel('Day');
    ylabel('Mean Delay (seconds)');
    title('Overall Daily Performance');
    grid on;
    
    % Add trend line if significant
    if dailyResults.trend_p < 0.05
        hold on;
        p = polyfit(dailyResults.days, dailyResults.means, 1);
        y_trend = polyval(p, dailyResults.days);
        plot(dailyResults.days, y_trend, 'r--', 'LineWidth', 1, 'DisplayName', 'Trend');
        legend('show', 'Location', 'best');
        hold off;
    end
end

function plotEarlyVsLateComparison(earlyLateResults)
    % Plot early vs late performance comparison
    
    categories = {'Early (Days 1-2)', 'Late (Days 5-6)'};
    means = [earlyLateResults.overall.early_mean, earlyLateResults.overall.late_mean];
    stds = [earlyLateResults.overall.early_std, earlyLateResults.overall.late_std];
    
    bar(1:2, means, 'FaceColor', [0.7 0.7 0.9]);
    hold on;
    errorbar(1:2, means, stds, 'k.', 'LineWidth', 2, 'CapSize', 15);
    
    % Add significance marker
    if earlyLateResults.overall.p < 0.05
        max_val = max(means + stds);
        plot([1, 2], [max_val + 0.002, max_val + 0.002], 'k-', 'LineWidth', 1.5);
        text(1.5, max_val + 0.003, getSignificanceStars(earlyLateResults.overall.p), ...
            'HorizontalAlignment', 'center', 'FontWeight', 'bold');
    end
    
    set(gca, 'XTickLabel', categories);
    ylabel('Mean Delay (seconds)');
    title('Early vs Late Performance');
    grid on;
    hold off;
end

function plotIndividualRatPerformance(individualResults)
    % Plot individual rat performance summary
    
    ratIDs = [individualResults.rat_id];
    means = [individualResults.mean_delay];
    
    bar(ratIDs, means, 'FaceColor', [0.4 0.8 0.6]);
    xlabel('Rat ID');
    ylabel('Mean Delay (seconds)');
    title('Individual Rat Performance');
    grid on;
end

function plotDelayDistributions(data)
    % Plot distribution of delays
    
    histogram(data.delay_s, 30, 'FaceColor', [0.2 0.6 0.8], 'EdgeColor', 'black');
    xlabel('Delay (seconds)');
    ylabel('Frequency');
    title('Distribution of All Delay Times');
    grid on;
    
    % Add mean line
    hold on;
    yl = ylim;
    plot([mean(data.delay_s), mean(data.delay_s)], yl, 'r--', 'LineWidth', 2, ...
        'DisplayName', sprintf('Mean: %.4f s', mean(data.delay_s)));
    legend('show', 'Location', 'best');
    hold off;
end

function plotStatisticalSummary(results)
    % Plot statistical significance summary
    
    individual = results.earlyLate.individual;
    ratIDs = [individual.rat_id];
    pValues = [individual.p_value];
    improved = [individual.improved];
    
    colors = zeros(length(ratIDs), 3);
    for i = 1:length(ratIDs)
        if pValues(i) < 0.05 && improved(i)
            colors(i, :) = [0, 0.8, 0]; % Green for significant improvement
        elseif pValues(i) < 0.05
            colors(i, :) = [0.8, 0, 0]; % Red for significant worsening
        else
            colors(i, :) = [0.7, 0.7, 0.7]; % Gray for non-significant
        end
    end
    
    scatter(ratIDs, pValues, 100, colors, 'filled');
    xlabel('Rat ID');
    ylabel('p-value');
    title('Statistical Significance by Rat');
    grid on;
    
    % Add significance threshold line
    hold on;
    plot(xlim, [0.05, 0.05], 'r--', 'LineWidth', 1.5, 'DisplayName', 'p = 0.05');
    legend('show', 'Location', 'best');
    hold off;
end

function createDetailedFigures(data, results)
    % Create additional detailed figures
    
    % Figure 2: Individual rat daily performance
    figure('Position', [100, 100, 1200, 800]);
    
    ratIDs = unique(data.rat_id);
    for i = 1:length(ratIDs)
        subplot(2, 3, i);
        plotSingleRatPerformance(data, ratIDs(i));
    end
    
    sgtitle('Individual Rat Daily Performance', 'FontSize', 16, 'FontWeight', 'bold');
    saveas(gcf, 'individual_rat_performance.png');
    fprintf('✓ Saved individual rat performance figure\n');
    
    % Figure 3: Statistical results summary
    figure('Position', [100, 100, 1000, 600]);
    
    subplot(1, 2, 1);
    plotEffectSizes(results);
    
    subplot(1, 2, 2);
    plotLearningRates(results.individualRats);
    
    sgtitle('Statistical Results Summary', 'FontSize', 16, 'FontWeight', 'bold');
    saveas(gcf, 'statistical_summary.png');
    fprintf('✓ Saved statistical summary figure\n');
end

function plotSingleRatPerformance(data, ratID)
    % Plot detailed performance for a single rat
    
    ratData = data(data.rat_id == ratID, :);
    days = unique(ratData.day);
    
    dailyMeans = zeros(length(days), 1);
    dailyStd = zeros(length(days), 1);
    
    for i = 1:length(days)
        dayData = ratData(ratData.day == days(i), :);
        dailyMeans(i) = mean(dayData.delay_s);
        dailyStd(i) = std(dayData.delay_s);
    end
    
    errorbar(days, dailyMeans, dailyStd, 'o-', 'LineWidth', 2, 'MarkerSize', 6, 'CapSize', 8);
    xlabel('Day');
    ylabel('Delay (seconds)');
    title(sprintf('Rat %d Performance', ratID));
    grid on;
    
    % Add trend line
    hold on;
    p = polyfit(days, dailyMeans, 1);
    y_trend = polyval(p, days);
    plot(days, y_trend, 'r--', 'LineWidth', 1);
    hold off;
end

function plotEffectSizes(results)
    % Plot effect sizes for different comparisons
    
    comparisons = {'Early vs Late', 'Day 1 vs Day 6'};
    effectSizes = [results.earlyLate.overall.cohen_d, ...
                  (results.firstLast.day1_mean - results.firstLast.day6_mean) / ...
                  sqrt((results.firstLast.day1_std^2 + results.firstLast.day6_std^2)/2)];
    
    bar(effectSizes, 'FaceColor', [0.8 0.6 0.2]);
    set(gca, 'XTickLabel', comparisons);
    ylabel('Cohen''s d (Effect Size)');
    title('Effect Sizes for Key Comparisons');
    grid on;
    
    % Add value labels
    for i = 1:length(effectSizes)
        text(i, effectSizes(i) + 0.1 * sign(effectSizes(i)), ...
            sprintf('%.3f', effectSizes(i)), 'HorizontalAlignment', 'center');
    end
end

function plotLearningRates(individualResults)
    % Plot learning rates (correlations) for each rat
    
    ratIDs = [individualResults.rat_id];
    learningRates = [individualResults.learning_correlation];
    
    bar(ratIDs, learningRates, 'FaceColor', [0.6 0.4 0.8]);
    xlabel('Rat ID');
    ylabel('Learning Correlation (rho)');
    title('Individual Learning Rates');
    grid on;
    
    % Add significance markers
    hold on;
    for i = 1:length(ratIDs)
        if individualResults(i).learning_p < 0.05
            plot(ratIDs(i), learningRates(i) + 0.1 * sign(learningRates(i)), ...
                'r*', 'MarkerSize', 10);
        end
    end
    hold off;
end

function exportResultsToExcel(cleanData, results, fileInfo)
    % Export all results to Excel file with robust error handling
    
    fprintf('\n💾 EXPORTING RESULTS TO EXCEL...\n');
    
    filename = 'rat_learning_analysis_results.xlsx';
    fullPath = fullfile(pwd, filename);
    
    fprintf('Attempting to create Excel file: %s\n', fullPath);
    
    try
        % Delete existing file if it exists
        if exist(fullPath, 'file')
            delete(fullPath);
            fprintf('Deleted existing file\n');
        end
        
        % Sheet 1: Combined raw data
        fprintf('Writing sheet: Combined_Data\n');
        writetable(cleanData, filename, 'Sheet', 'Combined_Data');
        
        % Sheet 2: Summary statistics
        fprintf('Writing sheet: Summary_Statistics\n');
        summaryTable = createSummaryTable(cleanData, results, fileInfo);
        writetable(summaryTable, filename, 'Sheet', 'Summary_Statistics');
        
        % Sheet 3: Early vs Late results
        fprintf('Writing sheet: Early_vs_Late_Analysis\n');
        earlyLateTable = createEarlyLateTable(results.earlyLate);
        writetable(earlyLateTable, filename, 'Sheet', 'Early_vs_Late_Analysis');
        
        % Sheet 4: Daily performance
        fprintf('Writing sheet: Daily_Performance\n');
        dailyTable = createDailyPerformanceTable(cleanData);
        writetable(dailyTable, filename, 'Sheet', 'Daily_Performance');
        
        % Sheet 5: Individual rat statistics
        fprintf('Writing sheet: Individual_Rat_Stats\n');
        individualTable = createIndividualRatTable(results.individualRats);
        writetable(individualTable, filename, 'Sheet', 'Individual_Rat_Stats');
        
        % Sheet 6: Statistical results
        fprintf('Writing sheet: Statistical_Results\n');
        statsTable = createStatisticalResultsTable(results);
        writetable(statsTable, filename, 'Sheet', 'Statistical_Results');
        
        % Verify file was created
        if exist(fullPath, 'file')
            fileInfo = dir(fullPath);
            fprintf('✓ SUCCESS: Excel file created: %s\n', fullPath);
            fprintf('  File size: %.2f KB\n', fileInfo.bytes/1024);
            fprintf('  Location: %s\n', fullPath);
            
            % List all sheets in the file
            [~, sheetNames] = xlsfinfo(fullPath);
            fprintf('  Sheets created:\n');
            for i = 1:length(sheetNames)
                fprintf('    - %s\n', sheetNames{i});
            end
        else
            fprintf('✗ ERROR: File was not created\n');
        end
        
    catch ME
        fprintf('✗ ERROR creating Excel file: %s\n', ME.message);
        fprintf('Troubleshooting tips:\n');
        fprintf('1. Make sure Excel is installed on your system\n');
        fprintf('2. Check if the file is open in Excel (close it)\n');
        fprintf('3. Check write permissions in current directory\n');
        fprintf('4. Current directory: %s\n', pwd);
        
        % Try to create a CSV backup instead
        fprintf('\nTrying to create CSV backup files instead...\n');
        createCSVBackup(cleanData, results, fileInfo);
    end
end

function createCSVBackup(cleanData, results, fileInfo)
    % Create CSV files if Excel fails
    
    fprintf('Creating CSV backup files...\n');
    
    try
        % Combined data
        writetable(cleanData, 'combined_rat_data.csv');
        fprintf('✓ Created combined_rat_data.csv\n');
        
        % Summary statistics
        summaryTable = createSummaryTable(cleanData, results, fileInfo);
        writetable(summaryTable, 'summary_statistics.csv');
        fprintf('✓ Created summary_statistics.csv\n');
        
        % Early vs Late results
        earlyLateTable = createEarlyLateTable(results.earlyLate);
        writetable(earlyLateTable, 'early_vs_late_analysis.csv');
        fprintf('✓ Created early_vs_late_analysis.csv\n');
        
        fprintf('CSV backup files created successfully!\n');
        
    catch ME
        fprintf('✗ ERROR creating CSV files: %s\n', ME.message);
    end
end

function summaryTable = createSummaryTable(data, results, fileInfo)
    % Create summary statistics table
    
    summaryData = {
        'Total Rats', fileInfo.ratCount;
        'Total Trials', fileInfo.totalTrials;
        'Clean Trials (no missing)', height(data);
        'Overall Mean Delay (s)', mean(data.delay_s);
        'Overall Std Delay (s)', std(data.delay_s);
        'Minimum Delay (s)', min(data.delay_s);
        'Maximum Delay (s)', max(data.delay_s);
        'Early vs Late p-value', results.earlyLate.overall.p;
        'Early vs Late Effect Size', results.earlyLate.overall.cohen_d;
        'Day 1 vs Day 6 p-value', results.firstLast.p_value;
        'Daily Trend p-value', results.dailyProgress.trend_p;
        'Rats Showing Improvement', sum([results.earlyLate.individual.improved]);
        'Significant Improvements', sum([results.earlyLate.individual.significant] & [results.earlyLate.individual.improved])
    };
    
    summaryTable = cell2table(summaryData, 'VariableNames', {'Metric', 'Value'});
end

function earlyLateTable = createEarlyLateTable(earlyLateResults)
    % Create early vs late analysis table
    
    individual = earlyLateResults.individual;
    
    ratIDs = [individual.rat_id]';
    earlyMeans = [individual.early_mean]';
    lateMeans = [individual.late_mean]';
    differences = lateMeans - earlyMeans;
    pValues = [individual.p_value]';
    significant = [individual.significant]';
    improved = [individual.improved]';
    
    earlyLateTable = table(ratIDs, earlyMeans, lateMeans, differences, pValues, significant, improved, ...
        'VariableNames', {'Rat_ID', 'Early_Mean', 'Late_Mean', 'Difference', 'P_Value', 'Significant', 'Improved'});
end

function dailyTable = createDailyPerformanceTable(data)
    % Create daily performance summary table
    
    days = unique(data.day);
    dailyStats = [];
    
    for i = 1:length(days)
        dayData = data(data.day == days(i), :);
        dailyStats(i).Day = days(i);
        dailyStats(i).Mean_Delay = mean(dayData.delay_s);
        dailyStats(i).Std_Delay = std(dayData.delay_s);
        dailyStats(i).N_Trials = height(dayData);
        dailyStats(i).Min_Delay = min(dayData.delay_s);
        dailyStats(i).Max_Delay = max(dayData.delay_s);
    end
    
    dailyTable = struct2table(dailyStats);
end

function individualTable = createIndividualRatTable(individualResults)
    % Create individual rat statistics table
    
    ratIDs = [individualResults.rat_id]';
    meanDelays = [individualResults.mean_delay]';
    stdDelays = [individualResults.std_delay]';
    totalTrials = [individualResults.total_trials]';
    daysTested = [individualResults.days_tested]';
    learningRates = [individualResults.learning_correlation]';
    learningP = [individualResults.learning_p]';
    
    individualTable = table(ratIDs, meanDelays, stdDelays, totalTrials, daysTested, learningRates, learningP, ...
        'VariableNames', {'Rat_ID', 'Mean_Delay', 'Std_Delay', 'Total_Trials', 'Days_Tested', 'Learning_Correlation', 'Learning_P_Value'});
end

function statsTable = createStatisticalResultsTable(results)
    % Create comprehensive statistical results table
    
    testNames = {
        'Early vs Late (Overall)';
        'Day 1 vs Day 6';
        'Daily Trend';
        'Early vs Late (Rat 1)';
        'Early vs Late (Rat 2)';
        'Early vs Late (Rat 3)';
        'Early vs Late (Rat 4)';
        'Early vs Late (Rat 5)';
        'Early vs Late (Rat 6)'
    };
    
    pValues = [
        results.earlyLate.overall.p;
        results.firstLast.p_value;
        results.dailyProgress.trend_p;
        results.earlyLate.individual(1).p_value;
        results.earlyLate.individual(2).p_value;
        results.earlyLate.individual(3).p_value;
        results.earlyLate.individual(4).p_value;
        results.earlyLate.individual(5).p_value;
        results.earlyLate.individual(6).p_value
    ];
    
    effectSizes = [
        results.earlyLate.overall.cohen_d;
        (results.firstLast.day1_mean - results.firstLast.day6_mean) / sqrt((results.firstLast.day1_std^2 + results.firstLast.day6_std^2)/2);
        results.dailyProgress.trend_correlation;
        NaN; NaN; NaN; NaN; NaN; NaN  % Individual rat effect sizes not calculated
    ];
    
    significant = pValues < 0.05;
    
    statsTable = table(testNames, pValues, effectSizes, significant, ...
        'VariableNames', {'Test', 'P_Value', 'Effect_Size', 'Significant'});
end

% Helper functions
function stars = getSignificanceStars(p)
    % Return significance stars based on p-value
    if p < 0.001
        stars = '***';
    elseif p < 0.01
        stars = '**';
    elseif p < 0.05
        stars = '*';
    else
        stars = '';
    end
end

function answer = boolToYesNo(boolVal)
    % Convert boolean to Yes/No string
    if boolVal
        answer = 'Yes';
    else
        answer = 'No';
    end
end