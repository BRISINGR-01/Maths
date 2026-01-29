clear; clc;

% Params
params.m  = 0.1;      % weight of pendulum 100 g    
params.g  = 9.81;     
params.L  = 0.2;      % length of rod 20 cm
params.I  = params.m * params.L^2;
params.b  = 0.01;     % assumed damping value
params.km = 0.02;     % assumed magnetic constant
params.R  = 4;        % magnet resistance Ohm
params.Lc = 0.01;     % magnet inductance H

% Input voltage (open-loop)
u = 0;   % no actuation

% Initial state
phi0 = deg2rad(5);    % 5 degrees
x0 = [phi0; 0; 0];   % phi, phi_dot, i

% Time span
tspan = [0 5];

% Solve nonlinear model
[t, x] = ode45(@(t,x) Pend_nonlinear(t, x, u, params), tspan, x0);

% Extract states
phi    = x(:,1);
phiDot = x(:,2);
% i = x(:,3);  % current remains zero in open-loop

% Plot
figure;

subplot(2,1,1)
plot(t, phi, 'LineWidth', 1.5)
ylabel('$\phi$ [rad]', 'Interpreter', 'latex')
title('Nonlinear Open-Loop System Response')
grid on

subplot(2,1,2)
plot(t, phiDot, 'LineWidth', 1.5)
ylabel('$\dot{\phi}$ [rad/s]', 'Interpreter', 'latex')
xlabel('Time [s]')
grid on

function dx = Pend_nonlinear(t, x, u, params)
% Nonlinear inverted pendulum with electromagnetic actuation

phi     = x(1);   % angle [rad]
phi_dot = x(2);   % angular velocity [rad/s]
i       = x(3);   % coil current [A]

m  = params.m;
g  = params.g;
L  = params.L;
I  = params.I;
b  = params.b;
km = params.km;
R  = params.R;
Lc = params.Lc;

dx = zeros(3,1);

dx(1) = phi_dot;

dx(2) = ( m*g*L*sin(phi) + km*i^2*sin(phi) - b*phi_dot ) / I;

dx(3) = (-R*i + u) / Lc;
end