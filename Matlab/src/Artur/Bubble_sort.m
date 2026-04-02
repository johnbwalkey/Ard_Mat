% Bubble Sort

clear all
v=randi(10,[1 5])
% sort (v) --- use if statement instead - but sort works

didswap=true;
while(didswap)
   didswap=false;
    for i=l:length(v)-1 % as only 4 sorts for 5 before
        if (v(i) > v(i+1))
            dummy=v(i+1);
            v(i+1)=v(i);
            v(i)=dummy;
        didswap=true;
    end
    end
end


%to get largest: could change the > to < in above - or reverse calc place
fs=flip(sort(v))