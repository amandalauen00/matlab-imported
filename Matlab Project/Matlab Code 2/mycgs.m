function [QC, RC] = mycgs(A)
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
    
    % Get size of A
    [m, n] = size(A);
    % Create QC and RC
    QC = zeros(m,n);
    RC = zeros(n,n);

    % Algorithm 7.1 Classical Gram Schmidt
    for j = 1:n
        vj = A(:, j); % column j
        for i = 1:j - 1
            RC(i,j) = QC(:,i)'*A(:,j);
            vj = vj - RC(i,j)*QC(:,i);
        end
        RC(j,j) = norm(vj);
        QC(:,j) = vj/RC(j,j);
    end
end