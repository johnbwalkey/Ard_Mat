% break & continue tests in while and for loops
% by jw
% NOTE: break terminates the execution of FOR and WHILE loops.
    % In nested loops, break exits from the innermost loop only.
    % break is not defined outside of a FOR or WHILE loop.
    % Continue passes control to the next iteration of FOR or WHILE loop
    % in which it appears, skipping any remaining statements in the body
    % of the FOR or WHILE loop.
    % Return is used to immediately stop execution of a function 
    % and return a value back to where it was called from. 
    % This means it will break all loops contained in the current function call. 
    % If you want to break out of a single loop 
    % you need to use the break statement instead.

clc; clear

%% test contimue
a=0;
while a<10;
    a=a+1;
        if a ==3; % this is what WILL happen to FPrintF
        continue;
        end

        fprintf('a is %0d \n',a)
end
disp(' this is next line after continue');

pause (5);
%% test break
a=0;
while a<10;
    a=a+1;
     if a ==3;
      break;
     end
        fprintf('a is %0d \n',a)
end
disp(' this is next line after break');

%% test return
a=0;
while a<10;
    a=a+1;
     if a ==3;
      return;
     end
        fprintf('a is %0d \n',a)
end
disp(' this is next line after break');
pause(3);
disp('hello');
