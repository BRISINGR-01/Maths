clc; clear;

%% Units
cm = 1e-2;
gr = 1e-3;

%% Parameters 
g    = 9.81;
l    = 30*cm;
mass = 150*gr;
d    = 2*cm;

k  = 335;
Lc = 0.02;
i0 = 1e-6;
R  = 4;

%% Model 
alpha = (2*k*i0)/(mass*l*d^2);

A = [ 0    1      0;
      g/l  0   alpha;
      0    0   -R/Lc ];

B = [0; 0; 1/Lc];

disp('Open-loop poles:');
disp(eig(A))

%% Inner Loop 
Ai = -R/Lc;
Bi = 1/Lc;

Qi = 1;
Ri = 1e-2;

Ki = lqr(Ai, Bi, Qi, Ri);

fprintf('Inner current gain Ki = %.4f\n', Ki);

%% Outer Loop
Ao = [0 1;
      g/l 0];

Bo = [0;
      alpha];

Qo = diag([100 1]);
Ro = 1;

Ko = lqr(Ao, Bo, Qo, Ro);

fprintf('Outer gains Ko = [%.4f  %.4f]\n', Ko(1), Ko(2));

K = [Ko(1) Ko(2) Ki];

%% Closed Loop
Acl = A - B*K;

disp('Closed-loop poles:');
disp(eig(Acl))

if all(real(eig(Acl)) < 0)
    disp('SYSTEM IS STABLE');
else
    disp('SYSTEM IS UNSTABLE');
end

% Simulation
phi0    = 0.05;
phiDot0 = 0.0;
i0_sim  = 0.0;

x0 = [phi0; phiDot0; i0_sim];
tspan = [0 5];

[t, x] = ode45(@(t,x) lqr_ode(x,A,B,K), tspan, x0);

phi    = x(:,1);
phiDot = x(:,2);
i      = x(:,3);

% Performance metrics
Ts_LQR     = settling_time(t, phi);
OS_LQR     = overshoot_percent(phi);
i_peak_LQR = max(abs(i));
J_LQR      = trapz(t, i.^2);
i_rms_LQR  = sqrt(mean(i.^2));

Results_LQR = table(Ts_LQR, OS_LQR, i_peak_LQR, J_LQR, i_rms_LQR, ...
    'VariableNames', {'SettlingTime_s','Overshoot_percent','PeakCurrent_A','RMS_Current_A' } );

disp('--- LQR Performance Metrics ---')
disp(Results_LQR)

% Save results
LQR_results.time    = t;
LQR_results.phi     = phi;
LQR_results.phiDot  = phiDot;
LQR_results.current = i;
LQR_results.metrics = Results_LQR;

save('results_LQR.mat', 'LQR_results')

% Misc. functions
function dx = lqr_ode(x,A,B,K)
    u  = -K*x;
    dx = A*x + B*u;
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
