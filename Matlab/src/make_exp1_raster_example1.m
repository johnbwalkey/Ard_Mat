% exp1 generate fake data
%
clc
clear

spike_times=randi([50 3000],1,150)';
stim_array=(100:100:3000)';
stim_dur=(100);

% open this code then F9 - then 
% save A_exp1_raster_example1.mat
% load A_exp1_raster example1.mat

% Random Number between a and b >
% Case 1 : ri = randi([a b],1,N)
% Input	r = randi([100 200],1,10)
% Output	r =150   114   142   189   172   103   190   102   196   194

%transpose to column vector