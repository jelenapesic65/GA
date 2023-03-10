function z = PID_regulator(x, nVar)
    

    Kmin = 0;
    Kmax = 50;
    Kpb = 0;
    Kib = 0;
    Kdb = 0;
    for i = 1:nVar
        Kpb = Kpb + 2^(nVar - i)*x(1,i);
        Kib = Kib + 2^(nVar - i)*x(2,i);
        Kdb = Kdb + 2^(nVar - i)*x(3,i);
    end
    
    Kp = Kmin + Kpb * (Kmax - Kmin)/ (2^nVar - 1);
    Ki = Kmin + Kib * (Kmax - Kmin)/ (2^nVar - 1);
    Kd = Kmin + Kdb * (Kmax - Kmin)/ (2^nVar - 1);
    
    s = tf('s');
    Gm = 0.01 /(0.005*s^2 + 0.06* s + 0.1001);
    %Gm = 1 /((s+1)*(s+2)*(s+3));
    Gp = Kp + Ki/s + Kd*s;
    
    
    G = (Gm * Gp) / (1 + Gm * Gp);
  
    dt = 0.01;
    t = 0:dt:5;
    u = heaviside(t);
    y = lsim(G,u,  t);

    %figure(2)
    %plot(t,lsim(Gm,u,t));
    
   % Q = 1;
    %R = 0.001;
    %J = dt*sum(Q * (y(:) - u(:)).^2 + R*u(:).^2);
    w1 = 1;
    w2 = 1;
    w3 = 1;
    
    J = w1 * dt * sum((y(:) - u(:)).^2) + w2 * dt * sum(abs(y(:) - u(:))) + w3 * dt* sum( t(:).* abs(y(:) - u(:)));
    %J = w3 * dt* sum( t(:).* abs(y(:) - u(:)));
    
    z.cost = J;
    z.u = u;
    z.y = y;
    z.t  = t;
    z.Kp = Kp;
    z.Ki = Ki;
    z.Kd = Kd;
    
%     figure(1)
%     plot(t,u)
%     hold all
%     plot(t, y)
%     
    
    
    
    
end
