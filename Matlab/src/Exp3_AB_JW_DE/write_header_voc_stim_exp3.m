function write_header_voc_stim_exp3(path_filename, ratn, sessn, ntrials, date_time_str, exp_str);

[datafile, errmsg] = fopen(path_filename, 'w');  % creates file for first time (overwriting if already open)
if datafile<0
    disp(errmsg)
end

fprintf(datafile, '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n');
fprintf(datafile, '%% Exp 3 Log File - John Walkey and David Euston\n');
fprintf(datafile, '%% The log file columns can be read as the following:\n');
fprintf(datafile, '%% Time, Event Type\n');
fprintf(datafile, '%%\n');
fprintf(datafile, '%% Event Types:    1 -- Session Start\n');
fprintf(datafile, '%%                 2 -- Session End\n');
fprintf(datafile, '%%                 5 -- Tone-Light Sync Pulse On\n');
fprintf(datafile, '%%                 6 -- Tone-Light Sync Pulse Off\n');
fprintf(datafile, '%%                10 -- Cue light on A\n');
fprintf(datafile, '%%                11 -- Cue light off A\n');
fprintf(datafile, '%%                15 -- Cue light on  B\n');
fprintf(datafile, '%%                16 -- Cue light off B\n');
fprintf(datafile, '%%                20 -- Poke Onset A\n');
fprintf(datafile, '%%                21 -- Poke Offset A\n');
fprintf(datafile, '%%                25 -- Poke Onset B\n');
fprintf(datafile, '%%                26 -- Poke Offset B\n');
fprintf(datafile, '%%                30 -- Stim Onset\n');
fprintf(datafile, '%%                40 -- Trial Timeout\n');
fprintf(datafile, '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n');
fprintf(datafile, ['%% rat: ' num2str(ratn) '\n']);
fprintf(datafile, ['%% sess: ' num2str(sessn) '\n']);
fprintf(datafile, ['%% ntrials: ' num2str(ntrials) '\n']);
fprintf(datafile, ['%% date and start time: ' date_time_str '\n']);
fprintf(datafile, ['%% experimenter: ' exp_str '\n']);

fclose(datafile);

return