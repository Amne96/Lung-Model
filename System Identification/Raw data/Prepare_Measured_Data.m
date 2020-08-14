%%
clear all
clc
close all


%% Import and prepare measured data
fs = 100;               % sampling frequency for wavemode Hamilton C6
dt = 1/fs ;             % sampling time

[P_aw,P_es,F,V] = import_data('P13.txt');     % load experimental data
% Change of dataset? Ctrl+f for making new structs of new patient

t  = (0 : length(P_aw)-1) * dt;               % [s] Time vector
P_L = P_aw - P_es;

figure()
subplot(3,1,1); plot(t,P_aw); title('Airway Pressure'); ylabel('Pressure [cm H_2O]')
subplot(3,1,2); plot(t,P_es); title('Oesofageal Pressure'); ylabel('Pressure [cm H_2O]')
subplot(3,1,3); plot(t,P_L); title('Transpulmonary Pressure'); ylabel('Pressure [cm H_2O]'); xlabel('Time [s]')
figure() % check for artefacts that do not appear in pressure curves
subplot(2,1,1); plot(t,V); title('Volume'); ylabel('Volume [L]')
subplot(2,1,2); plot(t,F); title('Flow'); ylabel('Flow [L]'); xlabel('Time [s]')
%%
% Get pressure offsets, so that data only shows pressure differences from 0.
% Pressure ofsett in airway pressure easy; this is the PEEP (set by the
% user). Pressure offset voor oesofageal pressure is more difficult since
% it differs each breath due to oesofageal peristaltis and cardial
% activity
PEEP = 10;                                  
P0_es = 10.3;
P0_L = -1 ;
P_peak = 27;

% Cut usable part for estimation (usable = no artefacts)
lower_cutoff = 1300/dt;
upper_cutoff = 1700/dt;

P_aw1 = P_aw(lower_cutoff:upper_cutoff,1)- PEEP;      
P_es1 = P_es(lower_cutoff:upper_cutoff,1)- P0_es;         
P_L1 = P_L(lower_cutoff:upper_cutoff,1)- P0_L;                        
F1 = F(lower_cutoff:upper_cutoff,1);          
V1 = V(lower_cutoff:upper_cutoff,1);          
t1 = t(1:(upper_cutoff - lower_cutoff)+1);    

plot(t1, P_es1);
%% Cut data for estimation files 
P5.Volume = V1;
P5.P_aw = P_aw1;
P5.P_L = P_L1;
P5.P_es = P_es1;
P5.Flow = F1;
P5.PEEP = PEEP;
P5.P0_es = P0_es;
P5.P0_L = P0_L;
P5.t = t1;
P5.lower_cutoff = lower_cutoff;
P5.upper_cutoff = upper_cutoff;
P5.dt = dt;
% For single breath analysis:
P5.P_peak = P_peak; 
P5.normalize = P5.P_peak - P5.PEEP;
%% Cut data for single breath analysis
plot(P5.t, P5.Volume)
%%
t_begin = find(P5.t(1,:) == 0.79);            
t_end = find(P5.t(1,:) == 1.71);            
V_new = P5.Volume(t_begin:t_end)./P5.normalize;
%P_new = P5.P_aw(t_begin:t_end)./P5.normalize;
t_new = (0:length(V_new)-1)*dt;
figure()

plot(t_new, V_new)

SingleBreath.t = t_new;
SingleBreath.V = V_new;
SingleBreath.Y_ss = max(V_new);

P5.Single = SingleBreath;
%% 
save('P5.mat' ,'P5')