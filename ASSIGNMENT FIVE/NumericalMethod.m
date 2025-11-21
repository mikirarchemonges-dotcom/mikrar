
classdef NumericalMethod
    %NUMERICALMETHOD Abstract superclass for numerical computation problems.
    %Allows setting a user-defined function for root-finding or plotting.

    properties (Access = protected)
        m = 80;      % Mass
        g = 9.81;    % Gravity
        c = 0.25;    % Drag coefficient
        mg;          % m*g
    end

    properties (Access = public)
        userFunction  % Function handle provided by the user
    end

    methods (Abstract)
        solution = solveNRM(obj, initialGuess, tolerance, maxIter)
        solution = solveSecant(obj, x0, x1, tolerance, maxIter)
        solution = solveEuler(obj, initialValue, stepSize, timeEnd)
        solution = solveRungeKutta(obj, initialValue, stepSize, timeEnd)
    end

    methods
        % Constructor
        function obj = NumericalMethod()
            obj.mg = obj.m * obj.g;
            obj.userFunction = [];  % Default empty
        end

        % Method to set a user-defined function
        function obj = setUserFunction(obj, funcHandle)
            if isa(funcHandle, 'function_handle')
                obj.userFunction = funcHandle;
            else
                error('Input must be a valid function handle, e.g. @(x) x.^3 - x - 2');
            end
        end

        % f(v) uses user-defined function if provided, else default
        function val = f(obj, v)
            if ~isempty(obj.userFunction)
                val = obj.userFunction(v);
            else
                val = obj.mg - obj.c * v.^2; % Default physical model
            end
        end

        % Derivative of f(v) for Newton-Raphson
        function val = f_prime(obj, v)
            if isempty(obj.userFunction)
                val = -2 * obj.c * v; % Default derivative
            else
                % Numerical derivative for user-defined function
                h = 1e-6;
                val = (obj.userFunction(v + h) - obj.userFunction(v - h)) / (2*h);
            end
        end

        % Optional helper to plot the function
        function plotFunction(obj, range)
            if isempty(obj.userFunction)
                fplot(@(x) obj.f(x), range, 'LineWidth', 1.5);
                title('Default Function f(v) = mg - c*v^2');
            else
                fplot(obj.userFunction, range, 'LineWidth', 1.5);
                title('User-Defined Function');
            end
            xlabel('x'); ylabel('f(x)');
            grid on;
        end
    end

    % Differential equation for integration methods (Euler/RK)
    methods (Static)
        function dvdt = differentialEq(~, v) 
            m = 80; g = 9.81; c = 0.25;
            dvdt = m*g - c*v.^2; % Default ODE
        end
    end
end

