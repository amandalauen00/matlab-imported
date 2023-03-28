clc, clear all, close all

% Build actual matrix
N = 80;
[U,X] = qr(randn(N));
[V,X] = qr(randn(N));
S = diag(2.^(-1:-1:-N));
A = U*S*V;

% Test mycgs
[QC, RC] = mycgs(A);
[QM, RM] = mymgs(A);

% Calculate norms
norm(A-QC*RC)
norm(A-QM*RM)
norm(eye(N,N)-QC'*QC)
norm(eye(N,N)-QM'*QM)

%% produce a plot of the diagonal elements of S, RC and RM
diagS = diag(S);
diagRC = diag(RC);
diagRM = diag(RM);

figure
hold on
semilogy(diagS, 'bo')
semilogy(diagRC,'rx')
semilogy(diagRM,'k^')
legend('Diagonal of S', 'Diagonal of RC', 'diagonal of RM')
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We see that the diagonal elements are built as 1/2, 1/4, 1/8, 1/16, ...
% so as the number of row/column increases, the element in the diagonal
% (n,n) also increases. For N = 80, the last element is 1/2^80 which is
% basically zero, so that's why for all matrices in A, Rc and RM, as the
% index increases the element decreases and decreases until they are zero
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Use built-in QR factorization
[QH,RH] = qr(A);
% Check norms
norm(A-QH*RH)
norm(eye(N,N)-QH'*QH)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We can see that the built-in method qr(A) and the Modified Gram-Schmidt
% methods are the most accurate one, because for a matrix of size 80x80
% the norm are still close to zero (something * 10^(-15 or -16)
% However, for the conventional Gram-Schidt, this is not the case. We can
% see that the norms are not zero, and this is because, as the size of the
% matriz increases, the error also increase. For a matrix of size 10x10
% (for example), the error will be close to zero, but for this example (a
% matrix of size 80x80) the error is significant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%