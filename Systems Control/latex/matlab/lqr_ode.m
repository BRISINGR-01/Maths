function dx = lqr_ode(~, x, A, B, K)
    % State vector:
    % x = [phi; phiDot; i]

    u = -K * x;
    dx = A*x + B*u;
end
