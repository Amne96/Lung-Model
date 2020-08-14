function TF = TF_est(data1_train, data1_val)
tf = tfest(data1_train, 1, 0);     % transfer function with one pole, no zeros     
TF.tf = tf;
cov  = getcov(tf); 
TF.Resistance =1/tf.Numerator;
TF.Elastance =tf.Denominator(2)*TF.Resistance;

TF.E_SE = (1/(sqrt(length(data1_train))))*sqrt(cov(1,1));  % standard error of elastance
TF.R_SE = (1/(sqrt(length(data1_train))))*sqrt(cov(2,2));  % standard error of resistance

[y, fit, x0] = compare(data1_val, tf);
TF.Fit = fit;
TF.MSE = goodnessOfFit(y.y, data1_val.y,'MSE');
end