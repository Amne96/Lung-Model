%% System Identification
% MATLAB scripts supporting master thesis project:
  % Development of a Computational Model of Respiratory Mechanics in Mechanical Ventilation
% Author: Amne Mousa
% August 2020
%%
clear all
close all
clc 
%% 
load('P1.mat')
P1_results = Sys_Iden(P1);
%save('P1_results')

load('P2.mat')
P2_results = Sys_Iden(P2);
%save('P2_results')
 
load('P3.mat')
P3_results = Sys_Iden(P3);
%save('P3_results')

load('P4.mat')
P4_results = Sys_Iden(P4);
%save('P4_results')

load('P5.mat')
P5_results = Sys_Iden(P5);
%save('P5_results')
