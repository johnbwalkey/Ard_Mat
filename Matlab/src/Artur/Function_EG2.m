function prediction = nearestN(meas, species, newMeas)

for i=1:size(newMeas,1)
    distances = myDistance (newMeas(i:1), meas);
[~,indexOfClosestFlower]=min(distances);
prediction(i)=species(indexOfClosestFlower);
end

% in command window - meas species 

return
function dist = myDistance(A,B)
%function [ output_args ] = Untitled2( input_args )
%calculate distance between A and B
% as 'dist'
clear
clc

A=[3,5];
B=[3,6];

for i=1:size(B,1)
    dist(i)=sqrt((A(1,1)-B(i,1))^2 + -(A(1,2)-B(i,2))^2);
end

end

