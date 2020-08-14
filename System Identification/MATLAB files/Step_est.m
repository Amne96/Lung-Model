function Results1 = Step_est(t,V, y_ss)

x = round(0.45*length(t)); 
V_1 = V(x);
t_1 = t(x);

% Solve for E and R
syms E 
eqn = 1/E == y_ss;          % Equation steady state
E = solve(eqn,E);           % Solve for E
E = double(E);
Results1.Elastance = E;

syms R
          
eqn = -1/E * (exp((-E/R)*t_1)) + 1/E == V_1;       % Equation transient response
R = solve(eqn,R);                                  % Solve for R
R = double(R);
Results1.Resistance = R;

y_est = (1/E - (exp((-E/R)*t))/E);                % Simulated response

Results1.MSE = 1/length(V)*(sum(((V)-transpose(y_est)).^2));

end