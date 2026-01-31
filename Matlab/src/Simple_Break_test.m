% simple break test

clc; clear;
tic
a = false;
while toc<=5
for ii = 1:5;
  disp('hello world');
  if ii==2;
     % a; % don't really need this
     % break - gives 4 lines out because loop
  end
  disp('It''s Thursday!');
  break % get 3 lines out
end
   disp(['for loop was stopped at the moment that ii = ', num2str(ii)])
   break
end
disp('end of while');
