%function info
% find value in a(2,2) row-col
% also did - colon, min, max

clear

%calculate distance between A and B
% as 'dist'
A=[3,5];
B=[3,6];
function dist = myDistance(A,B)
for i=1:size(B,1)
    dist(i)=sqrt((A(1,1)-B(i,1))^2 + -(A(1,2)-B(i,2))^2);
end
