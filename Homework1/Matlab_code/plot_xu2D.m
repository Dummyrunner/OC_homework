function [myfigs] = plot_xu2D(y)
%PLOT_XU2D Plots state and control signal trajectories
%   For dyn. systems with 2-dim. state space and scalar steering signal u,
%   State trajectory x and control signal u will be plotted, based on a
%   inserted vector y = (u_0,...u_N-1,x_0,...,x_N).
% 
%   ARGUMENTS
%   y:      Vector filled with state and input vectors as described above

% 11.12.2020, Daniel Bergmann

%  determine time horizon in samples
dimy = length(y);
N = 1/3*(dimy-2);

% extract x and u
x = y(1:N+1); u = y(N+2:end);
% separate coordinates of x
x1 = x(1:2:end);
x2 = x(2:2:end);

fig_states = figure(1); clf;
hold on
subplot(2,2,1)
title('States over time')
plot(x1,'DisplayName','x1')
plot(x2,'DisplayName','x2')
hold off

myfigs = fig_states;
end

