function K = compute_lqr_gains(g,l,R,Lc, alpha)
 %% Inner Loop 
    Ai = -R/Lc;
    Bi = 1/Lc;
    
    Qi = 1;
    Ri = 1e-2;
    
    Ki = lqr(Ai, Bi, Qi, Ri);
        
    %% Outer Loop
    Ao = [0 1; 
         g/l 0];
    
    Bo = [0; alpha];
    
    Qo = diag([100 1]);
    Ro = 1;
    
    Ko = lqr(Ao, Bo, Qo, Ro);
    
    K = [Ko(1) Ko(2) Ki];
    

    
    A = [ 0    1      0;
          g/l  0   alpha;
          0    0   -R/Lc ];
    B = [0; 0; 1/Lc];

    if all(real(eig(A-K*B)) >= 0)
        disp('SYSTEM IS UNSTABLE');
    end
end
