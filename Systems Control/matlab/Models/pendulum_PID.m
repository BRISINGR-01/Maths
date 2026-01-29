% Single-loop PID control of linearized electromagnetic inverted pendulum
clc; close all;

% Params
params.g  = 9.81;      % gravity 
params.L  = 0.2;      % pendulum length 20 cm
params.R  = 4.0;       % coil resistance in Ohm
params.Lc = 0.02;      % coil inductance in H
params.ki = 0.15;      % magnetic torque constant

% PID gains
pid.Kp = 12;
pid.Ki = 8;
pid.Kd = 3;

% Initial conditions
phi0    = 0.05;
phiDot0 = 0;
i0      = 0;
z0      = 0;

x0 = [phi0; phiDot0; i0; z0];

% Simulation
tspan = [0 5];
[t, x] = ode45(@(t,x) closed_loop_dynamics(t, x, params, pid), tspan, x0);

% Extract states
phi     = x(:,1);
phiDot = x(:,2);
i       = x(:,3);

% Plotting
figure;

subplot(3,1,1)
plot(t, phi, 'LineWidth', 1.5)
ylabel('$\phi$ [rad]', 'Interpreter','latex')
title('Single-loop PID Controlled System Response')
grid on

subplot(3,1,2)
plot(t, phiDot, 'LineWidth', 1.5)
ylabel('$\dot{\phi}$ [rad/s]', 'Interpreter','latex')
grid on

subplot(3,1,3)
plot(t, i, 'LineWidth', 1.5)
ylabel('$i$ [A]', 'Interpreter','latex')
xlabel('Time [s]')
grid on

% closed-loop dynamics
function dx = closed_loop_dynamics(~, x, params, pid)

    % States
    phi     = x(1);
    phiDot = x(2);
    i       = x(3);
    z       = x(4);

    % Error (reference = 0)
    e = -phi;

    % PID control law
    u = pid.Kp*e + pid.Ki*z - pid.Kd*phiDot;

    % Dynamics
    dx = zeros(4,1);
    dx(1) = phiDot;
    dx(2) = (params.g/params.L)*phi + params.ki*i;
    dx(3) = -(params.R/params.Lc)*i + (1/params.Lc)*u;
    dx(4) = e;
end
