% Homework Assignment # 3 - from John Walkey

%1. Write a loop which will be increasing variable i by 5 at each iteration till i reaches 50. Initial value of i is 12.
clear all
for i= 12:5:50
    i
end

%2. Modify the above loop in such way that i will be increasing only by 3 after i exceeds 31.
for i= 12:5:50
    if i >= 31
        i = i:3:50
    end
end

%3. Make 1 figure with 2 plots in 1 row. First plot will be empty, and second plot will contain bar plot of all values of i for the above iterations. Tip: create additional variable v which will 'remember'  values of i from each iteration.
clear all
for i= 12:5:50
    if i>= 31
        i=i:3:50
    end
end
v=0
v=i
figure % create new figure
subplot(1,2,1) % first subplot
title('First subplot')
subplot(1,2,2) % second subplot
title('Second subplot')
bar (v)

%4. Check if any element of v is not a number
TF = isnan(v)

%5. Calculate average v
m= mean(v)

%6. Modify the above loop in such a way that Matlab will ask you to specify in the command window the initial value of i.
v = input('What do u want initial value of i to be? : ')
for i= v:5:50
    if i>= 31
        i=i:3:50
    end
end

%7. Make an interactive plot which will allow you to draw a continuous line with 3 segments
clear all;clc
figure(1); hold on; grid on; axis([0 10 0 10]);
x = 0;
y = 0;
button = 1;
i = 0;
while button == 1;
[xg,yg,button] = ginput(1);
i = i+1;
x(i) = xg; y(i)= yg;
plot(x(i),y(i),'ro','linewidth',2)
drawnow
if i > 1
    plot([x(i-1) x(i)],[y(i-1) y(i)],'b','linewidth',2)
    plot(x(i),y(i),'ro','linewidth',2)
    plot(x(i-1),y(i-1),'ro','linewidth',2)
    drawnow
end
end

%8. Save vector v=[ 1 2 90] to Excel file
filename = 'excel_file_V_vector.xlsx';
v=[ 1 2 90]
xlswrite(filename,v)

%9. Make 3 dimensional plot to display Arr
Arr1=rand(10)*10
Arr2=rand(10)*10
Arr3=rand(10)*10
plot3(Arr1, Arr2, Arr3)

%10. Display histogram of red channel intensities from image: http://people.uleth.ca/~luczak/Matlab2015/brain_im.jpg
X=imread('brain_im.jpg');
R = X(:,:,1);
image(R), colormap([[0:1/255:1]', zeros(256,1), zeros(256,1)]), colorbar;
figure; hist (colormap)
