function [QC, RC] mycgs(A)
%   [QC, RC] = mycgs(A)
%   Author: Amanda Lauen
%   Date: March 11, 2022
%   Description:
% Input
%       A = 
%
%   Outputs
%       QC = 
%
%       RC = 
%
%   Sample 
%       [QC, RC] = mycgs(A);
%       [QC, RC] = mycgs(A);

% Each function will accept an m x n (m >= n) matrix A and return an m x n
% matrix Q with orthogonal colums that span the same space as the columns
% of A and an n x n upper triagular matrix R s.t. A = QR

% Build actual matrix
[U,X] = qr(randn(80));
[V,X] = qr(randn(80));
S = diag(2.^(-1:-1:-80));
A = U*S*V;
% Algorithm 7.1 Classical Gram Schmidt
for j = 1:n
    vj=aj;
    for i = 1:j - 1
        rij = qi*aj;
        vj = vj = vj - rijqi;
    end
    rjj = ||vj||_2;
    qj = vj/rjj;
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