%% generating Plots for excercise f)

% difference between analytic and numeric solution
e = struct;
e.x1 = ana.x1 - num.x1;
e.x2 = ana.x2 - num.x2;
e.u = ana.u - num.u;

eeul = struct;
eeul.x1 = eul.x1 - num.x1;
eeul.x2 = eul.x2 - num.x2;
eeul.u = eul.u - num.u;
% Plot all trajectories of num. and ana. sol.

% Plot window measures: % does not work currently
% x = 0; y = 0;
% width = 2000;
% height = 1500;

%% Plot state and input traj. of opt. solution
fig_f1 = figure(10); clf;
sgtitle(['State and input trajectories of optimal solution (exact discr.)',newline,'exc f)'])
subplot(2,2,1)
hold on
title('States over time analytical solution')
plot(0:N,ana.x1,'DisplayName','x1_{ana}')
plot(0:N,ana.x2,'DisplayName','x2_{ana}')
hold off
legend;

subplot(2,2,2)
hold on
title('States over time numerical solution')
plot(0:N,num.x1,'DisplayName','x1_{num}')
plot(0:N,num.x2,'DisplayName','x2_{num}')
hold off
legend;

subplot(2,2,3)
hold on
title('Input over time numerical solution')
plot(0:N-1,num.u,'DisplayName','u_{num}')
hold off
legend;

subplot(2,2,4)
hold on
title('Input over time analytical solution')
plot(0:N-1,ana.u,'DisplayName','u_{ana}')
hold off
legend;

%% Plot Comparison. analytic vs numerical sol.
fig_f2 = figure(11); clf;
sgtitle(['Analytic vs. numerical solution (exact discr.) vs. numerical euler',newline,'exc f)'])
subplot(3,1,1)
hold on
title('State x1 over time, analytical vs. numerical solution')
plot(0:N,ana.x1,'DisplayName','x1_{ana}')
plot(0:N,num.x1,'DisplayName','x1_{num}')
plot(0:N,eul.x1,'DisplayName','x1_{eul}')
hold off
legend;

subplot(3,1,2)
hold on
title('State x2 over time, analytical vs. numerical solution')
plot(0:N,ana.x2,'DisplayName','x2_{ana}')
plot(0:N,num.x2,'DisplayName','x2_{num}')
plot(0:N,eul.x2,'DisplayName','x2_{eul}')
hold off
legend;

subplot(3,1,3)
hold on
title('Input u over time, analytical vs. numerical solution')
plot(0:N-1,ana.u,'DisplayName','u_{ana}')
plot(0:N-1,num.u,'DisplayName','u_{num}')
plot(0:N-1,eul.u,'DisplayName','u_{eul}')
hold off
legend;

%% Plot error between num. and ana. sol.
fig_f3 = figure(12); clf;
sgtitle(['Difference analytical vs. numerical solution',newline,'exc f)'])
subplot(3,1,1)
hold on
title('State x1 over time, difference between analytical  and  numerical solution')
plot(0:N,e.x1,'DisplayName','error x1')
hold off
legend;

subplot(3,1,2)
hold on
title('State x2 over time, difference between analytical  and numerical solution')
plot(0:N,e.x2,'DisplayName','error x2')
hold off
legend;

subplot(3,1,3)
hold on
title('Input u over time, difference between analytical and  numerical solution')
plot(0:N-1,e.u,'DisplayName','error u')
hold off
legend;
% 
%% Plot error exact discretization and euler approximate discretization
fig_f4 = figure(13); clf;
sgtitle(['Difference between exact- and euler discretization',newline,'exc f)'])
subplot(3,1,1)
hold on
title('State x1 over time, difference between exact- and euler discretization')
plot(0:N,eeul.x1,'DisplayName','error x1')
hold off
legend;

subplot(3,1,2)
hold on
title('State x2 over time, difference exact- and euler discretization')
plot(0:N,eeul.x2,'DisplayName','error x2')
hold off
legend;

subplot(3,1,3)
hold on
title('Input u over time, difference between exact- and euler discretization')
plot(0:N-1,eeul.u,'DisplayName','error u')
hold off
legend;



