clc; clear; close all;

% Logistic growth parameters
r = 0.8;    % growth rate
K = 1000;   % carrying capacity
y0 = 50;    % initial population
t0 = 0;     
tEnd = 10;  % years
h = 0.25;   % step size
t = t0:h:tEnd; 
N = length(t)-1;

% Differential equation
f = @(t,y) r*y*(1 - y/K);

% Exact solution (for comparison)
y_exact = @(t) K ./ (1 + ((K-y0)/y0).*exp(-r*t));

% --- Euler ---
y_euler = zeros(1,N+1); y_euler(1)=y0;
tic;
for i=1:N
    y_euler(i+1) = y_euler(i) + h*f(t(i),y_euler(i));
end
time_euler = toc;

% --- Runge-Kutta 4 ---
y_rk4 = zeros(1,N+1); y_rk4(1)=y0;
tic;
for i=1:N
    k1 = f(t(i),y_rk4(i));
    k2 = f(t(i)+h/2, y_rk4(i)+h*k1/2);
    k3 = f(t(i)+h/2, y_rk4(i)+h*k2/2);
    k4 = f(t(i)+h,   y_rk4(i)+h*k3);
    y_rk4(i+1) = y_rk4(i) + (h/6)*(k1+2*k2+2*k3+k4);
end
time_rk4 = toc;

% Print computation times
fprintf('Euler Time: %.6f s\n', time_euler);
fprintf('RK4 Time  : %.6f s\n', time_rk4);

% Plot results
plot(t, y_exact(t),'k-','LineWidth',2); hold on;
plot(t, y_euler,'bo--'); 
plot(t, y_rk4,'rs-');
legend('Exact','Euler','RK4','Location','Best');
xlabel('Time'); ylabel('Population');
title('Logistic Growth: Euler vs RK4');
grid on;