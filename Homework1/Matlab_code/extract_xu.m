function [x1,x2,u] = extract_xu(y)
%EXTRACT_XU extract x1, x2, u from solution vector y. state space dim. n=2
%   Detailed explanation goes here
% 11.12.2020, Daniel Bergmann
n=2;

%  determine time horizon in samples
dimy = length(y);
N = 1/3*(dimy-2);

% extract x and u
x = y(1:(N+1)*n); u = y((N+1)*n+1:end);
% separate coordinates of x
x1 = x(1:2:end);
x2 = x(2:2:end);
end

