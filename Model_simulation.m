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
Pcontrol =  5;      % [cm H2O] inspiratory pressure above PEEP
f = 15;             % [beats/min] breahting frequency
ieratio = [1,2];    % ratio between inspiratory and expiratory time
insptime = (ieratio(1)/(ieratio(1)+ieratio(2)))*100;   % percentage of total breath time
breath = 60/f;      % [s] total time of one breath
time = 100;          % [s] simulation time
%% Simulation parameters
% One compartment model:
E1 = 10 ;        % [cm H2O/L] Elastance of lung compartment 1 
R1 = 5;         % [cm H2O/L/s] Resistance of airway of compartment 1
V0 = 2;         % [L] Resting volume lung, i.e. the volume of the lung when pressure is 0 cm H2O
E_high = 100;    % [cm H2O/L] Elastance when TOP is not reached
TOP1 = 0;        % [cm H2O] Pressure of which the alveolar unit/lung is openend and thus low(er) elastance
% Two compartment lung model:
R = 30 ;         % common resistance
E2 = 10 ;       % [cm H2O/L] Elastance of lung compartment 2
R2 = 5 ;        % [cm H2O/L/s] Resistance of airway of compartment 1
E_th = 15 ;      % [cm H2O/L] Elastance of thoracic cage
V0_th = 4.6;    % [L] Resting volume thoracic cage, i.e. the volume of the thoracic cage when pressure is 0 cm H2O
TOP2 = 20;
% Four compartment lung model:
R3 = 5 ;
R4 = 5 ;
E3 = 10 ;
E4 = 10 ;
TOP3 = 10 ;
TOP4 = 15 ; 
