%% Plot state and input traj. of opt. solution
fig_e = figure(10); clf;
sgtitle(['State traj. and input signals of ',num2str(mpc_it),' MPC Iterations',newline,'exc e)'])
subplot(2,1,1)
hold on
title('State evolution over MPC Iterations')
plot(allx_e(1,:),allx_e(2,:),'DisplayName','state evolution')
scatter(allx_e(1,:),allx_e(2,:),'DisplayName','state samples')
hold off
legend;

subplot(2,1,2)
hold on
title('Applied Inputs')
plot(0:mpc_it-1,allu_e,'DisplayName','Applied Input')

hold off
legend;