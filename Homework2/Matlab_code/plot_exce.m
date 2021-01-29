%% Plot state and input traj. of opt. solution
fig_f1 = figure(10); clf;
sgtitle(['State and input trajectories of optimal solution',newline,'exc e)'])
subplot(2,1,1)
hold on
title('State evolution over MPC Iterations')
plot(allx(1,:),allx(2,:),'DisplayName','state')
hold off
legend;

subplot(2,2,2)
hold on
title('Applied Inputs')
plot(1:mpc_it,allu,'DisplayName','Applied Input')

hold off
legend;