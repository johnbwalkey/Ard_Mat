function handleToA =functionB()
disp('thi is FunctionB. It is a ');
functionA();
handleToA=@()functionA();
end
function functionA()
    disp('this is FunctionA - Local');
end
% another Function eg
% a=[1,2,3,4];
% min(a)
% handleToMin=@(x) min(x);
% handleToMin(a)

