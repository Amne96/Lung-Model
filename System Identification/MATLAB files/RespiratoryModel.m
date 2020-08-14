function [A,B,C,D] = RespiratoryModel(E, R, dt)
A = [-E/R] ; 
B = [1/R]  ;
C = 1 ; 
D = 0;
K = 0;
end
