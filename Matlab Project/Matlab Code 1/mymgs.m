function [QM, RM] mymgs(A)
% [QM, RM] = mymgs(A)
%   Author: Amanda Lauen
%   Date: March 11, 2022
% Description:
% Input
%       A = 
%
%   Outputs
%       QM = 
%
%       RM = 
%
%   Sample 
%       [QM, RM] = mymgs(A);
%       [QM, RM] = mymgs(A);

% Each function will accept an m x n (m >= n) matrix A and return an m x n
% matrix Q with orthogonal colums that span the same space as the columns
% of A and an n x n upper triagular matrix R s.t. A = QR

% Build actual matrix
[U,X] = qr(randn(80));
[V,X] = qr(randn(80));
S = diag(2.^(-1:-1:-80)); % Diagonal matrix with decreasing powers of 2 as diagonal elements
A = U*S*V; 
% Algoritm 8.1 Modified Gram-Schmidt
for i = 1:n
    vi = ai
for i = 1:n
    rii = ||vi||
    qi = vi/rii
    for j = i + 1:n
        rij == qi*vj
        vj = vj - rijqi
    end
end
end
%Notes from PDF (Checks)
    % A = randn(4,3)
    %[QC,RC] = mycgs(A)
    %[QM,RM] = mymgs(A)
    %norm(A - QC*RC)
    %norm(A - QM*RM)
    %norm(eye(3,3) - QC’*QC)
    %norm(eye(3,3) - QM’*QM)

    % semilogy(diag(RC),’rx’)