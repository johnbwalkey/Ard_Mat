function [M, edges] = peth_fast(X, Y, binsize, time_before, time_after)
%
%  [M, edges] = peth_fast(X, Y, binsize, time_before, time_after)
%
% Peri-Event-Time Histograms of an array X of timestamps centered at a list of trigger-event timestamps Y
% optimized for fastest performance without using MEX files
% Important:  X must be sorted in ascending order.
% INPUT: 
%  X            .... array of timestamps to be histogrammed (column vector)
%  Y            .... array of trigger-event timestamps around which the histograms will be centered (column vector)
%  binsize      .... binsize (same units as X and Y)  
%  time_before  .... amount of time before the trigger event to count (same units as X and Y) 
%  time_after   .... amount of time after trigger event to count (same units as X and Y)

% OUTPUT:
%  M           ....  histogram values  (1 x nbin vector)  
%                    note that output is the raw counts.  Divide by number of events to get average spikes/bin
%                    If bins are in msec, M *1e3/ (length(Y) .* binsize) gives spikes per second
%  edges           ....  bin edges in same units as X and Y

%  David Euston 2017/11/02  
%

%spike2 = [];  % make sure spike array is empty
spike2 = zeros(1,length(X));  % not perfect but good guess, will reduce memory allocation delays
                              % with large number of events, spike2 could
                              % be much larger than original spike array
count_before = time_before; % ms
count_after = time_after;  % ms

start_i = 1;

for ii = 1:length(Y)  % cycle through each event
    
    % specify start and end of trial using parameters above
    start_count = Y(ii)-count_before;  
    end_count = Y(ii)+count_after;

    % create an index which will select the spikes for this trial
    include_i = BinaryIntervalSearch(X, mean([start_count end_count]), (end_count - start_count)/2  );
    
    % now get the spikes, subtract off stim time and store in grand array
    %spike2 = [spike2; X(include_i) - Y(ii)];
    
    end_i = start_i + length(include_i)-1;
    spike2(start_i:end_i) = X(include_i)- Y(ii);
    
    start_i = end_i + 1;
    
end;
spike2 = spike2(1:end_i); % trim off extra zeros added at beginning that were never replaced with values

edges=[-1*time_before:binsize:time_after]; %Define bin edges
M = histcounts(spike2, edges);

if nargout == 0
    plot(edges(1:end-1), M);
    xlabel('time');
    ylabel('mean spikes/bin')
end;

return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BINARY INTERVAL SEARCH SUPPORT FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % indexes: indexes of elements of x which lie within the interval 
% % [ref-tol ref+tol]
% % If ref is not found in x then indexes is empty.
% %
% % Revisions:
% % 14-jun-2010: - Added lines 38-55 in order to consider the case in which lower bound 
% %                is less than the minimum value of x or the upper bound is more than 
% %                the max value of x 
% %              - Reinforced the conditions in line 93 and in line 117 in order to avoid 
% %                an error when (to-1)==0 or (from+1)>length(x)
% % 15/apr/2011: - A bug with uint values of input array has been fixed. 
% %                Thanks to Igor Varfolomeev

% % % --------------------------------
% % % Author: Dr. Roberto Olmi
% % % Email : robertoolmi at gmail.com
% % % --------------------------------

function indexes = BinaryIntervalSearch(x,ref,tol,varargin)
lbound = ref-tol;
ubound = ref+tol;
from=1;
to=length(x);

if lbound <= x(1)
    if ubound < x(1)
        indexes=[];
        return
    end
    lindex=1;
else
    lindex=0;
end
if ubound >= x(end)
    if lbound > x(end)
        indexes=[];
        return
    end
    uindex=length(x);
else
    uindex=0;
end

go=uindex==0 || lindex==0;
while go
    mid = ceil(from+(to-from)/2);
    %diff = x(mid)-ref;  15/apr/2011
    if x(mid) < ref %diff < 0  15/apr/2011
        if x(mid) >= lbound
            go=false;
        else
            from=mid+1;
            if x(from) >= lbound
                lindex=from;
                go=false;
            end
        end
    else       % x(mid) > ref
        if x(mid) <= ubound
            go=false;
        else
            to=mid-1;
            if x(to) <= ubound
                uindex=to;
                go=false;
            end
        end
    end
end

%remove this if at least one element of x is always in the interval:
if (lindex > 0 && x(lindex) > ubound)...
        || (uindex > 0 && x(uindex) < lbound)
    indexes=[];
    return
end

%search upper index
cfrom=from;
if from==length(x) || x(from+1) > ubound
    uindex=from;
end
if nargin == 4
    to=min([to mid+varargin{1}]);
end
while uindex == 0
    mid = ceil(from+(to-from)/2);
    if x(mid) <= ubound
        from=mid+1;
        if x(from) > ubound 
            uindex=mid;
        end
    else 
        to=mid-1;
        if x(to) < ubound
            uindex=to;
        end
    end
end

%search lower index
from=cfrom;
to=uindex; 
if to==1 || x(to-1) < lbound
    lindex=to;
end
if nargin == 4
    from=max([from uindex-varargin{1}]); 
end
while lindex == 0
    mid = ceil(from+(to-from)/2);
    if x(mid) < lbound
        from=mid+1;
        if x(from) > lbound
            lindex=from;
        end
    else 
        to=mid-1;
        if x(to) < lbound
            lindex=mid;
        end
    end
end

indexes=lindex:uindex;

% % --------------------------------------------
% % Example code for Testing
% % tol=2;
% % ref=12;
% % maxi=10000;
% % numel=1000;
% % for i=1:maxi
% %     x = sort(randint(1,numel,[0,400]));
% %     indexes = BinaryIntervalSearch(x,ref,tol);
% %     if isempty (indexes)
% %         if any(abs(x-ref) < tol)
% %             disp('Doh!')
% %             break
% %         else
% %             continue
% %         end
% %     end
% %     if indexes(1)>1 && ~(x(indexes(1)-1) < x(indexes(1)))...
% %             || indexes(end)<numel && ~(x(indexes(end)) < x(indexes(end)+1))...
% %             || any(abs(x(indexes)-ref) > tol)
% %         disp('Doh!')
% %         break
% %     end
% %     if i==maxi
% %         disp('OK!!!')
% %     end
% % end
% % --------------------------------------------

% % % --------------------------------
% % % Author: Dr. Roberto Olmi
% % % Email : robertoolmi at gmail.com
% % % --------------------------------

