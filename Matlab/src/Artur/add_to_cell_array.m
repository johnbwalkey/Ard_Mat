% get data and store in cell array

clc
prompt = 'What is your name? ';
prompt2 = 'What is your age? ';
name = input(prompt,'s');
age = input(prompt2,'s');

data.str(1).name = name
data.str(1).age = age

% then do in a loop - actually need loop for each person