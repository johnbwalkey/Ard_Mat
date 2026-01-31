% Exercise: in vector v change every second value to 1: v = [ 1 0 1 0 1 0 ...

v = zeros(1,10)

% solution using loop
for i = 1:2:length(v)
    v(i) = 1
end

% solution without using loop 
i = 1:2:10
v( i ) = 1;
% or
v( [ 1 3 5 7 9 ] ) = 1;

return


% Exercise: in array with 2 rows and 3 columns, make value at j row and i column equal to i+j
% for example Arr(2,3) should be equal to 2+3 = 5 

% To solve this problem we can start with loop changing values only in 1st row
Arr = zeros(2,3);
for i = 1:3
    Arr( 1, i )  = i;
end

% Now we can expand it by inserting 2nd loop to iterate for other rows 

Arr = zeros(2,3);
for i=1:3 % loop for columns
    for j = 1:2 % loop for rows
        Arr( j, i )  = i + j;
    end
end

Arr


% Here is solution made by student with only 1 loop 
% It works by inserting vector in each row.
Arr = zeros(2,3);
for i=1:2; 
    j=1:3;
    Arr(i,j)= i + j  % here j is a vector
end

return



%-- Getting input from user from keyboard  
a = input('give value for a ')

c = [];
for i=1:3 % at each iteration of loop Matlab will ask to give a number
    
  %  c(i) = input('no of cookies ')
    c(i) = input(['no of cookies for person ' num2str(i) ': '])
end

% Example of loop, subplot and  user input
% Each iteration will plot new subplot with user specified color of point

figure;
for i = 1:3
    subplot( 1,3, i )
    c = input('give number between 0-10 ')
    plot(1,1,'o', 'color', [c/10 c/10 c/10] ) % [ red green blue] define color of point 
    
end

    
    
   




