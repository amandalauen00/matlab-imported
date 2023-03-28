function [QM, RM] = mymgs(A)
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
    
    % Get size of A
    [m, n] = size(A);
    % Create QC and RC
    QM = zeros(m,n);
    RM = zeros(n,n);
    
    V = A;

    % Algoritm 8.1 Modified Gram-Schmidt
    % for i = 1:n
    %     vi = ai
    % end
    for i = 1:n
        RM(i,i) = norm(V(:,i));
        QM(:,i) = V(:,i)/RM(i,i);
        for j = i + 1:n
            RM(i,j) = QM(:,i)'*V(:,j);
            V(:,j) = V(:,j) - RM(i,j)*QM(:,i);
        end
    end
end