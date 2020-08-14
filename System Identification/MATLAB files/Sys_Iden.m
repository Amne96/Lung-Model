function P_results = Sys_Iden(P)

%% These are the prepared data files 
data1 = iddata(P.Volume, P.P_aw, P.dt); data1.OutputName = 'Volume', data1.InputName = 'Airway Pressure'; 
data2 = iddata(P.Volume, P.P_es, P.dt); data2.OutputName = 'Volume', data2.InputName = 'Oesophageal Pressure';
data3 = iddata(P.Volume, P.P_L, P.dt); data3.OutputName = 'Volume', data3.InputName = 'Transpulmonary Pressure';
%% Lets cut data files in train en validation data
x = length(P.P_aw);
x1 = round(x/2);
data1_train = iddata(P.Volume(1:x1), P.P_aw(1:x1), P.dt); data1_train.OutputName = 'Volume', data1_train.InputName = 'Airway Pressure'; 
data1_val = iddata(P.Volume(x1:x), P.P_aw(x1:x), P.dt); data1_val.OutputName = 'Volume', data1_val.InputName = 'Airway Pressure'; 
data2_train = iddata(P.Volume(1:x1), P.P_es(1:x1), P.dt); data2_train.OutputName = 'Volume', data2_train.InputName = 'Oesophageal Pressure'; 
data2_val = iddata(P.Volume(x1:x), P.P_es(x1:x), P.dt); data2_val.OutputName = 'Volume', data2_val.InputName = 'Oesophageal Pressure'; 
data3_train = iddata(P.Volume(1:x1), P.P_L(1:x1), P.dt); data3_train.OutputName = 'Volume', data3_train.InputName = 'Transpulmonary Pressure'; 
data3_val = iddata(P.Volume(x1:x), P.P_L(x1:x), P.dt); data3_val.OutputName = 'Volume', data3_val.InputName = 'Transpulmonary Pressure'; 
%% Analytical parameter estimation state space step response
P_results.Manual = Step_est(P.Single.t, P.Single.V, P.Single.Y_ss);
%% Optimisation of analytical parameter estimation
P_results.ManualOptimisation = Step_opt(P.Single.t, P.Single.V, P.Single.Y_ss);
%% Black box state space estimation
P_results.Blackbox = Blackbox(data1_train, data1_val);
%% Grey box estimations
P_results.RespiratorySystem = Grey_est(data1_train, data1_val);
P_results.Thorax = Grey_est(data2_train, data2_val);
P_results.Lung = Grey_est(data3_train, data3_val);
%% Estimating using transferfunction
P_results.TF = TF_est(data1_train, data1_val);
end