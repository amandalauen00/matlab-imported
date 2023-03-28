% cmprWithAnal
% Comparison with analytical solution
% To do this, set a constant c in proge820474
clear, clc, close all

% Initial Values
m = 20; c = 3; k = 20;
x0 = 1; xp0 = 1; Tf = 30;

% numerical solution using proge820474
[~, t, W] = proge820474(Tf,x0,xp0);

%Solve the equation using roots function
r = roots([m c k]);
A = [1 1; r(:).']; b = [x0; xp0];
C = A\b;
x = real(C(1)*exp(r(1)*t) + C(2)*exp(r(2)*t));

%Plot comparison
figure
plot(t,x,'-x', t(),W(:,1),':o', 'linewidth',1.5)
title('Time Response')
xlabel('Time [ s ]')
ylabel('Displacement, X')
legend('Analytic','proge820474')
