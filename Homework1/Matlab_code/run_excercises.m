
%% init data + exact discretization of system dynamics
Acont = [0 1; 2 1];
Bcont = ones(2,1);
Q= eye(2);
R = 1;

tf = 5;
N = 50;
h = tf/N;
x0 = [-2 3]';

% compute matrices Ad,Bd for exact time-discrete representation of the dynamics
sys_c = ss(Acont,Bcont,eye(2),0);
sys_d = c2d(sys_c,h);
[Ad,Bd,~,~] = ssdata(sys_d);
% comptue matrices for approx. euler discrete representation of the dynamics
Ad_eul =  eye(2) + h.*Acont;
Bd_eul = h.*Bcont; 

%% exc f)
[H,f,Aeq,beq] = lqr_ecfh2quadprog(Ad, Bd, Q, R, N,x0);
[H,f,Aeq_eul,beq_eul] = lqr_ecfh2quadprog(Ad_eul, Bd_eul, Q, R, N,x0);

%  Compute optimum analytically via KKT
Hinv = inv(H);
yopt_ana = Hinv*Aeq'*inv(Aeq*Hinv*Aeq')*beq;

% Compute optimum numerically via quadprog()
[yopt_num, fval_num] = quadprog(H,f,zeros(size(f,1)),zeros(size(f,1),1),Aeq,beq);
[yopt_eul, fval_eul] = quadprog(H,f,zeros(size(f,1)),zeros(size(f,1),1),Aeq_eul,beq_eul);
% Extract trajectories from yopt
ana =  struct;
num =  struct;
eul = struct;
[ana.x1,ana.x2,ana.u] = extract_xu(yopt_ana);
[num.x1,num.x2,num.u] = extract_xu(yopt_num);
[eul.x1,eul.x2,eul.u] = extract_xu(yopt_eul);

% Call plot script for visualization, including save to file
plot_excf;
disp('Exc f) done...')

%% exc g)

alphas = [0.1 1 10];
% yopt = {};
x1 = {};
x2 = {};
u = {};

% compute opt traj. for each alpha
for ialpha = 1:length(alphas)
    Q = alphas(ialpha)*eye(2);
    [H,f,Aeq,beq] = lqr_ecfh2quadprog(Ad, Bd, Q, R, N,x0);
    Hinv = inv(H);
    yopt = Hinv*Aeq'*inv(Aeq*Hinv*Aeq')*beq;
    [x1{ialpha},x2{ialpha},u{ialpha}] = extract_xu(yopt);
end

% plot results for each alpha
figure(30);clf;
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

%% exc h

% Simulate cont' time system over time vector tsamples
tsamples = linspace(0,tf,N+1);
[t_sim,x_cont] = ode45(@(x,t) sys_cont(x,t,Acont,Bcont,num.u,tf,N,h),tsamples,x0,odeset('RelTol',5e-10,'AbsTol',5e-10));


%% end of exc
disp('Excercise script finished successfully')


%% --------------------------------------------------------------------
function dx_cont = sys_cont(t,x,Acont,Bcont,discr_u,tf,N,h)
%   Extracts current input signal from discrete input vector and determines
%   the resulting time derivative of x in the cont. sys.

    discr_u(end+1) = 0; % append zero to input signal (no input in terminal state)
    % function for determining "effective time"
    % u by quadprog is piecewise constant
    %  => u(t1) = u(t2) for all t2 \in [t1,t1+h)
    % u is zero for time out of [0, tf]
    teff = @(t) (t - mod(t,h))*(t>=0 & t<=tf);
    % function for determining according index k of t_k
    time2index = @(time) fix(teff(time)/h) + 1;
    % u_stait(t) evaluates the stair input signal at time t
    % out of [0,tf)
    u_stair = @(time) discr_u(time2index(time))*(1 - (time < 0 & time >= tf));
    
    % compute dynamics
    dx_cont = Acont*x + Bcont*u_stair(t);
end
