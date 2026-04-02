% exercise
r=round(rand(1,100)*10)
% count how many of specific number in vector
f=find(r==1)
disp(f)
length (f)
% so do loop to get all numbers



return
%conditional statement
clc
clear all
r=rand *10
if r>5
    disp('r is bigger than 5')
else
    disp('r is less than 5')
end

return

% so with loops - for is some number of times and while is where criteria
% is met

%working bottom up examples - another loop
i=1;
while i<5
    i=i+1
end

return



%another loop
clear
for i=20:22
    for j=1:3;
        [i j]
    end
end

return
clear all
% loop example

 figure;
for i=1:6
   subplot(2,3,i); plot(rand(1,10));
    
end

