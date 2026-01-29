clear; clc; close all;

% Load simulation results

load results_PID.mat      
load results_LQR.mat      

t_PID      = PID_results.time;
phi_PID    = PID_results.phi;
phiDot_PID = PID_results.phiDot;
i_PID      = PID_results.current;

t_LQR      = LQR_results.time;
phi_LQR    = LQR_results.phi;
phiDot_LQR = LQR_results.phiDot;
i_LQR      = LQR_results.current;

% Plots comparison

figure;

subplot(2,1,1)
plot(t_PID, phi_PID, 'b', 'LineWidth', 1.5); hold on
plot(t_LQR, phi_LQR, 'r--', 'LineWidth', 1.5)
grid on
xlabel('Time [s]')
ylabel('$\phi$ [rad]', 'Interpreter','latex')
title('Angle Response Comparison')
legend('PID','LQR')
xlim([0 1.5])
ylim([-0.005 0.055])

subplot(2,1,2)
plot(t_PID, i_PID, 'b', 'LineWidth', 1.5); hold on
plot(t_LQR, i_LQR, 'r--', 'LineWidth', 1.5)
grid on
xlabel('Time [s]')
ylabel('$i$ [A]', 'Interpreter','latex')
title('Control Effort Comparison')
legend('PID','LQR')
xlim([0 1.5])
ylim([-1.7 0.1])

% Performance indicators computation

Ts_PID     = settling_time(t_PID, phi_PID);
Ts_LQR     = settling_time(t_LQR, phi_LQR);

OS_PID     = overshoot_percent(phi_PID);
OS_LQR     = overshoot_percent(phi_LQR);

i_peak_PID = max(abs(i_PID));
i_peak_LQR = max(abs(i_LQR));

J_PID      = trapz(t_PID, i_PID.^2);
J_LQR      = trapz(t_LQR, i_LQR.^2);

i_rms_PID  = sqrt(mean(i_PID.^2));
i_rms_LQR  = sqrt(mean(i_LQR.^2));

% Display results table 

Results = table([Ts_PID; Ts_LQR],[OS_PID; OS_LQR],[i_peak_PID; i_peak_LQR],[J_PID; J_LQR], [i_rms_PID; i_rms_LQR], ...
    'VariableNames', {'SettlingTime_s','Overshoot_percent','PeakCurrent_A','IntegratedCurrentSquared','RMS_Current_A' },'RowNames', {'PID','LQR'} );

disp('--- Controller Performance Comparison ---')
disp(Results)

% Misc. functions

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
