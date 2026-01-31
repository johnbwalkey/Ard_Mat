% Summer Computational Neuroscience Workshop 2019
% MATLAB Tutorial #3
% Class 7
% June 10, 2019
% Masami Tatsuno
%
% 3D plot, getting user input from mouse
%
%% Exercise 1
clear;
x = 0:0.1:10;
figure; plot(x, cos(x));

%% Exercise 2
% clear all;
% x = 0:0.1:10;
figure;
for ii=1:9
    subplot(3,3,ii);
    plot(x, cos(ii*x));
end

%% Exercise 3
figure;
for ii=1:9
    subplot(3,3,ii);
    plot(x, sin(ii*x), 'o--', 'Color', [ii/9 1-ii/9 0.5]);
end

%% Extra
x = linspace(0, 10, 10000)';
y = randn(10000,1);
figure; plot(x, y);
figure; plot(x, y, '.');
figure; histogram(y);

%% plot3
t=0:pi/50:10*pi;
st = sin(t);
ct = cos(t);
figure; plot3(st, ct, t)

%% Extra - plot3
figure; plot(ct, st);
axis equal;
axis square;

%% bar3
load count.dat
whos count
figure; bar(count);
figure; bar3(count);

figure; bar(count');
figure; bar3(count');

%% bar3h
figure; bar3h(count);
figure; bar3h(count');

%% mesh
a = 1:3;
[X, Y] = meshgrid(a, a);
X
Y

a = -2:2;
[X, Y] = meshgrid(a, a);
Z = X.*exp(-X.^2 - Y.^2);
figure; mesh(X,Y,Z)
xlabel('x');
ylabel('y');
zlabel('z');

%% Exercise 4
% refine plot
a = -2:0.1:2;
[X, Y] = meshgrid(a, a);
Z = X.*exp(-X.^2 - Y.^2);
figure; mesh(X,Y,Z)
colormap(jet);
xlabel('x'); ylabel('y'); zlabel('z');

% different function
Z = sin(X).*cos(Y);
figure; mesh(X,Y,Z)
colormap(summer);
xlabel('x'); ylabel('y'); zlabel('z');

%% surf
a = -2:0.1:2;
[X, Y] = meshgrid(a, a);
Z = X.*exp(-X.^2 - Y.^2);
figure; surf(X,Y,Z)
xlabel('x'); ylabel('y'); zlabel('z');

%% Try this if you have a curve fitting toolbox
load franke
figure; plot3(x, y, z, '.');
grid on;
xlabel('x'); ylabel('y'); zlabel('z');

f = fit([x, y], z, 'poly23');
figure; plot(f, [x, y], z);


%% ginput
figure;
[x,y]=ginput(1); 
plot(x,y, '+', 'MarkerSize', 10, 'LineWidth', 2);
xlim([0 1]);
ylim([0 1]);

%% Exercise 5
% allow the user to input 5 points

%% Option 1
figure;
[x,y]=ginput(5); plot(x,y, '+', 'MarkerSize', 10, 'Linewidth', 2);
xlim([0 1]);
ylim([0 1]);

%% Option 2
figure;
hold on;
xlim([0 1]);
ylim([0 1]);
for ii=1:5
    % [x(ii),y(ii)]=ginput(1); plot(x(ii),y(ii), '+b', 'MarkerSize', 10, 'LineWidth', 2);
    [x(ii),y(ii)]=ginput(1); plot(x(ii),y(ii), '+', 'MarkerSize', 10, 'LineWidth', 2);
    % without a color specified Matlab uses different colors
end

%% Exercise 6
% allow the user to draw a line that is defined by 2 points

figure;
hold on;
xlim([0 1]);
ylim([0 1]);
[x,y]=ginput(2); plot(x,y, 'LineWidth', 2)


%% Exercise 7
% allow the user to draw 2 lines that are defined by 3 points
clear x y;
figure;
hold on;
xlim([0 1]);
ylim([0 1]);
for ii=1:2
    [x(:,ii),y(:,ii)]=ginput(3); plot(x(:,ii),y(:,ii), 'LineWidth', 2)
end


