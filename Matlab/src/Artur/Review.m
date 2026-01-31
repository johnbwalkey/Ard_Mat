Arr=[1 2 3 ; 4 5 6]
Arr(2,2)

Arr2 =[1 2 3; 'a' 'b' 'c']

%% str_arr=['this; 'is'; 'that'] % gives error as sizes don't match

cell_arr = {'this'; [1 22 3 4]; 'ar'}
cell_arr(2)
cell_arr (2),(2)
cell_arr(2), +2

% another example
% mean(cell_arr2(:,2))
% v();
% for i= 1:2
%     v(i)=cell_arr2(i,2);
% end
% mean(v)


% Structures - similar to cell arrays
data_str(1).name = 'John'
data_str(1).age=22
data_str(1).week_h=[ 6 7 8 9 ]
data_str(2).name = 'Bill'
data_str(2).age=24
data_str(2).week_h=[ 6 7 1 9 ]

