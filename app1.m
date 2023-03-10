clc;
clear;
close all;

%% Problem Definition
problem.nVar = 15;
problem.CostFunction = @(x,nVar) PID_regulator(x, nVar);



%% GA Parameters

params.MaxIt = 100;
params.nPop = 100;

params.beta = 1;
params.pC = 1;
params.mu = 0.7;

%% Run GA

out = RunGA(problem, params);


%% Results

figure;
plot(out.bestcost, 'LineWidth', 2);
xlabel('Iterations');
ylabel('Best Cost');
grid on;
disp(out.bestKp);
disp(['Kp :' num2str(out.bestKp) '; Ki = ' num2str(out.bestKi) '; Kd = '  num2str(out.bestKd)]);





