function NumericalGUI
    % Numerical GUI for OOP system with user-defined equations
    % Integrates DifferentialProblem and IntegrationProblem
clc,clear;
    % --- Figure ---
    fig = uifigure('Name','Numerical Methods GUI','Position',[100 100 900 500]);

    % --- Problem Type ---
    uilabel(fig,'Text','Problem Type:','Position',[30 450 150 22],'FontWeight','bold');
    subclassDrop = uidropdown(fig,'Items',{'DifferentialProblem','IntegrationProblem'},...
        'Position',[180 450 200 22]);

    % --- Method Selection ---
    uilabel(fig,'Text','Method:','Position',[30 410 150 22],'FontWeight','bold');
    methodDrop = uidropdown(fig,'Items',{'Newton-Raphson','Secant','Euler','Runge-Kutta'},...
        'Position',[180 410 200 22]);

    % --- User Equation Input ---
    uilabel(fig,'Text','Enter f(x) (leave blank for default):','Position',[30 370 250 22]);
    eqnField = uieditfield(fig,'text','Position',[280 370 250 22],'Value','');

    % --- Parameters ---
    uilabel(fig,'Text','Initial Guess / Value:','Position',[30 330 150 22]);
    input1 = uieditfield(fig,'numeric','Position',[180 330 100 22],'Value',1);

    uilabel(fig,'Text','Second Guess (Secant only):','Position',[30 290 200 22]);
    input2 = uieditfield(fig,'numeric','Position',[230 290 100 22],'Value',2);

    uilabel(fig,'Text','Tolerance / Step Size:','Position',[30 250 150 22]);
    tolField = uieditfield(fig,'numeric','Position',[180 250 100 22],'Value',1e-4);

    uilabel(fig,'Text','Max Iter / Time End:','Position',[30 210 150 22]);
    iterField = uieditfield(fig,'numeric','Position',[180 210 100 22],'Value',100);

    % --- Compute Button ---
    computeBtn = uibutton(fig,'Text','Compute','FontWeight','bold',...
        'Position',[150 170 120 30],'ButtonPushedFcn',@(btn,event) computeAll());

    % --- Result Label ---
    resultLabel = uilabel(fig,'Text','Result: ','Position',[30 130 500 22],'FontWeight','bold');

    % --- Axes for plotting ---
    ax = uiaxes(fig,'Position',[450 60 400 400]);
    title(ax,'Computation Plot'); xlabel(ax,'x or t'); ylabel(ax,'f(x) or v(t)');

    % --- Compute callback function ---
    function computeAll()
        % Read user inputs
        problemType = subclassDrop.Value;
        method = methodDrop.Value;
        x0 = input1.Value;
        x1 = input2.Value;
        tol = tolField.Value;
        maxIter = iterField.Value;
        eqnText = eqnField.Value;

        % Instantiate subclass
        switch problemType
            case 'DifferentialProblem'
                obj = DifferentialProblem();
            case 'IntegrationProblem'
                obj = IntegrationProblem();
        end

        % Set user-defined function if provided
        if ~isempty(eqnText)
            try
                obj = obj.setUserFunction(str2func(['@(x) ' eqnText]));
            catch
                uialert(fig,'Invalid equation. Use element-wise operators like .^, .* etc.','Error');
                return;
            end
        end

        % Clear axes
        cla(ax);

        % Run selected method
        try
            switch method
                case 'Newton-Raphson'
                    if isa(obj,'IntegrationProblem')
                        uialert(fig,'NRM not available for IntegrationProblem','Error'); return;
                    end
                    sol = obj.solveNRM(x0,tol,maxIter);
                    resultLabel.Text = sprintf('Result: Root ≈ %.6f', sol);
                    % Plot function and root
                    xPlot = linspace(sol-5, sol+5, 300);
                    plot(ax,xPlot,obj.f(xPlot),'b','LineWidth',1.5); hold(ax,'on');
                    obj.plotRoot(sol); hold(ax,'off');

                case 'Secant'
                    if isa(obj,'IntegrationProblem')
                        uialert(fig,'Secant not available for IntegrationProblem','Error'); return;
                    end
                    sol = obj.solveSecant(x0,x1,tol,maxIter);
                    resultLabel.Text = sprintf('Result: Root ≈ %.6f', sol);
                    xPlot = linspace(sol-5, sol+5, 300);
                    plot(ax,xPlot,obj.f(xPlot),'b','LineWidth',1.5); hold(ax,'on');
                    obj.plotRoot(sol); hold(ax,'off');

                case 'Euler'
                    if isa(obj,'DifferentialProblem')
                        uialert(fig,'Euler not available for DifferentialProblem','Error'); return;
                    end
                    [t,v] = obj.solveEuler(x0,tol,maxIter);
                    plot(ax,t,v,'r','LineWidth',1.5);
                    resultLabel.Text = 'Euler computation complete.';

                case 'Runge-Kutta'
                    if isa(obj,'DifferentialProblem')
                        uialert(fig,'Runge-Kutta not available for DifferentialProblem','Error'); return;
                    end
                    [t,v] = obj.solveRungeKutta(x0,tol,maxIter);
                    plot(ax,t,v,'g','LineWidth',1.5);
                    resultLabel.Text = 'Runge-Kutta computation complete.';
            end
        catch ME
            uialert(fig,ME.message,'Computation Error');
        end
    end
end


