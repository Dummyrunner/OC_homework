figure(30);clf;
for ialpha = 1:length(alphas)
    fig_g = figure(30);
    sgtitle(['Compare traj. for different $Q = \alpha I$ with $\alpha = 0.1,1,10$',newline,'exc g'],'Interpreter','latex');
    
    subplot(3,1,1)
    hold on
    title('State x1 over time, analytical solution')
    plot(0:N,x1{ialpha},'DisplayName',['x1, $\alpha=$',num2str(alphas(ialpha))]);
    hold off
    legend('Interpreter','latex');
    
    subplot(3,1,2)
    hold on
    title('State x2 over time analytical solution')
    plot(0:N,x2{ialpha},'DisplayName',['x2, $\alpha=$',num2str(alphas(ialpha))]);
    hold off
    legend('Interpreter','latex');

    subplot(3,1,3)
    hold on
    title('Input u over time analytical solution')
    plot(0:N-1,u{ialpha},'DisplayName',['u, $\alpha=$',num2str(alphas(ialpha))]);
    hold off
    legend('Interpreter','latex');
end
