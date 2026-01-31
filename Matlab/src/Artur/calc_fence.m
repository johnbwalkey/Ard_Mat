%calc length of fence

clear all
a=[];
b=rand(1,5000)*500
for i=1:length(b)
    x=b(i);
    y=(500-x)/2;
    disp(y);
    a(i) = x*y;
end
[max_a best_x]=max(a)
best_y=(500 - 1*b(best_x))/2
figure; plot (a, '.')