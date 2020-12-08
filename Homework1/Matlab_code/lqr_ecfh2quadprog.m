function [H,Aeq,beq] = lqr_ecfh2quadprog(Ad, Bd, Q, R, N)
%LQR_ecfh2quadprog Translates a LQR optimal control Problem with time-discrete sys. dyn.
%Ad, Bd and objective det. by N (prediction horizon), Q, R into an quadratic optimal problem
%   Daniel Bergmann, 08.12.2020
n = size(Ad,1);
m = size(Bd,2);

% Build Matrix H
Qs = repmat({Q},N,1);
Rs = repmat({R},N-1,1);
Qblk = blkdiag(Qs{:});
Rblk = blkdiag(Rs{:});
H = delta.*blkdiag(Qblk,Rblk);




end

