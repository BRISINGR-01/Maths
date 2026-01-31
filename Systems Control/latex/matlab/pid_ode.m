
% Cascaded PID dynamics
function dx = pid_ode(~,x,...
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