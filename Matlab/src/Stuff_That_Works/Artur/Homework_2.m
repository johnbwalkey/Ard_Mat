%% Home Work 2 - from John Walkey
clear all
clc
% 1. Answer questions 2-9 in a single .m file that can be run as a script.
% Please add your name at the end of file name to avoid accidental mistakes
% with assigning grades to incorrect person.

% 2.  Create array Arr with 5 rows and 4 columns with each element = 5
Arr=ones(5,4)*5
pause(3);

% 3.  Change all elements in 2nd column to 3
Arr(:,2)=3
pause(3);

% 4.  Change consecutive elements in 4th column to 4, 8, 12, 16 and 20 
Arr(:,4)=(4:4:20)
pause (3);

% 5.  Find indices of elements in Arr bigger than  5
find(Arr>5)
pause (3);

% 6. Plot 5 periods of cosine 
x=1:2:10;
figure;
plot (cos(x))
pause (3);

% 7. Check Matlab help for ‘text’ command and use it to display ‘it is cosine’ in middle of figure
t = text(3,0,'it is cosine');
s = t.FontSize;
t.FontSize = 12;
pause (3);

% 8. Plot histogram of the cosine you plotted
x=1:2:10;
figure;
hist (cos(x))
pause (3);

% 9.  Plot histogram of Arr
figure;
hist (Arr)
pause (3);

% 10. Write loop to find elements in Arr bigger than  5 . 
for test=1:1
    find(Arr>5)
end
pause (3);

disp('Thank you')

% John Walkey (john.walkey@uleth.ca)