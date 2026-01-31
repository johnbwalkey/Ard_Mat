% example combine matrix or vector
% Arr1=[2 3 4;4 5 6];
% Arr2=[7 6 5;5 6 7];
% a=[Arr1 Arr2] % combining arrays or vectors

x=1:.1:30;
x_cos=cos(x); % to get bigger vlaues add 1
% hard to see above as data (291 values) so plot it as sinusoid
x_sin=sin(x*2.2)*2; % can select and right click to evaluate - or hit F9
sum_cs=x_cos+x_sin;
figure % could put semicolon after plot and runs on same line
plot(x,sum_cs); % substitute sum_cs to see plot
%% could put all on one line

grid on % adds grid - grid off in Command windows turn off
%can add elements to plot
title('sum of cos and sin')
xlabel ('x values')
ylabel('y values')

% change values
xmin = -1; xmax =40; ymin =-4; ymax =4;
axis([xmin xmax ymin ymax])

return % returns to above