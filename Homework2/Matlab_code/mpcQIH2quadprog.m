function [H,T,Aineq,bineq,Aeq,beq] = mpcQIH2quadprog(Ad,Bd,Q,R,P,delta,N,xt,xnormbound,unormbound)
%MPCQIH2QUADPROG Translates a LQR problem with quasi-infinite time horizon
%into a quadratic program with quadratic an linear constraints.
% 
%   system determined by Ad, Bd with sample time delta and
%   time horizon N, initial state x0 and bounds on the maximum
%   norm of state x and input u. Q,R define the objective that has to be
%   minimized, P characterizes the terminal cost of a MPC problem.
%   T implements the terminal constraints as a quadratic inequality.

n = size(Ad,1);
m = size(Bd,2);

% Build Matrix H
Qs = repmat({Q},N,1);
Rs = repmat({R},N,1);
Qblk = blkdiag(Qs{:});
Rblk = blkdiag(Rs{:});
H = delta.*blkdiag(Qblk,zeros(n),Rblk);

% express box constraints for pred. state and input in inequality constr.
Aineq = [xnormbound.*eye(n*(N+1)) zeros(n*(N+1),m*N);...
         -xnormbound.*eye(n*(N+1)) zeros(n*(N+1),m*N);...
         zeros(m*N,n*(N+1)) unormbound.*eye(m*N);...
         zeros(m*N,n*(N+1)) -unormbound.*eye(m*N)];
bineq = ones(2*(n*(N+1) + m*N),1);

% express system dynamics and init. cond. in equality constr.
Aeqx = kron(eye(N+1),eye(n));
Aeqx(n+1:end,n+1:end) = -1.*Aeqx(n+1:end,n+1:end);
Aeqx = Aeqx + kron(diag(ones(N,1),-1),Ad);
lastrow = zeros(1,N+1); lastrow(end) = 1;
Aeqx = [Aeqx; kron(lastrow,eye(n))];


Aequ = kron(eye(N),Bd);
Aequ = [zeros(n,N*m); Aequ; zeros(n,N*m)];

beq = [xt; zeros((N+1)*n,1)];

Aeq = [Aeqx Aequ];

T = zeros(size(H));
T(N*n+1:N*n+n,N*n+1:N*n+n) = P;

end

