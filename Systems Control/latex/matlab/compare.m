%% Units
cm = 1e-2;
gr = 1e-3;

%% Parameters 
g  = 9.81;
l  = 30*cm;
mass = 150*gr;
d  = 2*cm; 

k  = 3300;
Lc = 0.02;
i0 = 1e-7;
R  = 4;


alpha = (2*k*i0)/(mass*l*d^2);

%% Matrices
A = [ 0     1        0;
      g/l   0     (2*k*i0)/(mass*l*d^2);
      0     0   -R/Lc ];

B = [0; 0; 1/Lc];

C = eye(3);
D = zeros(3,1);


%% LQR 
K_lqr = compute_lqr_gains(g,l,R,Lc,alpha);

%% PID
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

x0_pid = [phi0; phiDot0; i0; z_i0];
x0_lqr = [phi0; phiDot0; i0];

% Simulation
tspan = [0 5];

[t_pid, x_pid] = ode45(@(t,x) pid_ode(t,x,...
    g,l,R,Lc,alpha,...
    Kp_phi,Kd_phi,...
    Kp_i,Ki_i), tspan, x0_pid);

[t_lqr, x_lqr] = ode45(@(t,x) lqr_ode(t,x,...
    A, B, K_lqr), tspan, x0_lqr);
% Extract states
phi_pid     = x_pid(:,1);
phiDot_pid  = x_pid(:,2);
i_pid       = x_pid(:,3);

phi_lqr     = x_lqr(:,1);
phiDot_lqr  = x_lqr(:,2);
i_lqr       = x_lqr(:,3);

figure;

% ---- Angle ----
subplot(3,1,1)
plot(t_pid, phi_pid, 'r', 'LineWidth', 1.5); hold on
plot(t_lqr, phi_lqr, 'b--', 'LineWidth', 1.5)
ylabel('$\phi$ [rad]', 'Interpreter','latex')
title('PID vs LQR Response')
legend('PID','LQR')
grid on
xlim([0 max(t_pid)])
padding = 0.05 * (max([phi_pid; phi_lqr]) - min([phi_pid; phi_lqr]));
ylim([min([phi_pid; phi_lqr])-padding, max([phi_pid; phi_lqr])+padding])

% ---- Angular velocity ----
subplot(3,1,2)
plot(t_pid, phiDot_pid, 'r', 'LineWidth', 1.5); hold on
plot(t_lqr, phiDot_lqr, 'b--', 'LineWidth', 1.5)
ylabel('$\dot{\phi}$ [rad/s]', 'Interpreter','latex')
grid on
xlim([0 max(t_pid)])
padding = 0.05 * (max([phiDot_pid; phiDot_lqr]) - min([phiDot_pid; phiDot_lqr]));
ylim([min([phiDot_pid; phiDot_lqr])-padding, max([phiDot_pid; phiDot_lqr])+padding])

% ---- Current ----
subplot(3,1,3)
plot(t_pid, i_pid, 'r', 'LineWidth', 1.5); hold on
plot(t_lqr, i_lqr, 'b--', 'LineWidth', 1.5)
ylabel('$i$ [A]', 'Interpreter','latex')
xlabel('Time [s]')
grid on
xlim([0 max(t_pid)])
padding = 0.05 * (max([i_pid; i_lqr]) - min([i_pid; i_lqr]));
ylim([min([i_pid; i_lqr])-padding, max([i_pid; i_lqr])+padding])


disp('=== Cascaded PID Performance Metrics ===');
metrics(t_pid, phi_pid, i_pid)

disp('=== LQR Performance Metrics ===');
metrics(t_lqr, phi_lqr, i_lqr)

function metrics(t, phi, i) 
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
    
    disp(Results_PID);
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
