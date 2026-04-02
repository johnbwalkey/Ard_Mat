% Sep 28 Class
clear all
loc=round(rand(1,100)*10); % rand numbers
f=find(loc ==2);% 
nr1=length(f)

nr=[];
for i = 0:10
    f=find(loc == i);
    nr (i+1)=length(f) % need i+1 as no position 0
end

% to compare
j=0:10
figure; plot (j,nr, '*')

return

%% next get user input

% a=input('give value of a  ') % simple eg of input


c= []; % storing number of ookies
for p=1:3
    c(p)=input('give number of cookies ')
end % give numbers and store in vector

% OR

c= []; % storing number of ookies
for p=1:3
    c(p)=input(['give number of cookies by person ' num2str(p) ': '])
end % give numbers and store in vector

% so ['abs' 'xyz') - sequence added 



%% Another input example
c=[];
figure
for i=1:3
    subplot (1,3,i)
    c=input ('Give numb b/n 0-10: ')
    plot (1,1, 'o', 'color', [c/10 c/10 c/10])% max values < 1
end

% Add intensity
c=[];
figure
for i=1:3
    subplot (1,3,i)
    c1=input ('Give numb b/n 0-10 for red: ')
    c2=input ('Give numb b/n 0-10 for green: ')
    c3=input ('Give numb b/n 0-10 for blue: ')
    plot (1,1, 'o', 'color', [c1/10 c2/10 c3/10])% max values < 1
end


%% change every second value from 0 to 1

v= zeros (1,10);
for i=1:2:10
    v(i)=1
end

% practice writing 2 loops
% array with 2 rows and 4 columns

v=zeros(2,4);
for i=1:2
    for j=1:4
    v(i, j)=[i,j]
    end
end


