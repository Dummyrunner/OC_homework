function [u_next] = mpcIteration(Aineq,bineq,Aeq,beq,x0,f0,nonlcon,N)
%MPCITERATION Compute MPC control siganl via Convex Optimization
%   

% Set options for fmincon
fmincon_options = optimset('Display','off'); % suppress text output of fmincon

n = length(x0);
m = (size(Aineq,2) - (N+1)*n)/N;

z_curr = zeros((N+1)*n + N*m,1);
z_curr(1:n) = x0;

% solve MPC Problem, get predicted trajectory
[z_curr,fval,exitflag,output] = fmincon(f0,z_curr,Aineq,bineq,Aeq,beq,[],[],nonlcon,fmincon_options);
if exitflag == 0
    msg = ['MPC Optimization via fmincon did not succeed!'];
    disp(msg);
end
% extract first input
u_next = z_curr((N+1)*n+1:(N+1)*n+m);

end


