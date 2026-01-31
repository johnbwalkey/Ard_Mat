% this script demonstrates how to generate random intervals with a
% specified average interval length. It also contains sample code that
% could deliver a cue light and stim using these intervals.

% we want an average interval between of 90 seconds between cue onsets
avg_interval = 90;
t = 3600; % 3600 is number of seconds in 2 hours
N = 2*t/(avg_interval); % Number of cues/stims in 2 hours if spaced 90 seconds apart
                        % We will generate this many intervals. This is
                        % twice as many as we are likely to need, but this
                        % over-preparation allows us to pick enough
                        % intervals to cover a 1 hour session without
                        % worrying about running out
              

% set up a stim array with one entry for every second indicating if a cue/stim will 
% presented at that time point
stim_array = rand(2*t,1)<(N/(2*t));

% now find the actual intervals
intervals = diff(find(stim_array));
intervals = intervals(intervals>10 & intervals<205); % this limits extreme
                                                    % values but still
                                                    % gives a mean of
                                                    % roughly 90 seconds. I
                                                    % determined these
                                                    % values through trial
                                                    % and error
histogram(intervals,100)  % checks the distribution of all delays generate

mean(intervals)  % use to verify that the mean is close that what is desired

% Deliver cues and stim with the intervals we've created
% Here, one could replace the disp commands with commands that actually
% deliver stim and cues.  I suggest that we use an 8 second delay between
% cue onset and stim onset.  The cue would remain on until the onset of
% stim delivery.  A quick review of Pavlovian conditioning suggests that a
% 8 second delay between cue and stim coupled with a 90 second inter-trial
% interval will result in strong acquisition of the cue-stim association (see Lattal 1999).
for pl = 1:40  % 40 is 3600/90, so average number of stims expected in an hour
   disp('turn on cue here')
   pause(8) 
   disp('turn on stim here')
   disp('turn off cue here')
   disp(['current delay: ' num2str(intervals(pl))])
   pause(intervals(pl))
   disp(''); 
    
end