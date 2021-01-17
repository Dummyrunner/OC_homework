%% Problem 1

%% exc b)
% Init Val. Function with arbitrarily chosen Init. cond.
V0 = zeros(8,1);
alpha = 0.9; % discount factor

% system dynamics given by x_k+1 = f(xk,uk)
f = [2 2 3; ...
    7 5 4;...
    4 6 5;...
    7 8 6;...
    4 4 6;...
    1 7 8;...
    8 8 8;...
    8 8 8];

% Transition Cost f0(x,u=
f0 = [1 1 1;...
    3 6 2;...
    1 2 3;...
    2 6 3;...
    0 0 1;...
    5 1 1;...
    2 2 2;...
    0 0 0];

% Value Function Iteration
V = V0;
n = 1000;
for iter = 1:n
    for istate = 1:8 % iterate over 8 dimensions of statespace
        V(istate) = min([f0(istate,1) + alpha*V(f(istate,1)),...
            f0(istate,2) + alpha* V(f(istate,2) ),...
            f0(istate,3) + alpha*V(f(istate,3)) ]);
    end
end

% display resulting Value function
msg = ['The Value function, obtained by iterating over ',num2str(n),' iterations is',newline,newline,'V='];
disp(msg)
disp(V)

% Optimal feedback u = k(x), s. t. V(f(x,k(x)) minimal
k = zeros(8,1);
for x = 1:8
%     get input signal that minimizes V-Value of next state
    [~,idx] = min( V(f(x,:)));
    idx = idx(1); % in case of >1 minima
%   index shift
    k(x) = idx - 1;
end

msg = 'The Value Function yields the optimal state feedback k: X -> U';
disp(msg)
k

% 
