% Problem 1

% exc a)
% Init Val. Function with arbitrarily chosen Init. cond.
V0 = ones(8,1);
alpha = 0.9; % discount factor

% amount to add to value function
% motivated by the theor. part of this exc
iteration_summand = [1 2 1 2 0 1 2 0]';

V = V0;
n = 1000;
for iter = 1:n
    for istate = 1:8 % iterate over 8 dimensions of statespace
       V(istate) = iteration_summand(istate) + alpha.*V(istate);
    end
end

% display result
msg = ['The Value function, obtained by iterating over ',num2str(n),' iterations is',newline,newline,'V='];
disp(msg)
disp(V)
