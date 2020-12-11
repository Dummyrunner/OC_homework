%% exc f)
% init given data
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

[H,f,Aeq,beq] = lqr_ecfh2quadprog(Ad, Bd, Q, R, N,x0);

%  Compute optimum analytically via KKT
Hinv = inv(H);
yopt_ana = Hinv*Aeq'*inv(Aeq*Hinv*Aeq')*beq;

% Compute optimum numerically via quadprog()
[yopt_num, fval_num] = quadprog(H,f,zeros(size(f,1)),zeros(size(f,1),1),Aeq,beq);

% Call plot routine for visualization
plot_excf;