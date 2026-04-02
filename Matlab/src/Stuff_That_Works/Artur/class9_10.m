

figure; %display
title('Click on Target')
hold on 
axis([0 1 0 1])
xlim([0 1])
ylim([0 1])
ERR=0.02;
timerVal=tic

for i = 1:6
    x=rand(1);
    y=rand(1);
    d=10;
    plot(x,y,'or')
    while d>ERR
        [xu, yu]=ginput(1);
        d=sqrt((xu-x)^2 + (yu-y)^2);
      %  if d < ERR
            plot(xu, yu,'+')
      %  end
    end
end


    
return
%-- Other solution ---

figure; hold on
title('Click on Target')
axis([0 1 0 1])
x = rand(1,6);
y = rand(1,6);
err_marg = 0.02;
i = 1;
while i <= 6    
    plot(x(i),y(i),'o')    
    [x2 y2] = ginput(1);
    plot( x2, y2, '+')
    
    dist = sqrt((x(i)-x2)^2 + (y(i)-y2)^2);
 %   hit = dist <= err_marg;  
    if dist<= err_marg;
        hit = 1;
        i = i+1;
    else
        hit = 0;
    end
    %hit ==1  inside ; hit = 0; 
    
end 

return

%-- Our code before adding While loop 
figure; hold on
title('Click on Target')
axis([0 1 0 1])
x = rand(1,6);
y = rand(1,6);
err_marg = 0.02;

for i = 1:6    
    plot(x(i),y(i),'o')    
    [x2 y2] = ginput(1);
    plot( x2, y2, '+')
    
    dist = sqrt((x(i)-x2)^2 + (y(i)-y2)^2);
 %   hit = dist <= err_marg;  
    if dist<= err_marg;
        hit = 1;        
    else
        hit = 0;
    end
    %hit ==1  inside ; hit = 0; 
    
end 