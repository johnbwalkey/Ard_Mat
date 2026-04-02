%MatLab Basics

% Review areas  of screen - script is an IDE & command is terminal
% right click a command for help on it -or- help command
%Run in script is sequential - Command doe now (ie hit Enter)

% 2-D array is rows and columns - can do way more dimensions

% eg
x=1 % in command - assigns

% to make x a vector
x=[1 2 3];
% 2+D array
 x=[1 2 ; 3 4] % ; separates rows - the columns are amount of data
 
 %loops - loops have index number
 % for i = 1 -colon say to - end -- red wavy line is bad code
 % display is a function to display on screen eg display(arguement)
 % display which x -- display (x(i));
 
 clear
 x=[1 2 3 4]
 for i=1:3
     display(x(i));
 end
 
 
 