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
fprintf("The following norms test that the factorization of A by each method is correct\nAs the norm is smaller, the method is more accurate\n");
fprintf("Norm between A and QC*RC (result from mycgs)\n");
norm(A-QC*RC)
fprintf("\nNorm between A and QM*RM (result from mymgs)\n");
norm(A-QM*RM)

fprintf("Now we test the result from the product of matrix Q from each method\n");
fprintf("The result of the product of Q'*Q should be equal to the Identity matrix\n");
fprintf("So, we will compute the norm between that product and a Identity Matrix\n");
fprintf("\nNorm between the identity and the product of matrix Q'*Q from mycgs\n");
norm(eye(N,N)-QC'*QC)
fprintf("\nNorm between the identity and the product of matrix Q'*Q from mymgs\n");
norm(eye(N,N)-QM'*QM)
fprintf("\nWe see that the Modified Gram-Schmidt is better because the norm is smaller\n");

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
fprintf("Now, we test MATLAB's built-in function for QR factorization\n");
[QH,RH] = qr(A);
% Check norms
fprintf("\nNorm between A and the factored matrix A constructed with Q*H from the built-in qr function\n");
norm(A-QH*RH)
fprintf("\nNorm between the Identity and Q'*Q obtained from the built-in qr function\n");
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
err1 = [];
err2 = [];
i = 1;
for N = 5:100
    [U,X] = qr(randn(N));
    [V,X] = qr(randn(N));
    S = diag(2.^(-1:-1:-N));
    A = U*S*V;
    
    [QC, RC] = mycgs(A);
    [QM, RM] = mymgs(A);

    % Calculate norms
    norm1 = norm(eye(N,N)-QC'*QC);
    norm2 = norm(eye(N,N)-QM'*QM);
    
    err1(i) = norm1;
    err2(i) = norm2;
    i = i + 1;
end

figure
subplot(1,2,1)
plot(5:100, err1)
xlabel('Size of matrix')
ylabel('Error')
title('Conventional Gram-Schmidt')
grid on
subplot(1,2,2)
plot(5:100, err2)
grid on
xlabel('Size of matrix')
title('Modified Gram-Schmidt')

ylabel('Error')