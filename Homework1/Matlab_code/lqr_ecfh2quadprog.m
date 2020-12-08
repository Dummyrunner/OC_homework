function [H,Aeq,beq] = lqr_ecfh2quadprog(Ad, Bd, Q, R, N, x0)
%LQR_ecfh2quadprog Translates a LQR optimal control Problem with
%time-discrete sys. dyn., finite time horizon
%Ad, Bd and objective det. by N (prediction horizon), Q, R into an quadratic optimal problem
%   Daniel Bergmann, 08.12.2020
n = size(Ad,1); % state space dimension
m = size(Bd,2); % ipnut signal dimension

% Build Matrix H
Qs = repmat({Q},N+1,1);
Rs = repmat({R},N,1);
Qblk = blkdiag(Qs{:});
Rblk = blkdiag(Rs{:});
H = 0.5.*blkdiag(Qblk,Rblk);

% express system dynamics and init. cond. in equality constr.
% matrices applied on x
Aeqx = kron(eye(N+1),eye(n));
Aeqx(n+1:end,n+1:end) = -1.*Aeqx(n+1:end,n+1:end);
Aeqx = Aeqx + kron(diag(ones(N,1),-1),Ad);
lastrow = zeros(1,N+1); lastrow(end) = 1;
Aeqx = [Aeqx; kron(lastrow,eye(n))];
%  matrices applied on u
Aequ = kron(eye(N),Bd);
Aequ = [zeros(n,N*m); Aequ; zeros(n,N*m)];

beq = [x0; zeros((N+1)*n,1)];

Aeq = [Aeqx Aequ];


end

