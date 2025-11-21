clc; clear; format long;
%% COMPARISON BETWEEN SECTANT AND NRM 
% Define the inputs
f  = input('enter function: ');
df = input('enter derivative of the function: ');
x = input('enter x: ');
x0 = input('enter x0: ');
x1 = input('enter x1: ');
n = input('enter number of iterations: ');
% find the true root
true_root = fzero(f,2);

%% Secant Method
secant_vals = x0; x1;
% step 1: looping through each iterations
tic; % start timer
for i = 1:n
    x2 = x1 - f(x1)*(x1 - x0)/(f(x1) - f(x0));
    secant_vals(end+1) = x2;
    if abs(x2 - x1) < 1e-6
        fprintf('\nRoot Secant≈ %.6f (to 6 d.p.)\n', x2);% print Root
        break; 
    end
    %step 2: update variables
    x0 = x1; x1 = x2;
end
secant_time = toc; % stop timer
%% Newton–Raphson Method
newton_vals = x;
%step 1: looping through each iterations
tic; % start timer
for i = 1:n
    x_new = x - f(x)/df(x);
    newton_vals(end+1) = x_new;
    if abs(x_new - x) < 1e-6
        fprintf('\nRoot NRM≈ %.6f (to 6 d.p.)\n', x2);% print Root
        break; 
    end
    % step 2: update the variables
    x = x_new;
end
newton_time = toc; % stop timer
%% Display computation times
fprintf('Secant Method Time: %.6e seconds\n', secant_time);
fprintf('Newton–Raphson Time: %.6e seconds\n', newton_time);

%% Plot convergence
figure; hold on; grid on;

plot(0:length(secant_vals)-1, secant_vals, 'o-b','LineWidth',1.5)
plot(0:length(newton_vals)-1, newton_vals, 's-r','LineWidth',1.5)
yline(true_root,'--k','Root')

xlabel('Iteration')
ylabel('Approximate Root')
title('Comparison of Secant vs Newton–Raphson')
legend('Secant Method','Newton–Raphson','True Root')
saveas(gcf,'figure.png')
%% APPLICATION TO REAL-WORLD  SITUATIONS
% Parameters
m = 80; g = 9.81; c = 0.25;
f  = @(v) m*g - c*v.^2;     % function
df = @(v) -2*c*v;           % derivative

% True terminal velocity
true_v = sqrt(m*g/c);

%% Secant Method
v0 = 30; v1 = 40;
tic
for k = 1:20
    v2 = v1 - f(v1)*(v1 - v0)/(f(v1) - f(v0));
    if abs(v2 - v1) < 1e-6, break; end
    v0 = v1; v1 = v2;
end
secant_time = toc;

%% Newton–Raphson Method
v = 30;
tic
for k = 1:20
    v_new = v - f(v)/df(v);
    if abs(v_new - v) < 1e-6, break; end
    v = v_new;
end
newton_time = toc;

%% Results
fprintf('True Terminal Velocity: %.4f m/s\n', true_v)
fprintf('Secant Method Root    : %.4f m/s (%.6e s)\n', v2, secant_time)
fprintf('Newton Method Root    : %.4f m/s (%.6e s)\n', v_new, newton_time)