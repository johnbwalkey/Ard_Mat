% EXPERIMENT 3  FINAL A/B 30-50 inter-trial interval- Random delay
% 
% Random delay between trials (30-50 sec),
% Random port A or B with LED flashing in - flashes for 60 seconds before timeout,
% Stim available while LED flashing in poke box. 
% log all nose pokes in both boxes.

% Mega & Uno plugged into computer with Mega doing code & Uno serial Stim
    % pin wiring at end of this code
% store data in txt file 
% Video record behavior and DV is ultravocalizations
% Beep and Light (x3) to signal start and end trial (from Mega)

clear
clc
warning ('off'); % stop serialport message
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setup up 2 Arduino (Mega & Uno)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=serial('COM3','BAUDRATE',9600);   % to create the serial port Uno
fopen(s); % open the serial port
m=arduino('com4','Mega2560'); % open and run Mega
DDD=1; % data to send to Arduino uno

% Configure Mega for Nose Poke switch IR
configurePin (m, 'D5', 'DigitalInput'); % box 2 (A)
configurePin(m, 'D5', 'pullup');% set pullup resistor
configurePin (m, 'D6', 'DigitalInput'); % box 3 (B)
configurePin(m, 'D6', 'pullup');% set pullup resistor


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set parameters and constants
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
default_exp = 'JW';
default_trials = 20;
datapath = 'C:\Users\john\OneDrive\Documents\MATLAB\Exp3_AB_JW_DE';  % does not include a final \
min_iti = 30  %30;   % in seconds, set to short values-like 3- for testing
max_iti = 50  %50;  % in seconds, set to short values- like 10- for testing
timeout = 20;  % give animal this long to respond before trial is aborted and next trial begins
flash_delay = .5;  % seconds, sets flash rate for light cue (light is on for this time then off for this time, repeating)
stim_dur = .5; % only used with GUI
SUPERLONG = 8640;  % number of seconds in a day, used as a default value for timers when inactive

% create the timer structure, which will store the target times to activate
% various events
t.new_trial = SUPERLONG;  % starts a new trial
t.abort_trial = SUPERLONG; % ends trial when rat hasn't responded
t.lcuelight_on = SUPERLONG;  % used for flash on/off of cue
t.lcuelight_off = SUPERLONG;
t.rcuelight_on = SUPERLONG;
t.rcuelight_off = SUPERLONG;
t.stim_off = SUPERLONG; % used with GUI to know when to terminate stim 

% Note to John:  the code below creates a virtual operant box, labeled sim, for testing.  You will need to cut
% this code out and replace with serial read/write operations to the
% arduio. A second gui, abort_panel is handy for smoothly aborting without
% losing your data that may be worth keeping.
% I've used %%X to indicate arduino code which I commented out so you can
% bring it back when needed, but most of the code is new, so you'll need to
% figure out where to put the appropriate arduino calls

sim = nose_poke_simulator  % invoke a gui which will allow interaction with the program and monitoring of output
sim.BeepLightSyncLamp.Color = [.5 .5 .5];
sim.LeftPokeCueLamp.Color = [.5 .5 .5];
sim.RightPokeCueLamp.Color = [.5 .5 .5];
sim.UIFigure.Position = [100 100 472 236];  % John: adjust for your screen dimensions [xpos ypos width height]
                                            % you'll want to keep dimensions, just change xpos and ypos
                                            % DE numbers = [896 877 472 236]

abort_panel = abort_app;  % a GUI allowing user to terminate trial gracefully without using Cntrl-C
                          % using this app allows program to complete and
                          % write data file, otherwise data is lost
                          % also includes a handy trial counter
abort_panel.Label.Text = 'Exp 3 A-B Nose Poke';  % you can change the label
abort_panel.UIFigure.Position = [897 730 209 115]; % John: adjust for your screen dimensions [xpos ypos width height]


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get parameters and information about session from user
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Parameters - Num of Trials ');
disp('20 is recommended number - approximately 20 minutes to run)!');
prompt=['How many trials to run [' num2str(default_trials) ']: '];
num_trials = input(prompt);
if isempty(num_trials), num_trials = default_trials; end
% get Subject number, session number and current date and time
subjn = input('Subject number: ');
if isempty(subjn), subjn = 1; end
sessn = input('Session number: ');
if isempty(sessn), sessn = 1; end
expstr = input(['Experimenter Initials [' default_exp  ']: ']);
if isempty(expstr), expstr = default_exp; end
% Create a datetime object for the current date and time, use the format method to specify the format directly
start_ext_clock_time = datetime('now');
start_ext_clock_time.Format = 'yyyy-MM-dd_HH-mm-ss';
formattedDateStr = char(start_ext_clock_time);

% start the clock
tic;  % setting this now, just after we grab the start clock time, will allow us to synchonize matlabs toc times with external time
      % external time of an event is just clock_time + toc time

% create data file and write header      
filename = ['Voc_Stim_Exp3_R' num2str(subjn) '_Sess' num2str(sessn) '_' formattedDateStr '.txt'];
path_filename = [datapath '\' filename];
write_header_voc_stim_exp3(path_filename, subjn, sessn, num_trials, formattedDateStr, expstr); % creates data file and writes header

% create table to store data.  We will dump this to the data file upon
% completion of the experiment.  Storing it internally will allow the
% function to operate more smoothly without I/O delays.  However, if
% program is stopped by control-C or crashes, data will be lost
% note I make table much bigger than needed and will downsize it before
% writing file
data = table('Size', [20000 2], 'VariableTypes', {'double', 'double'},'VariableNames',   {'Time', 'EventCode'});
di = 1;
data(di,:) = {toc 1};  % session start event
di = di + 1;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate Tone-Light Synchronization Events (Start)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for synci=1:3
     writeDigitalPin (m,'D3',1); %%X 
     disp('D3 on');
     sim.BeepLightSyncLamp.Color = [1 0 0];
     data(di,:) = {toc 5};  % sync pulse start event (each beep is individually recorded)
     di = di + 1;
     pause (0.5); % wait 1/3 second
     writeDigitalPin (m,'D3',0); %%X 
     disp('D3 off');
     sim.BeepLightSyncLamp.Color = [.5 .5 .5];
     data(di,:) = {toc 6}; % sync pulse end event
     di = di + 1;
     pause (0.5);
 end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Processing Loop
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
iti_delays = randi([min_iti max_iti], 1,num_trials+1);  % generate list of all inter-trial intervals
                                                        % made it one
                                                        % longer to avoid
                                                        % an error after
                                                        % the last trial
                                                                                                          
hole_selected = randi([1 2], 1, num_trials);  % 1 for left, 2 for right, cued hole on each trial
t.new_trial = toc+3;  % this will cause trial to start in 3 seconds
left_active = false;  % true when cue is active
right_active = false; % true when cue is inactive
tri = 1;  % trial counter
abort_panel.CurrentTrialEditField.Value = tri;
sess_over = false;  % boolean flag which will go high at end of session or when keyboard entry indicates abort
lpoke_flag = false;  % goes high when left poke state transitions from 0 to 1
prev_lpoke_state = false;  % keeps track of poke state [0 or 1] last time we checked, used to detect poke onset
rpoke_flag = false;  % goes high when right poke state transitions from 0 to 1
prev_rpoke_state = false;  % keeps track of poke state [0 or 1] last time we checked, used to detect poke onset

while ~sess_over
    
    drawnow;  % needed to keep GUI updated and responsive.  
              % This command takes up the majority of the processing time
              % If there are lags in processing we can make this so that it
              % checks only once every 1000 iterations or something like
              % that.  We could just have to add an iteration counter and
              % check when it is a multiple of 1000.
    
    cur_t = toc;  % grab this once and reuse to save cycles

    % catch and log any nose pokes in left (A) hole
    if sim.LeftHolePoke~=prev_lpoke_state
        % transition from no poke to poke
        if sim.LeftHolePoke==1 && prev_lpoke_state==false
            lpoke_flag = true;  % this will be detected in the left_active condition and trigger stim
            data(di,:)={cur_t 20}; % poke onset A (left)
            di = di + 1;
        end
        % transition poke to no poke, used only to log the event
        if sim.LeftHolePoke==0 && prev_lpoke_state==true
            data(di,:)={cur_t 21}; % poke onset A (left)
            di = di + 1;
        end
    end

    % catch and log any nose pokes in right (B) hole
    if sim.RightHolePoke~=prev_rpoke_state
        % transition from no poke to poke
        if sim.RightHolePoke==1 && prev_rpoke_state==false
            rpoke_flag = true;  % this will be detected in the left_active condition and trigger stim
            data(di,:)={cur_t 25}; % poke onset B (right)
            di = di + 1;
        end
        % transition poke to no poke, used only to log the event
        if sim.RightHolePoke==0 && prev_rpoke_state==true
            data(di,:)={cur_t 26}; % poke onset B (right)
            di = di + 1;
        end
    end


    % start trial
    if cur_t>t.new_trial
        % set flag which will trigger light flash in appropriate hole
        if hole_selected(tri) == 1  % 1 is left/A and 2 is right/B
            left_active = true;
            t.lcuelight_on = cur_t; % start light on now
            data(di,:)={cur_t 10}; % trial onset and cue onset A (left)
            di = di + 1;
        else
            right_active = true;
            t.rcuelight_on = cur_t; % start light on now
            data(di,:)={cur_t 15}; % trial onset and cue onset B (right)
            di = di + 1;
        end
        t.abort_trial = cur_t + timeout; % trial will abort at this point
        t.new_trial = SUPERLONG; % inactivate timer - will be reset at trial end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if left_active

        % light flashing code - alternately set timers to turn light on and off
        % this is were signals are sent to turn on and off cue light
        if cur_t>t.lcuelight_on  % triggers light on
            sim.LeftPokeCueLamp.Color = [ 1 1 0]; % yellow
            t.lcuelight_off = t.lcuelight_on + flash_delay;
            t.lcuelight_on = SUPERLONG;
            writeDigitalPin (m,'D8',1); % LED on - JW
        end
        if cur_t>t.lcuelight_off  % triggers light off
            sim.LeftPokeCueLamp.Color = [ .5 .5 .5]; % gray
            t.lcuelight_on = t.lcuelight_off + flash_delay;
            t.lcuelight_off = SUPERLONG;
            writeDigitalPin (m,'D8',0); % LED off - JW
        end

        if lpoke_flag | readDigitalPin(m, 'D5') <= 0.5  % nosepoke detected
            
            % turn off active state and cue light
            left_active = false;  % terminate active state
            t.lcuelight_on = SUPERLONG;
            t.lcuelight_off = SUPERLONG;
            sim.LeftPokeCueLamp.Color = [ .5 .5 .5]; % turn off light in case it was in the on state
              writeDigitalPin (m,'D8',0); % LED off - JW
            % log event
            data(di,:)={cur_t 11}; % trial and cue offset A (left)
            di = di + 1;

            % trigger next trial (after delay)
            tri = tri + 1;  % increment trial counter
            abort_panel.CurrentTrialEditField.Value = tri;
            t.new_trial = cur_t + iti_delays(tri);  % set time for start of next trial
            
            % deliver stim
            sim.StimIndicatorLamp.Color = [0 1 1]; % cyan
            t.stim_off = cur_t + stim_dur;  % sets timer so that stim light can be turned off after appropriate delay
              datas = 1;
              fprintf(s,'%i',datas); % send data to arduino
              writeDigitalPin (m,'D8',0); % LED off - JW
              pause(1);
            % log stim event
            data(di,:)={cur_t 30}; % trial and cue offset A (left)
            di = di + 1;
            writeDigitalPin (m,'D8',0); % LED off - JW
        end
        if cur_t>t.abort_trial  % rat didn't poke in time, abort trial
            disp('timeout')
            
            % deactivate nose port and turn off cue light (in case it was in the on state)
            left_active = false;
            t.lcuelight_on = SUPERLONG;
            t.lcuelight_off = SUPERLONG;
            sim.LeftPokeCueLamp.Color = [ .5 .5 .5]; % turn off light in case it was in the on state
            writeDigitalPin (m,'D8',0); % LED off - JW
            % start next trial
            tri = tri + 1;  % increment trial counter
            abort_panel.CurrentTrialEditField.Value = tri;
            t.new_trial = cur_t + iti_delays(tri);  % set time for start of next trial

            % log events
            data(di,:)={cur_t 11}; % trial offset and cue offset A (left)
            di = di + 1;
            data(di,:)={cur_t 40}; % indicates trial timeout
            di = di + 1;

        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if right_active

        % light flashing code - alternately set timers to turn light on and off
        % this is were signals are sent to turn on and off cue light
        if cur_t>t.rcuelight_on  % triggers light on
            sim.RightPokeCueLamp.Color = [ 1 1 0]; % yellow
            t.rcuelight_off = t.rcuelight_on + flash_delay;
            t.rcuelight_on = SUPERLONG;
            writeDigitalPin (m,'D9',1); % LED on - JW
        end
        if cur_t>t.rcuelight_off  % triggers light off
            sim.RightPokeCueLamp.Color = [ .5 .5 .5]; % gray
            t.rcuelight_on = t.rcuelight_off + flash_delay;
            t.rcuelight_off = SUPERLONG;
            writeDigitalPin (m,'D9',0); % LED off - JW
        end

        if rpoke_flag | readDigitalPin(m, 'D6') <= 0.5   % nosepoke detected
            
            % turn off active state and cue light
            right_active = false;  % terminate active state
            t.rcuelight_on = SUPERLONG;
            t.rcuelight_off = SUPERLONG;
            sim.RightPokeCueLamp.Color = [ .5 .5 .5]; % turn off light in case it was in the on state
              writeDigitalPin (m,'D9',0); % LED off - JW
            % log event
            data(di,:)={cur_t 16}; % trial and cue offset A (left)
            di = di + 1;
            writeDigitalPin (m,'D9',0); % LED off - JW

            % trigger next trial (after delay)
            tri = tri + 1;  % increment trial counter
            abort_panel.CurrentTrialEditField.Value = tri;
            t.new_trial = cur_t + iti_delays(tri);  % set time for start of next trial
            
            % deliver stim
            sim.StimIndicatorLamp.Color = [0 1 1]; % cyan
            t.stim_off = cur_t + stim_dur;  % sets timer so that stim light can be turned off after appropriate delay
              datas = 1;
              fprintf(s,'%i',datas); % send data to arduino
              writeDigitalPin (m,'D9',0); % LED off - JW
              pause(1);
            % log stim event
            data(di,:)={cur_t 30}; % trial and cue offset A (left)
            di = di + 1;
        end

        if cur_t>t.abort_trial  % rat didn't poke in time, abort trial
            disp('timeout')
            
            % deactivate nose port and turn off cue light (in case it was in the on state)
            right_active = false;
            t.rcuelight_on = SUPERLONG;
            t.rcuelight_off = SUPERLONG;
            sim.RightPokeCueLamp.Color = [ .5 .5 .5]; % turn off light in case it was in the on state
            writeDigitalPin (m,'D9',0); % LED off - JW
            % start next trial
            tri = tri + 1;  % increment trial counter
            abort_panel.CurrentTrialEditField.Value = tri;
            t.new_trial = cur_t + iti_delays(tri);  % set time for start of next trial

            % log events
            data(di,:)={cur_t 16}; % trial offset and cue offset A (left)
            di = di + 1;
            data(di,:)={cur_t 40}; % indicates trial timeout
            di = di + 1;

        end 
    end

    

    % check for user-requested abort
    if abort_panel.AbortRequested
        disp('abort detected')
        sess_over = true; % this will terminate loop and mean that data cached so far will go to file
     fclose(s);  % close  serial port
    end

    % check for trials exceeded and if so, trigger shut-down
    if tri>num_trials
        disp('trial count reached.  Ending.')
        sess_over = true;
        fclose(s);  % close  serial port
    end

    % if using GUI, this timer turns off stim that has be previously initiated
    % it should not be needed with arduino, because the stim arduino does
    % the stim timing (I think)
    if cur_t>t.stim_off
        sim.StimIndicatorLamp.Color = [.5 .5 .5];
        drawnow;
        t.stim_off = SUPERLONG;
    end

    % reset poke flags and cached states so we can catch and signal next low-high transition
    lpoke_flag = false; 
    rpoke_flag = false;
    prev_lpoke_state = logical(sim.LeftHolePoke); % used logical cast because poke status is numeric, 0 or 1
    prev_rpoke_state = logical(sim.RightHolePoke);
end
 

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate Tone-Light Synchronization Events (end)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for synci=1:3
     writeDigitalPin (m,'D3',1); %%X 
     disp('D3 on');
     sim.BeepLightSyncLamp.Color = [1 0 0];
     data(di,:) = {toc 5};  % sync pulse start event (each beep is individually recorded)
     di = di + 1;
     pause (0.5); % wait 1/3 second
     writeDigitalPin (m,'D3',0); %%X 
     disp('D3 off')
     sim.BeepLightSyncLamp.Color = [.5 .5 .5];
     data(di,:) = {toc 6}; % sync pulse end event
     di = di + 1;
     pause (0.5);
 end

% record session end event
data(di,:) = {toc 2};  % session end event
di = di + 1;

% trim data and write to file
data = data(1:di-1, :);  % delete zero entries before writing
data_rnd = data;
% round to nearest millisecond, anything more is probably not relevant
data_rnd(:,1) = array2table(round(table2array(data_rnd(:,1))*1000)/1000);

% save data file
writetable(data_rnd, path_filename, 'WriteRowNames',false, 'FileType','text', 'WriteMode','append', 'Delimiter',',')

disp('Experiment Over, File Written')

% clean up (close app windows)
close(sim.UIFigure);
close(abort_panel.UIFigure);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Misc Notes:
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UPLOAD "Button_OR_Mat_stim" code to Arduino Uno
% maybe shape by S going to lite nose-poke with sugar pellets - Criteria?

% Uno - pin 9 to stim red and other to GND (black)
%     - Manual - momentary push button pin 11 to Gnd.
% Mega - D3 is start & end beep & lite + GND

% Mega pins for box 2 lite (D8) [GREEN]
% Mega pin to power and read IR switch broken in Box 2 (D5) [GREEN]
% Mega pins for box 3 lite (D9) [YELLOW]
% Mega pin to power and read IR switch broken in Box 3 (D6) [ORANGE]

% IR detectors to Mega board
% Connect transmitter (2 wires) to Ground & +5V
% Connect receiver to GND, +5V from data digital pins 4-5
% RED is + 5 V & BLACK is GND