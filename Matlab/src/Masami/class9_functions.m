% Summer Computational Neuroscience Workshop 2019
% MATLAB Tutorial #3
% June 10, 2019
% Class 9
% Masami Tatsuno
%
% scripts and functions


%% function handles
fh = @cos
fh(0)
fh(pi/2)
fh([0 pi/2 pi])
cos([0 pi/2 pi])

feval(fh, 0)
feval(fh, pi/2)
feval(fh, [0 pi/2 pi])
cos([0 pi/2 pi])

figure; fplot(fh, [0, pi])

%% Exercise 1
fh2 = @class9_func01

fh2(1, 100)
feval(fh2, 1, 100)

integral(fh, 0, pi/2)
integral(fh, 0, pi)

%% declare your own function
q=@(x) x.^2 - 2.*x + 1;
integral(q, 0, 1)
figure; fplot(q, [-2 2])
