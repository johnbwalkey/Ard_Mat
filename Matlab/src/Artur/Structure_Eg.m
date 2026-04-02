% structure example
clc
str.a=1;
str.b=2;
str.name='ali';
str
fn=('test_save_mat');
save (fn, 'str');
% clear all
load (fn, 'str');
str
