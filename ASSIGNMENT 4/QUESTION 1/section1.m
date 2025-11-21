clc; clear; close all;
% defining the function, derivative and tolerance
f=@(x)x.^3-5*x+3; df=@(x)3*x.^2-5; tol=1e-6;
%starting timer, calling the recursive NR and secant function and stoping the tmer
tic; [r1,i1]=NR(f,df,1,tol); t1=toc;
tic; [r2,i2]=Sec(f,0.5,1,tol); t2=toc;
% displaying time and roots
fprintf('NR: root=%.6f, iter=%d, time=%.6e\n',r1,i1,t1);
fprintf('Secant: root=%.6f, iter=%d, time=%.6e\n',r2,i2,t2);
%plotting
subplot(1,2,1);x=-3:0.1:3;plot(x,f(x),'b');hold on;
plot(r1,0,'ro',r2,0,'gs');yline(0,'--k');title('Roots Comparison');grid on;

subplot(1,2,2);bar([t1 t2]);set(gca,'xticklabel',{'Newton','Secant'});
ylabel('Time (s)');title('Computation Time');grid on;
% recursive newton raphson function
function [r,i]=NR(f,df,x,t,i)
if nargin<5,i=0;end;if abs(f(x))<t,r=x;return;end
i=i+1;[r,i]=NR(f,df,x-f(x)/df(x),t,i);end
% recursive secant function
function [r,i]=Sec(f,a,b,t,i)
if nargin<5,i=0;end;if abs(b-a)<t,r=b;return;end
i=i+1;[r,i]=Sec(f,b,b-f(b)*(b-a)/(f(b)-f(a)),t,i);end