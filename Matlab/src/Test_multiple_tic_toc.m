% test variable to tic toc
clear
clc

tic
A = rand(12000,4400);
B = rand(12000,4400);
toc

st=tic
A = rand(12000,4400);
B = rand(12000,4400);
et=toc
lap_time=st-et

st2=tic
A = rand(12000,4400);
B = rand(12000,4400);
et2=toc
lap_time2=st2-et2

%%
clc; clear;
Start_time=tic
	pause (2);
First_interval=toc(Start_time)
    pause (2);
Mid_time=tic
	pause (3);
End_interval=toc(Mid_time)

Total_time=toc(Start_time)
%%
clc; clear;
Start_time=tic
	pause (2);
First_interval=toc(Start_time)
    pause (2);
Mid_time=toc(Start_time)
	pause (3);


Total_time=toc(Start_time)
%%


