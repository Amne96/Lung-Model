function SS_blackbox = Blackbox(data1_train, data1_val);

sys = n4sid(data1_train, 1, 'Form','canonical','DisturbanceModel', 'none');
%sys = ssest(data1_train, 1, 'Form','canonical','DisturbanceModel', 'none');
SS_blackbox.sys = sys;
SS_blackbox.E = -sys.B/sys.A;
SS_blackbox.R = 1/sys.B;

cov = getcov(sys);
SS_blackbox.A_SE = (1/(sqrt(length(data1_train))))*sqrt(cov(1,1));
SS_blackbox.B_SE = (1/(sqrt(length(data1_train))))*sqrt(cov(2,2));


[y, fit, x0] = compare(data1_val, sys);
SS.Fit = fit;
SS.MSE = goodnessOfFit(y.y, data1_val.y,'MSE');
end