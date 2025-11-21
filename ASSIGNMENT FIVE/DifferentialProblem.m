classdef DifferentialProblem < handle
    % DifferentialProblem
    % Subclass for solving user-defined differential or nonlinear equations
    % Supports Newton-Raphson and Secant methods
    % ----------------------------------------------
    % Author: [Your Name]
    % Date: [Today’s Date]

    properties
        f       % function handle for f(x)
        df      % derivative function handle for f(x)
        x0      % initial guess
        tol     % tolerance
        maxIter % maximum number of iterations
    end

    methods
        %% Constructor
        function obj = DifferentialProblem(f, df, x0, tol, maxIter)
            if nargin > 0
                obj.f = f;
                obj.df = df;
                obj.x0 = x0;
                obj.tol = tol;
                obj.maxIter = maxIter;
            else
                % default parameters
                disp('no function provided');
            end
        end

        %% Newton-Raphson Method
        function root = solveNRM(obj)
            x = obj.x0;
            for i = 1:obj.maxIter
                fx = obj.f(x);
                dfx = obj.df(x);

                if dfx == 0
                    error('Derivative is zero at x = %.4f. No convergence.', x);
                end

                xNew = x - fx / dfx;

                if abs(xNew - x) < obj.tol
                    fprintf('Newton-Raphson converged in %d iterations.\n', i);
                    root = xNew;
                    return;
                end

                x = xNew;
            end

            root = x;
            fprintf('Newton-Raphson did not converge in %d iterations.\n', obj.maxIter);
        end

        %% Secant Method
        function root = solveSecant(obj, x1)
            x0 = obj.x0;
            for i = 1:obj.maxIter
                f0 = obj.f(x0);
                f1 = obj.f(x1);

                denom = (f1 - f0);
                if denom == 0
                    error('Zero denominator encountered in Secant method.');
                end

                x2 = x1 - f1 * (x1 - obj.x0) / denom;

                if abs(x2 - x1) < obj.tol
                    fprintf('Secant method converged in %d iterations.\n', i);
                    root = x2;
                    return;
                end

                x0 = x1;
                x1 = x2;
            end

            root = x1;
            fprintf('Secant method did not converge in %d iterations.\n', obj.maxIter);
        end

        %% Utility: Set new user-defined function
        function setEquation(obj, fStr, dfStr)
            % Converts string inputs into function handles
            % Example: fStr = '@(x)x.^3 - x - 2'
            try
                obj.f = str2func(fStr);
                obj.df = str2func(dfStr);
            catch
                error('Invalid function format. Use format @(x)expression');
            end
        end
    end
end