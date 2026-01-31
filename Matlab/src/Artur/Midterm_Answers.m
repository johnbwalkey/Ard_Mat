% Review Midterm
%Q1
arr1=rand(9,8)*2-1
arr1=arr1-0.5
figure
surf(arr1)

%Q2
Arr2=zeros(3,2);
for i=1:3
    forj=1:2
    Arr2(i,j) = input('Please input values Arr2: ')
    while (Arr2(i,j)<0)Arr2(i,j)>10)
        Arr2(i,j) = input('Input values between 0 and 10')
    end
end
end

% Q3
x=4:22
y=-19:-1
z=2*x -x .* y
matrix=[x' y' z']


% Q4
img= imread('http://people.uleth.ca/~luczak/Matlab2015/brain_im.jpg')
imshow(img)
img2=zeros(size(img))
for i=1:size(img,2)
    img2(:,i, :)=img(:, size(img,2) -i +1, :);
end
imshow (unit8(img2))

for i=1:size(img, 1)
    img(i, i, :) = [0, 0 ,0;
end
imshow (unit8(img2))

%Q5
figure;
rectangle ('Position', [2 3 3 7]);
axis ([-5 15 -3 16]);

% Q6
cont=1
numOutside=0;
rectangle ('Position', [2 3 3 7]);
axis ([-5 15 -3 16]);
[x y]=ginput();
while(cont)
[x y]=ginput();
if (x>2 && x <5 && y<10 && y>3)
    plot (x, y, '+b');
else
    plot (x, y, 'or');
if (numOutside==3)
        break;
    end
end

        
