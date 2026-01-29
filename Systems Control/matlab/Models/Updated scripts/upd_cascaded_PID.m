%% Cascaded PID control 
% Outer loop: angle PD
% Inner loop: current PI

clear; clc;

% Params
g  = 9.81;
l  = 0.2;
R  = 4.0;
Lc = 0.02;

alpha = 2.0;

% Controller gains
Kp_phi = 40;
Kd_phi = 8;

Kp_i = 20;
Ki_i = 400;

% Initial conditions
phi0     = 0.05;
phiDot0 = 0.0;
i0       = 0.0;
z_i0     = 0.0;

x0 = [phi0; phiDot0; i0; z_i0];

% Simulation
tspan = [0 5];

[t, x] = ode45(@(t,x) cascadedPID_ode(t,x,g,l,R,Lc,alpha,Kp_phi,Kd_phi,Kp_i,Ki_i), tspan, x0);

% Extract states
phi    = x(:,1);
phiDot = x(:,2);
i      = x(:,3);

% Plots
figure;

subplot(3,1,1)
plot(t, phi, 'LineWidth', 1.5)
ylabel('$\phi$ [rad]', 'Interpreter','latex')
title('Cascaded PID Controlled System Response')
grid on
xlim([0 1.5])

subplot(3,1,2)
plot(t, phiDot, 'LineWidth', 1.5)
ylabel('$\dot{\phi}$ [rad/s]', 'Interpreter','latex')
grid on
xlim([0 1.5])

subplot(3,1,3)
plot(t, i, 'LineWidth', 1.5)
ylabel('$i$ [A]', 'Interpreter','latex')
xlabel('Time [s]')
grid on
xlim([0 1.5])

% Performance metrics
Ts_PID      = settling_time(t, phi);
OS_PID      = overshoot_percent(phi);
i_peak_PID  = max(abs(i));
J_PID       = trapz(t, i.^2);
i_rms_PID   = sqrt(mean(i.^2));

Results_PID = table(Ts_PID, OS_PID, i_peak_PID, J_PID, i_rms_PID, ...
    'VariableNames', {'SettlingTime_s','Overshoot_percent','PeakCurrent_A','RMS_Current_A' } );

disp('--- Cascaded PID Performance Metrics ---')
disp(Results_PID)

% Save results
PID_results.time      = t;
PID_results.phi       = phi;
PID_results.phiDot    = phiDot;
PID_results.current   = i;
PID_results.metrics   = Results_PID;

save('results_PID.mat', 'PID_results')

% Misc. functions
function dx = cascadedPID_ode(~,x,g,l,R,Lc,alpha,Kp_phi,Kd_phi,Kp_i,Ki_i)

    phi     = x(1);
    phiDot  = x(2);
    i       = x(3);
    z_i     = x(4);

    e_phi = -phi;
    i_ref = Kp_phi*e_phi - Kd_phi*phiDot;

    e_i = i_ref - i;
    u   = Kp_i*e_i + Ki_i*z_i;

    phiDot_dot = (g/l)*phi + alpha*i;
    i_dot      = -(R/Lc)*i + (1/Lc)*u;

    z_i_dot = e_i;

    dx = [
        phiDot;
        phiDot_dot;
        i_dot;
        z_i_dot
    ];
end

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
