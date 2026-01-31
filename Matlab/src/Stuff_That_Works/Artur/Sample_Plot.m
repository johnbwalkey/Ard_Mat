% sample plot - vecot 10 numbers
% A=rand([1,10])
% figure; plot(A)


x=3:10;
y=x+1;
figure; plot(x,y, '.r'); % plots dots instead of line
% can use  + x o d *  etc
% can change color as well (r is red)
% supported colors are red green blue + cmyk + w for white

% plot multiple items in one plot
hold on
y2=x+2
plot(x,y2, '*b')