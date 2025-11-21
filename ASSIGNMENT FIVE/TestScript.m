% TestScript.m
clear; clc;

% --- PART 1: Differential Problem (Root Finding) ---
fprintf('*** Testing RootFindingProblem (NRM & Secant) ***\n');
% Create an instance of the RootFindingProblem subclass
rootSolver = DifferentialPoblem();

% NRM Test: Find the velocity v that makes f(v)=0 (terminal velocity)
initialGuess = 50;
tolerance = 1e-4;
maxIter = 100;
v_nrm = rootSolver.solveNRM(initialGuess, tolerance, maxIter);
fprintf('Terminal Velocity (NRM): %.4f m/s\n\n', v_nrm);

% Secant Test
x0 = 0;
x1 = 50;
v_secant = rootSolver.solveSecant(x0, x1, tolerance, maxIter);
fprintf('Terminal Velocity (Secant): %.4f m/s\n\n', v_secant);

% --- PART 2: Integral Problem (ODE Solving) ---
fprintf('*** Testing IntegrationProblem (Euler & Runge Kutta 4th order) ***\n');
% Create an instance of the IntegrationProblem subclass
odeSolver = IntegrationProblem();

% Common Parameters for ODE:
initialVelocity = 0; % Start from rest
stepSize = 0.5;
timeEnd = 10; % Solve for time t = 0 to 10 seconds

% Euler Test: dv/dt = f(v)
[t_e, v_e] = odeSolver.solveEuler(initialVelocity, stepSize, timeEnd);
fprintf('Velocity after %.1f s (Euler): %.4f m/s\n\n', timeEnd, v_e(end));

% RK4 Test
[t_rk, v_rk] = odeSolver.solveRungeKutta(initialVelocity, stepSize, timeEnd);
fprintf('Velocity after %.1f s (Runge Kutta 4th Order): %.4f m/s\n\n', timeEnd, v_rk(end));