clear 
clc
close all
s = tf('s');
Gm = 1/((s+1)*(s+2)*(s+3));
%Gm = 0.01 /(0.005*s^2 + 0.06* s + 0.1001);
% 
% Ku = 60;
% Tu = 1.9;
% 
% Kp = 0.6*Ku;
% Ti = Tu/2;
% Td = Tu/8;
% 
% Ki = Kp/Ti;
% Kd = Td*Kp;
Kp = 94.2595; Ki = 61.1286; Kd = 84.6614  ;



Gp = Kp + Ki/s + Kd*s;
G = (Gm * Gp) / (1 + Gm * Gp);

% Kp1= 28.7042; Ki1 = 49.6323; Kd1 = 7.355;
% Gp1 =  Kp1 + Ki1/s + Kd1*s;
% G1 = (Gm * Gp1) / (1 + Gm * Gp1);


dt = 0.01;
t = 0:dt:10;
u = heaviside(t);
y = lsim(G,u,  t);
%y1 = lsim(G1,u,t);
figure(1)
plot(t,y);
hold all
plot(t,u);

hold off;
grid on;
title('Odziv sistema na jedinicnu odskocnu pobudu');
xlabel('vreme[s]');
ylabel('amplituda');



