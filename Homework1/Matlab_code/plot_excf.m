%% generating Plots for excercise f)
ana =  struct;
num =  struct;

[ana.x1,ana.x2,ana.u] = extract_xu(yopt_ana);
[num.x1,num.x2,num.u] = extract_xu(yopt_num);

% difference between analytic and numeric solution
e = struct;
e.x1 = ana.x1 - num.x1;
e.x2 = ana.x2 - num.x2;
e.u = ana.u - num.u;
% Plot all trajectories of num. and ana. sol.

% Plot window measures: % does not work currently
% x = 0; y = 0;
% width = 2000;
% height = 1500;

%% Plot state and input traj. of opt. solution
fig_f1 = figure(10); clf;
sgtitle('State and input trajectories of optimal solution')
subplot(2,2,1)
hold on
title('States over time analytical solution')
plot(ana.x1,'DisplayName','x1_{ana}')
plot(ana.x2,'DisplayName','x2_{ana}')
hold off
legend;

subplot(2,2,2)
hold on
title('States over time numerical solution')
plot(num.x1,'DisplayName','x1_{num}')
plot(num.x2,'DisplayName','x2_{num}')
hold off
legend;

subplot(2,2,3)
hold on
title('Input over time numerical solution')
plot(num.u,'DisplayName','u_{num}')
hold off
legend;

subplot(2,2,4)
hold on
title('Input over time analytical solution')
plot(ana.u,'DisplayName','u_{ana}')
hold off
legend;

%% Plot Comparison. analytic vs numerical sol.
fig_f2 = figure(11); clf;
sgtitle('Comparison analytic vs. numerical solution')
subplot(3,1,1)
hold on
title('State x1 over time, analytical vs. numerical solution')
plot(ana.x1,'DisplayName','x1_{ana}')
plot(num.x1,'DisplayName','x1_{num}')
hold off
legend;

subplot(3,1,2)
hold on
title('State x1 over time, analytical vs. numerical solution')
plot(ana.x2,'DisplayName','x2_{ana}')
plot(num.x2,'DisplayName','x2_{num}')
hold off
legend;

subplot(3,1,3)
hold on
title('Input u over time, analytical vs. numerical solution')
plot(ana.u,'DisplayName','u_{ana}')
plot(num.u,'DisplayName','u_{num}')
hold off
legend;

%% Plot error between num. and ana. sol.
fig_f3 = figure(12); clf;
sgtitle('Difference between analytical  analytic vs. numerical solution')
subplot(3,1,1)
hold on
title('State x1 over time, difference between analytical  analytical and  numerical solution')
plot(e.x1,'DisplayName','error x1')
hold off
legend;

subplot(3,1,2)
hold on
title('State x1 over time, difference between analytical  analytical and numerical solution')
plot(e.x2,'DisplayName','error x2')
hold off
legend;

subplot(3,1,3)
hold on
title('Input u over time, difference between analytical and  numerical solution')
plot(e.u,'DisplayName','error u')
hold off
legend;

%% Save plots to file
saveas(fig_f1, '..\plots\exc_f1.pdf')
saveas(fig_f2, '..\plots\exc_f2.pdf')
saveas(fig_f3, '..\plots\exc_f3.pdf')
disp('Generated plots saved to file')

