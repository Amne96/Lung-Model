function Opt = Step_opt (t, V, Y_ss)

syms E 
eqn = 1/E == Y_ss;          % Equation steady state
E = solve(eqn,E);           % Solve for E
E = double(E);

y_ss_90 = 0.9*Y_ss;         % Get time points before steady state is reached

for i = 1:length(V);
    if V(i,1) < y_ss_90;
        y_1(i+20,1) = 1;
    else
        y_1(i+20,1) = 0;
    end
end

V_estimate = y_1(21:end).*V;
V_estimate = nonzeros(V_estimate);

for j = 5:length(V_estimate) ;                                 % starting from t>0 because y(t) has to be > 0 for solving equation
    
    syms R
    eqn = -1/E * (exp((-E/R)*t(j))) + 1/E == V(j);      % Equation transient response
    R = solve(eqn,R);                                           % Solve for R
    R = double(R);
            
    y_est = 1/E - (exp((-E/R)*t))/E;                        % Simulated response
    y_est = transpose(y_est);
    Cost(j) = (1/length(V))*(sum((V-y_est).^2));                % Costfunction
    R_est(j,1) = R;                                             % Estimated R
    R_est(j,2) = Cost(j);                                        % Corresponding error
  
end

MSE = min(R_est(5:end,2));
MSE_loc = find(R_est(:,2) == MSE);
R_best = R_est(MSE_loc,1);

Opt.Elastance = E;
Opt.Resistance = R_best;
Opt.MSE = MSE;

end
