% test histcounts with sample stim data and my exp 1 data

clear; clc;

load Experiment1
stim.times =Experiment1
edges=[-1000:2:1000]; %Define bin edges
raster=zeros(34, length(edges)-1); %Initialize raster matrix
for j=1 %Loop over all trials
            %Count how times fall in each bin
    raster=histcounts(stim.times,edges);
end
figure %Create figure for plotting
imagesc(raster);  % display matrix as an image with auto scaling
colormap(1-gray) %invert color map so that darker values are higher

% excercise:  try different bin sizes: 2, 5, 20


