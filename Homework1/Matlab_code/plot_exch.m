fig_h = figure(40); clf;
% sgtitle('Difference between exact- and euler discretization')
% subplot(4,1,1)
% hold on
% title('Difference Simulated system with piecewise const. input vs. obtained traj. from quadprog ')
% plot(x_sim(:,1),'DisplayName','x1_{sim}')
% plot(num.x1,'DisplayName','x1_{quadprog}');
% hold off
% legend;

subplot(2,1,1)
hold on
title('Difference Simulated state x1 vs. traj. obtained from quadprog() ')
plot(0:N,num.x1 - x_sim(:,1),'DisplayName','error x1_{quadprog} - x1_{sim}')
hold off
legend;

subplot(2,1,2)
hold on
title('Difference Simulated state x2 const. input vs. traj. obtained from quadprog ')
plot(0:N,num.x2 - x_sim(:,2),'DisplayName','error x2_{quadprog} - x2_{sim}')
hold off
legend;