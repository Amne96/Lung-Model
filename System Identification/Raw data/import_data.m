function [P_air,P_es,F,V] = import_data(in_filepath)

%This function is used to import airway pressure, oesofageal pressure, volume and flow data from the
%input data files. 

data_raw = importdata(string(in_filepath));
data_cell = struct('P_airway', str2double(data_raw.textdata(2:end,4)), ...
    'P_oesophageal', str2double(data_raw.textdata(2:end,5)), ...
    'Flow', str2double(data_raw.textdata(2:end,6)), ...
    'Volume', str2double(data_raw.textdata(2:end,7)));


P_air = data_cell.P_airway; 
P_es = data_cell.P_oesophageal; 
F = data_cell.Flow./1000; 
V = data_cell.Volume./1000; 

end

