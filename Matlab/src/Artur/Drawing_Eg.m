% drawing example
figure;
axis ([-4 4 -1 1]);
hold on
x = -pi:0.01:pi; % create x for 1 period
y = sin(x); % creating y coordinates with sin function

for i = 1:length(y)
    circle = plot (x,(i), y(i), 'o', 'markersize', 10);
    pause(0.01);
    delete (circle);
end