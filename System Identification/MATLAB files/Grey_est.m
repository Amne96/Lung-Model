function Grey_SS = grey_est(data1_train, data1_val);

E_min = 1 ;        % elastance compartment 1 [cm H2O/L]
E_max = 50 ;
R_min = 1 ;
R_max = 50 ;

% One compartment state space estimation

odefun = 'RespiratoryModel';
% Initial states
E = 1 ;
R = 1 ;
parameters = {'Elastance',E; 'Resistance',R};
fcn_type = 'c';
sys1 = idgrey(odefun, parameters, fcn_type);

sys1.Structure.Parameters(1).Free = true;
sys1.Structure.Parameters(2).Free = true;
sys1.Structure.Parameters(1).Maximum = E_max; 
sys1.Structure.Parameters(1).Minimum = E_min; 
sys1.Structure.Parameters(2).Maximum = R_max; 
sys1.Structure.Parameters(2).Minimum = R_min;

sys2 = greyest(data1_train,sys1);
Grey_SS.sys = sys2;
 
para_est = getpvec(sys2) ;  
Grey_SS.Elastance = para_est(1);
Grey_SS.Resistance = para_est(2);

cov = getcov(sys2);
Grey_SS.E_SE = (1/(sqrt(length(data1_train))))*sqrt(cov(1,1));
Grey_SS.R_SE = (1/(sqrt(length(data1_train))))*sqrt(cov(2,2));

[y, fit, x0] = compare(data1_val, sys2);
Grey_SS.Fit = fit;
Grey_SS.MSE = goodnessOfFit(y.y, data1_val.y,'MSE');
end
