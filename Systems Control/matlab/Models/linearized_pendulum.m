clear; clc; close all;

% Params
g  = 9.81;     % gravity
L  = 0.2;     % pendulum length 20cm
R  = 4.0;      % assumed coil resistance in Ohm
Lm = 0.02;     % assume coil inductance in H
ki = 0.15;     % magnetic torque constant (linearized)

% Linearized state-space matrices
A = [ 0        1        0
      g/L      0        ki
      0        0       -R/Lm ];

B = [ 0
      0
      1/Lm ];

C = [ 1  0  0 ];
D = 0;

sys = ss(A,B,C,D);

% Stability analysis
disp('Eigenvalues of A:')
eig(A)

% Controllability
disp('Rank of controllability matrix:')
rank(ctrb(A,B))

% Open-loop response of linearized system
x0 = [0.05; 0; 0];     % small deviation
t  = 0:0.01:5;

[y,t,x] = initial(sys,x0);

% Plot 
figure;

subplot(2,1,1)
plot(t, x(:,1), 'LineWidth', 1.5)
ylabel('$\phi$ [rad]', 'Interpreter','latex')
title('Linearized Open-Loop System Response')
grid on

subplot(2,1,2)
plot(t, x(:,2), 'LineWidth', 1.5)
ylabel('$\dot{\phi}$ [rad/s]', 'Interpreter','latex')
xlabel('Time [s]')
grid on
