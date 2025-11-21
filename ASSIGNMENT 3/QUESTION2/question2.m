clc; clear; close all;

% Define the differential equation dy/dt = f(t,y) and initials
f = input('enter first order differential equation: ');
t0 = input('initial time t0:');       
y0 = input('initial value y0: ');     
h  = input('enter initial step size: ');      
N  = input('enter step size:');       
t  = t0:h:(t0+N*h);

% Exact solution (for error analysis if known)
y_exact = input('exact value formula');   

%% Euler Method
y_euler = zeros(1,length(t));
y_euler(1) = y0;

tic; % start time
for i = 1:N
    y_euler(i+1) = y_euler(i) + h*f(t(i), y_euler(i));
end
euler_time = toc; % stop time

%% Runge-Kutta 4th Order Method
y_rk4 = zeros(1,length(t));
y_rk4(1) = y0;

tic; % start time
for i = 1:N
    k1 = f(t(i), y_rk4(i));
    k2 = f(t(i) + h/2, y_rk4(i) + h*k1/2);
    k3 = f(t(i) + h/2, y_rk4(i) + h*k2/2);
    k4 = f(t(i) + h, y_rk4(i) + h*k3);
    
    y_rk4(i+1) = y_rk4(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
end
rk4_time = toc; % stop time

%% Display computation time
fprintf('Euler Method Time: %.6f seconds\n', euler_time);
fprintf('Runge-Kutta Method Time: %.6f seconds\n', rk4_time);

%% Display results in a table
Results = table(t', y_exact', y_euler', y_rk4', ...
    'VariableNames', {'t','Exact','Euler','RungeKutta'});
disp(Results);

%% Plot comparison
figure;
plot(t, y_exact, 'k-', 'LineWidth', 2); hold on;
plot(t, y_euler, 'bo--', 'LineWidth', 1.5);
plot(t, y_rk4, 'rs-', 'LineWidth', 1.5);
grid on;
xlabel('t'); ylabel('y');
legend('Exact','Euler','Runge-Kutta 4','Location','Best');
title('Comparison of Euler and Runge-Kutta 4 Methods');