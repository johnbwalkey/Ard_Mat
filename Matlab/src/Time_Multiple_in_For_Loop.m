% Take Measurements Using Multiple tic Calls
% Use a pair of tic and toc calls to report the total time required 
% for element-by-element matrix multiplication; 
% use another pair to report the total runtime of your program.

clear
clc

tStart = tic;           % pair 2: tic

T = zeros(1,3);
for i = 1:3
    A = rand(12000,4400);
    B = rand(12000,4400);
    tic         % pair 1: tic
    C = A.*B;
    T(i)= toc;  % pair 1: toc
end
tMul = sum(T)
tEnd = toc(tStart)      % pair 2: toc
% tMul includes the total time spent on multiplication. 
% tEnd specifies the elapsed time since the call to the tic function at the beginning of the program.

% Tips
% Consecutive calls to the tic function overwrite the internally recorded starting time.
% The clear function does not reset the starting time recorded by a tic function call.