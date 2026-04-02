function [out_sum] = class9_func01(init_i, end_i)
% Calculate the sum of integers from init_i and end_i
%   Input parameters
%   init_i:  starting intger
%   end_i:  ending intrger
%
%   Output parameters
%   out_sum:  sum of integers from init_i to end_i

tmp = 0; % initialize a counter
for ii=init_i:end_i % sum from init_i to end_i
    tmp = tmp + ii; % increment the counter by ii
end
out_sum = tmp; % the result is copied to out_sum
end


