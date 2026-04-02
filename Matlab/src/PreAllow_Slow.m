% preallocation - Slow

tic
x=0;
y=0;
for k=1:10
    x(k)=y
    fprintf 'y'
    
end
toc
% Elapsed time is 3.166477 seconds.