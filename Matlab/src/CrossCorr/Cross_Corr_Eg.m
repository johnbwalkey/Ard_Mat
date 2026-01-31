x=rand(1,10);
y=x;
cross1=xcorr(x,y);
% note Worspace values - why 1x119
% in command window type plot (cross1);

% change x rand from 10 to 100
% shift L-R
y=circshift(y,[0 10]);
%  plot(cross1);
cross2=xcorr(x,y);
% plot(cross2);
% find the peak
middle=length(x);
theWindow=middle-20:middle+20;
theMax=max(cross2);
thePeak=find(cross2==theMax)-middle;

theWindow=middle-20:middle+20;

plot(theWindow-middle,cross2);

display(['thePeak is at ' num2str(thePeak)]);


