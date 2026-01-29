%% Cascaded PID control for linearized electromagnetic inverted pendulum
% Outer loop: angle PD
% Inner loop: current PI

clear; clc;

% Params
g  = 9.81;      % gravity 
l  = 0.2;      % pendulum length 20 cm
R  = 4.0;       % coil resistance in Ohm
Lc = 0.02;      % coil inductance in H

alpha = 2.0;    % magnetic torque gain (from linearization)

%% Controller gains
% Outer loop (angle PD)
Kp_phi = 40;
Kd_phi = 8;

% Inner loop (current PI)
Kp_i = 20;
Ki_i = 400;

% Initial conditions
phi0     = 0.05;   % rad
phiDot0 = 0.0;
i0       = 0.0;
z_i0     = 0.0;    % integrator state (inner loop)

x0 = [phi0; phiDot0; i0; z_i0];

% Simulation
tspan = [0 5];

[t, x] = ode45(@(t,x) cascadedPID_ode(t,x,...
    g,l,R,Lc,alpha,...
    Kp_phi,Kd_phi,...
    Kp_i,Ki_i), tspan, x0);

% Extract states
phi     = x(:,1);
phiDot  = x(:,2);
i       = x(:,3);

% Plotting

figure;

subplot(3,1,1)
plot(t, phi, 'LineWidth', 1.5)
ylabel('$\phi$ [rad]', 'Interpreter','latex')
title('Cascaded PID Controlled System Response')
grid on
xlim([0 1.5])
ylim([-0.005 0.055])

subplot(3,1,2)
plot(t, phiDot, 'LineWidth', 1.5)
ylabel('$\dot{\phi}$ [rad/s]', 'Interpreter','latex')
grid on
xlim([0 1.5])
ylim([-0.12 0.02])

subplot(3,1,3)
plot(t, i, 'LineWidth', 1.5)
ylabel('$i$ [A]', 'Interpreter','latex')
xlabel('Time [s]')
grid on
xlim([0 1.5])
ylim([-1.6 0.1])

%% Performance metrics
% Settling time (2% criterion)
Ts_PID = settling_time(t, phi);

% Overshoot 
OS_PID = overshoot_percent(phi);

% Peak current
i_peak_PID = max(abs(i));

% Integrated current squared 
J_PID = trapz(t, i.^2);

% RMS current
i_rms_PID = sqrt(mean(i.^2));

%  Results table (console output)

Results_PID = table( ...
    Ts_PID, ...
    OS_PID, ...
    i_peak_PID, ...
    J_PID, ...
    i_rms_PID, ...
    'VariableNames', { ...
        'SettlingTime_s', ...
        'Overshoot_percent', ...
        'PeakCurrent_A', ...
        'IntegratedCurrentSquared', ...
        'RMS_Current_A' } );

disp('=== Cascaded PID Performance Metrics ===')
disp(Results_PID)


% Save results for comparison script (Added for my testing) 
save('results_PID.mat', 't', 'phi', 'phiDot', 'i')

% Cascaded PID dynamics
function dx = cascadedPID_ode(~,x,...
    g,l,R,Lc,alpha,...
    Kp_phi,Kd_phi,...
    Kp_i,Ki_i)

    % States
    phi     = x(1);
    phiDot  = x(2);
    i       = x(3);
    z_i     = x(4);   % integrator (inner loop)

    % Outer loop (angle PD)
    e_phi = -phi;
    i_ref = Kp_phi*e_phi - Kd_phi*phiDot;

    % Inner loop (current PI)
    e_i = i_ref - i;
    u   = Kp_i*e_i + Ki_i*z_i;

    % Plant dynamics
    phiDot_dot = (g/l)*phi + alpha*i;
    i_dot      = -(R/Lc)*i + (1/Lc)*u;

    % Integrator dynamics
    z_i_dot = e_i;

    % State derivative
    dx = [
        phiDot;
        phiDot_dot;
        i_dot;
        z_i_dot
    ];
end

% performance metrics
function Ts = settling_time(t, y)
    y0  = abs(y(1));
    tol = 0.02 * y0;

    idx = find(abs(y) > tol, 1, 'last');
    if isempty(idx)
        Ts = 0;
    else
        Ts = t(idx);
    end
end

function OS = overshoot_percent(y)
    y0 = abs(y(1));
    OS = (max(abs(y)) - y0) / y0 * 100;
    if OS < 0
        OS = 0;
    end
end
