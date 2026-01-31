% preallocation - Slow

tic
x=zeros (1,1000);
for k=2:1000
    x(k)=x(k-1)+5
end
toc
% Elapsed time is 3.166477 seconds.