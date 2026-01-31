% Midterm Neuro 3690 - John Walkey

%Question 1
Arr1=rand(8,9);
a=(Arr1);
if a>=.5
    a=1;
if a<=.4
    a=-1;
end
end
Arr1=Arr1(-5);
plot3 (Arr1)
    

% Question 2
clc
for i=1:3
a(i)= input ('Please enter a number between 1 and 10');
    if i >10 or <1
        disp ('please enter a value between 1 and 10')
    end
 for ii=1:2
  b(ii)= input ('Please enter a number between 1 and 10');
    if i >10 or <1
        disp ('please enter a value between 1 and 10')
    end   
 end
end
Arr2=(a(i));(b(ii))


% question 3

n=1;
x=4:22;
y=-19:-1;
n=2*x(n)-x(n)*y(n);
Arr3=(x y n;:);
mean(x,:); mean (y,:); mean(n,:);

% Question 4
x= imread('http://people.uleth.ca/~luczak/Matlab2015/brain_im.jpg')
b=x(:,:,0);
for loop=1:b
    if x >1
        x(0,0)
    end
end
imshow(b)


