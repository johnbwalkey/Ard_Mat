%test sinu
clear all
A=5
x=(1:5:1000);
x_cos=cos(x);
x_sin=sin(x*2.2)*2; % can select and right click to evaluate - or hit F9
A=x_cos+x_sin;
figure; plot(x,A);