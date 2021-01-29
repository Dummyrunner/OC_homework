function [allx, allu] = mpcIteration(Aineq,bineq,Aeq,beq,x0,f0,nonlcon,fmincon_options,mpc_it,N)
%MPCITERATION Executes MPC Iterations
%   Simulate MPC Algorithm vor given system, solve MPC via fmincon

n = length(x0);
m = (size(Aineq,2) - (N+1)*n)/N;

% initialize arrays to store all states/inputs
allx = x0;
allu = [];

z_curr = zeros((N+1)*n + N*m,1);
z_curr(1:n) = x0;

for impc = 1:mpc_it
    % solve MPC Problem, get predicted trajectory
    z_curr = fmincon(f0,z_curr,Aineq,bineq,Aeq,beq,[],[],nonlcon,fmincon_options);
    
    % extract first input
    first_input = z_curr((N+1)*n:(N+1)*n+(m-1));
    
    % Extract new intial state for next MPC iteration
    new_x0 = z_curr(n+1:2*n);
    % Adjust initial state of next iteration
    beq = [new_x0; zeros((N)*n,1)];
    
    % save data to array
    allx = [allx new_x0]; %states
    allu = [allu first_input]; %inputs
end

end

