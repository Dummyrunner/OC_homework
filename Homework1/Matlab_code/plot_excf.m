%% generating Plots for excercise f)
ana =  struct;
num =  struct;

[ana.x1,ana.x2,ana.u] = extract_xu(yopt_ana);
[num.x1,num.x2,num.u] = extract_xu(yopt_num);

% Plot all trajectories of num. and ana. sol.

% Plot window measures: % does not work currently
% x = 0; y = 0;
% width = 2000;
% height = 1500;

fig_f1 = figure(1); clf;
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

% Plot Comparison. analytic vs numerical sol.
fig_f2 = figure(2); clf;
sgtitle('Comparison analytic vs. numerical solution')
subplot(3,1,1)
hold on
title('State x1 over time, analytical vs. numerical solution')
plot(ana.x1,'DisplayName','x1_{ana}')
plot(num.x1,'DisplayName','x2_{num}')
hold off
legend;

subplot(3,1,2)
hold on
title('State x1 over time, analytical vs. numerical solution')
plot(ana.x2,'DisplayName','x1_{ana}')
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


