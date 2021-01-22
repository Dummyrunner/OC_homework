%% Problem 

% Init Val. Function with arbitrarily chosen Init. cond.
V0 = zeros(8,1);
alpha = 0.9; % discount factor
n = 8; % amount of possible states
m = 3; % amount of possible inputs in each state

%% exc b)


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
it = 1000;
for iter = 1:it
    for istate = 1:n % iterate over 8 dimensions of statespace
        V(istate) = min([f0(istate,1) + alpha*V(f(istate,1)),...
            f0(istate,2) + alpha* V(f(istate,2) ),...
            f0(istate,3) + alpha*V(f(istate,3)) ]);
    end
end

% display resulting Value function
msg = ['The Value function, obtained by iterating over ',num2str(n),' iterations is',newline,newline,'V='];
disp(msg)
disp(V')

% Optimal feedback u = k(x), s. t. V(f(x,k(x)) minimal
k = zeros(1,n);
for x = 1:n
%     get input signal that minimizes V-Value of next state
    [~,idx] = min( V(f(x,:)));
    idx = idx(1); % in case of >1 minima
%   index shift
    k(x) = idx - 1;
end

msg = 'The Value Function yields the optimal state feedback k: X -> U';
disp(msg)
k

% Compute corresponding optimal Feedback
x0 = 1;

x = x0;
cnt = 1;
opt_idx = [];
uopt = [];

while x ~= 8
    uopt(cnt) = k(x);
    x = f(x,k(x)+1);   
    cnt = cnt+1;
end

msg = 'Input signal sequence, determined by statefeedback k';
disp(msg)
uopt

%% exc f)

% Construct matrices for formulating ineq. constrainst of the LP as AV <= b
c = -ones(8,1);
Aineq = zeros(n*m,n);
b = zeros(n*m,1);
for istate = 1:n % iterate over states
    for input = 0:m-1 % scalar inequality expression for each pair state/input
        shift = (istate-1)*m;
        line = shift + input+1;
        % Set entries in matrix A in line "line"
        Aineq(line,istate) = 1;
        Aineq(line,f(istate,input+1)) = Aineq(line,f(istate,input+1)) - alpha;git 
        % set entry of vector b in line "line"
        b(line) = f0(istate,input+1);
    end
end

% Compute the value function using linear programming
disp('start to solve linear program...')
Vlp = linprog(c,Aineq,b);

msg = ['The Value function, computed with linear programming, is:'];
disp(msg)
Vlp'
