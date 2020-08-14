%% Lung model 
% Master thesis Amne Mousa
% Script required for running simulations 
%%
clear all
close all
clc 
%% Custom made mechanical ventilator
%Intial settings mechanical ventilator simulator 
PEEP = 5;           % [cm H2O] positive end expiratory pressure
Pcontrol =  15;      % [cm H2O] inspiratory pressure above PEEP
f = 20;             % [beats/min] breahting frequency
ieratio = [1,2];    % ratio between inspiratory and expiratory time
insptime = (ieratio(1)/(ieratio(1)+ieratio(2)))*100;   % percentage of total breath time
breath = 60/f;      % [s] total time of one breath
time = 30;          % [s] simulation time
%% Simulation parameters
% Parameters for model 1:
E1 = 16;        % [cm H2O/L] Elastance of lung compartment 1 
R1 = 15;         % [cm H2O/L/s] Resistance of airway of compartment 1
V0 = 2;         % [L] Resting volume lung, i.e. the volume of the lung when pressure is 0 cm H2O

% Parameters for model 2:
E_th = 5 ;      % [cm H2O/L] Elastance of thoracic cage
V0_th = 4.6 ;    % [L] Resting volume thoracic cage, i.e. the volume of the thoracic cage when pressure is 0 cm H2O

% Parameters for model 3:
R = 10 ;         % common resistance
E2 = 8;       % [cm H2O/L] Elastance of lung compartment 2
R2 = 10 ;        % [cm H2O/L/s] Resistance of airway of compartment 

% Parameters for model 4:
E_high = 100000;    % [cm H2O/L] Elastance when TOP is not reached
TOP1 = 0;        % [cm H2O] Pressure of which the alveolar unit/lung is openend and thus low(er) elastance
TOP2 = 5;
