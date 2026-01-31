
% Exercise: plot horizontal  and vertical lines
    x = [ 1 1 ];
    y = [ 1 2 ];
    figure;plot( x,y); hold on
    x = [ 1 2 ];
    y = [ 1 1 ];
    plot( x,y);
    axis([ 0 3 0 6])

return

v = [ 3 3 3 4 4 5 5 5 5 6];
figure; hist( v ) %-- plot histogram

return

r = round( rand(1,1000)*10 )
figure;hist( r, 20 )
figure;plot( r, '.')

figure; bar([ 2 3 6]) %-- plot bar plot

return

%-- FOR loop

i = 10; 
for j = 1:3
  j
%  i = j*2        
end

% Exercise: 6 subplots using loop 

figure
for i=1:6
  subplot( 2,3, i )
  plot( rand(1,10))
end



return 

% loops can be combined 
for d = 20:22
    
    for z = 1:3
        [ d z]   
        
    end
end


return


% WHILE loop
i = 1;
while i < 5   % -- execute loop as long as i<5
    d = 10;
    i = i + 2   %- without changing 'i' this loop would be infinite
        
end

% NOTE: You can stop Matlab program by Ctrl+C


return

% IF ELSE statement
r = rand * 10
i = 1;
if r > 5
    disp('r is bigger than 5')
    i = 10    
else
    disp('r is smaller than 5')
    i = -10
end

%  IF statements can be combined
if r > 5
    disp('r is bigger than 5')
    i = 10
    if r >9  % 2nd IF statement
        i = 9;
    end    
else
    disp('r is smaller than 5')
    i = -10
end


return 

% Exercise: generate 100 random numbers between 0 and 10
% and count how many 0s, 1s, 2s ... are there

clear all

loc = round(rand(1,100)*10); %-- ramdom numbers
for i = 1:10
    
    f = find( loc == i );
    nr_times(i) = length( f );
    
end

figure;plot( nr_times)



return











