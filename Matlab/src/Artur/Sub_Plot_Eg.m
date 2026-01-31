% sub plot example
% read help to learn to do sub plot

% sin - sum sc
% Array - arry transposed
% Rand - Rand  1

% define x
x=1:.1:30;
x_cos=cos(x);
x_sin=sin(x*2.2)*2;
sum_cs=x_cos+x_sin;

figure % create new figure
subplot(2,2,1) % first subplot
plot(x,sum_cs)
title('First subplot')

y2 = sin(2*x); % define y2

subplot(2,2,2) % second subplot
plot(x,y2)
title('Second subplot')

y3 = sin(4*x); % define y3
y4 = sin(6*x); % define y4

subplot(2,2,3) % third subplot
plot(x,y3)
title('Third subplot')

subplot(2,2,4) % fourth subplot
plot(x,y4)
title('Fourth subplot')

subplot(2,2,3)
xlabel('x-axis')
ylabel('y-axis')