%-- class 4 

% Excersice: Make arrays Arr= [A B] or Arr = [A;B]

x = 1:0.1:30;    %-- step can also be a fraction
x_cos = cos(  x ) ; 
figure; %-- open figure window
plot( x, x_cos ) %-- make plot

x_cos = cos(  x ) + 1; 
x_sin = sin(  x+1 ) * 2;
sum_cs = x_cos + x_sin;

figure; plot( x, sum_cs ) %-- plot sum of x_cos and x_sin
figure; plot( x, cos(  x ) + 1 + sin(  x+1 ) * 2 )  % it does the same as above but looks less transparent

%-- few useful functions for plotting 
grid on
xlabel('x values')
ylabel('y values')
title('cos')

xmin = -1; xmax = 40; ymin = -4; ymax = 4;
axis([ xmin xmax ymin ymax]) %-- define extend of ploted area 

return

% Excersice: Make vector with 10 random numbers and plot it
    figure;plot( rand(1,10))

clear all

x = 3:10;
y = x+1;
figure;plot( x,y,'.r') %-- plot points as red dots
%-- predefined letters for colors in Matlab: rgbcmyk

figure;plot(  y,'.r') %-- if 'x' is not specified, Matlab assumes that x-values start from 1 

hold on  %-- keep multiple plots in one figure
y2 = x+2;
plot( x, y2, 'g')


return

%-- this array store information about number of cookies eat by 4 people accross 3 days
Arr = [0 2 4 10; 0 3 3 20; 10 5 1 13] 
figure;plot( Arr )

Arr2 = Arr';
figure;plot( Arr2 ) %-- note different display of the same information  


% Excersice: read help on subplot function and create 2 x 3 subplots
%-- subplots 
figure;
subplot( 2,3,1)
plot( Arr )
subplot( 2,3,2)
plot( Arr2 )
subplot( 2,3,6)
plot( Arr2 )

return

