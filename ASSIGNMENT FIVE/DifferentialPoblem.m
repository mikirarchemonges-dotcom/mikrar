classdef DifferentialProblem < NumericalMethod
    %ROOTFINDINGPROBLEM Solves differential problems (finding roots).
    %   Implements NRM and Secant methods.

    methods
        % Implementation of NRM (Polymorphism)
        function root = solveNRM(obj, initialGuess, tolerance, maxIter)
            fprintf('--- NRM Solution ---\n');
            x = initialGuess;
            for i = 1:maxIter
                fx = obj.f(x);
                fpx = obj.f_prime(x);

                if abs(fx) < tolerance
                    root = x;
                    fprintf('Converged in %d iterations.\n', i-1);
                    return;
                end

                if abs(fpx) < 1e-10
                    error('Zero derivative encountered. NRM failed.');
                end

                xNew = x - (fx / fpx);
                x = xNew;
            end
            root = x;
            fprintf('Max iterations reached. Approximate root: %.4f\n', root);
        end

        % Implementation of Secant Method (Polymorphism)
        function root = solveSecant(obj, x0, x1, tolerance, maxIter)
            fprintf('--- Secant Solution ---\n');
            for i = 1:maxIter
                fx0 = obj.f(x0);
                fx1 = obj.f(x1);

                if abs(fx1) < tolerance
                    root = x1;
                    fprintf('Converged in %d iterations.\n', i);
                    return;
                end

                if abs(fx1 - fx0) < 1e-10
                    error('Secant method failed: zero denominator.');
                end

                xNew = x1 - fx1 * (x1 - x0) / (fx1 - fx0);
                x0 = x1;
                x1 = xNew;
            end
            root = x1;
            fprintf('Max iterations reached. Approximate root: %.4f\n', root);
        end

        % FIX: Placeholder for Abstraction - Simply return NaN and a warning.
        % This completely removes the 'unset' warning.
        function solution = solveEuler(~, ~, ~, ~)
            warning('Euler method is intended for IntegrationProblem and is not implemented here.');
            % Set return value to satisfy the analyzer
            solution.t = NaN; 
            solution.v = NaN;
        end

        function solution = solveRungeKutta(~, ~, ~, ~)
            warning('Runge Kutta method is intended for IntegrationProblem and is not implemented here.');
            % Set return value to satisfy the analyzer
            solution.t = NaN; 
            solution.v = NaN;
        end
    end
end