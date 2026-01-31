x = linspace(-5,5);
% y = linspace(x1,x2) returns a row vector of 100 evenly spaced points between x1 and x2.
% y = linspace(-5,5); Create a vector of 100 evenly spaced points in the interval [-5,5].

y1 = sin(x);
subplot(3,2,1)
plot(x,y1)
title('First subplot')

y2 = sin(2*x);
subplot(3,2,2)
plot(x,y2)
title('Second subplot')

y3 = sin(4*x);
subplot(3,2,3)
plot(x,y3)
title('Third subplot')

y4 = sin(6*x);
subplot(3,2,4)
plot(x,y4)
title('Fourth subplot')

y5 = sin(8*x);
subplot(3,2,5)
plot(x,y5)
title('Fifth subplot')

y6 = sin(10*x);
subplot(3,2,6)
plot(x,y6)
title('Sixth subplot')