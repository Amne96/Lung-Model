% Transferfunctions bode plots
data1 = iddata(P1.Volume, P1.P_es, P1.dt);

tf1 = tfest(data1, 1, 0) ; %first order differentiaal vergelijkinh
tf2 = tfest(data1, 2, 0);  % 2e orde differentiaal vergelijking

figure()
bode(tf1)
figure()
bode(tf2)
