
%% init data + exact discretization of system dynamics
Acont = [0 1; 2 1];
Bcont = ones(2,1);
Q= eye(2);
R = 1;

tf = 5;
N = 50;

h = tf/N;
x0 = [-2 3]';

% compute matrices Ad,Bd for time-discrete representation of the dynamics
sys_c = ss(Acont,Bcont,eye(2),0);
sys_d = c2d(sys_c,h);
[Ad,Bd,~,~] = ssdata(sys_d);


%% exc f)
[H,f,Aeq,beq] = lqr_ecfh2quadprog(Ad, Bd, Q, R, N,x0);

%  Compute optimum analytically via KKT
Hinv = inv(H);
yopt_ana = Hinv*Aeq'*inv(Aeq*Hinv*Aeq')*beq;

% Compute optimum numerically via quadprog()
[yopt_num, fval_num] = quadprog(H,f,zeros(size(f,1)),zeros(size(f,1),1),Aeq,beq);

% Extract trajectories from yopt
ana =  struct;
num =  struct;
[ana.x1,ana.x2,ana.u] = extract_xu(yopt_ana);
[num.x1,num.x2,num.u] = extract_xu(yopt_num);

% Call plot script for visualization, including save to file
plot_excf;
disp('Exc f) done...')

%% exc g)

alphas = [0.1 1 10];
% yopt = {};
x1 = {};
x2 = {};
u = {};

% prepare figure
figure(3);clf;

% compute opt traj. for each alpha
for ialpha = 1:length(alphas)
    Q = alphas(ialpha)*eye(2);
    [H,f,Aeq,beq] = lqr_ecfh2quadprog(Ad, Bd, Q, R, N,x0);
    Hinv = inv(H);
    yopt = Hinv*Aeq'*inv(Aeq*Hinv*Aeq')*beq;
    [x1{ialpha},x2{ialpha},u{ialpha}] = extract_xu(yopt);
end

% plot results for each alpha
for ialpha = 1:length(alphas)
    fig_g = figure(30);
    sgtitle('Compare traj. for different $Q = \alpha I$ with $\alpha = 0.1,1,10$','Interpreter','latex');
    
    subplot(3,1,1)
    hold on
    title('State x1 over time, analytical solution')
    plot(x1{ialpha},'DisplayName',['x1, $\alpha=$',num2str(alphas(ialpha))]);
    hold off
    legend('Interpreter','latex');
    
    subplot(3,1,2)
    hold on
    title('State x2 over time analytical solution')
    plot(x2{ialpha},'DisplayName',['x2, $\alpha=$',num2str(alphas(ialpha))]);
    hold off
    legend('Interpreter','latex');

    subplot(3,1,3)
    hold on
    title('Input u over time analytical solution')
    plot(u{ialpha},'DisplayName',['u, $\alpha=$',num2str(alphas(ialpha))]);
    hold off
    legend('Interpreter','latex');
end

saveas(fig_g, '..\plots\exc_g.pdf');
disp('Generated plots saved to file')

disp('Exc g) done...')
disp('Excercise script finished successfully')



