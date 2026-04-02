% Break test

% break Terminate execution of WHILE or FOR loop.
%     break terminates the execution of FOR and WHILE loops.
%     In nested loops, break exits from the innermost loop only.

clc; clear; tic
while toc <=20
   for ii = 1:5 % this loop keeps running
       disp(['Current value of ii = ', num2str(ii)]);
       if ii <=2 % this if gets cancelled
           % execute some for loops
%            for kk=1:3
%               disp('hello');
%               break % exit the if ii loop
%            end
           disp(ii);
           break
       end
   break % here does not stop- loops 20 times 
   end % end here does NOT cancel all below - its just more code
   
 for kk=1:3
  disp('after break');
 end
  % break % here makes just run once !! TO HERE .....otherwise runs 20
end
   disp(toc);
   disp(['for loop was stopped at the moment that ii = ', num2str(ii)]);
