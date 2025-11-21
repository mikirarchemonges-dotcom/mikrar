clc; clear; close all;
%defining ODE and initial conditions
f=@(x,y)x.^2+y; x0=0; y0=1; h=0.1; n=10; % n steps
% starting the clock, calling recursive functions and stopping the clock.
tic; [Xe,Ye]=EulerRec(f,x0,y0,h,n); te=toc;
tic; [Xr,Yr]=RK4Rec(f,x0,y0,h,n); tr=toc;
% Display compuation time
fprintf('Euler: %.6e s, RK4: %.6e s\n',te,tr);
%plotting
subplot(1,2,1); plot(Xe,Ye,'-ob',Xr,Yr,'-sr'); grid on; legend('Euler','RK4'); title('Solutions');
subplot(1,2,2); bar([te tr]); set(gca,'xticklabel',{'Euler','RK4'}); ylabel('Time (s)'); title('Computational Time');
% RECURSIVE FORMULARS
% Recursive Euler
function [X,Y]=EulerRec(f,x,y,h,n)
if n==0, X=x; Y=y; return; end
[XR,YR]=EulerRec(f,x+h,y+h*f(x,y),h,n-1);
X=[x;XR]; Y=[y;YR];
end

% Recursive RK4
function [X,Y]=RK4Rec(f,x,y,h,n)
if n==0, X=x; Y=y; return; end
k1=f(x,y); k2=f(x+h/2,y+h*k1/2); k3=f(x+h/2,y+h*k2/2); k4=f(x+h,y+h*k3);
y1=y+(h/6)*(k1+2*k2+2*k3+k4); x1=x+h;
[XR,YR]=RK4Rec(f,x1,y1,h,n-1);
X=[x;XR]; Y=[y;YR];
end