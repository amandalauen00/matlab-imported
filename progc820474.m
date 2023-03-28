function [flag, approx] = progc820474(x,F,theta)
%   [flag, approx]= progc820474(x)
%   Author: Amanda Lauen
%   Date: October 22, 2021
%   Description: This code takes in a x-value, force function F, and a
%   theta value to calculate the work done by force using either Simpson's
%   3/8th Rule or the Trapazoidal Rule.
%
%   Input
%       x = a vector that contain the position information
%       F = the force magnitude information
%       theta = a vector that contains the angle made between the force and
%       the direction of movement
%
%   Outputs
%       flag = flag to signify program executed properly or not
%              flag = 1 --> x, F, or theta is outside the interval
%              flag = 2 --> the calculation is being calculated using
%              Simpson's 3/8 Rule
%              flag = 3 --> the calculation is being calcuated using the
%              Trapezoidal Rule
%
%       approx = approximated calculation using the given integral
%
%   Sample 
%       [flag, approx]= progc820474(f,x,theta);
%       [flag, approx]= progc820474([0 1.4286 2.8571 4.2857 5.7143 7.1429 8.5174 10],(x./3),(5./(x+0.01)));

% First, check that the size of the vectors is the same
    if length(x) ~= length(F) || length(x) ~= length(theta) ||length(F) ~= length(theta)
        flag = 1;
        approx = -99;
        return;
    end
    
    % Check that all numbers in all vectors are positive
    if any(x <0) ||any(F < 0) ||any(theta<0)
        flag = 1;
        approx = -99;
        return;
    end
    
    %% Conditions to chose between Simpsons' 3/8 Rule or Trapezoidal
    % In order to check if Simpson's or Trapezoidal rule must be used, we
    % will check three basic conditions. If the conditions are met, then
    % Simpson's rule is used. If not, then Trapezoial Rule is used.
    % Note that, the three conditions must be met, not just one or two

    %%      Condition 1
    %           Given n the length of the sub interval, if n-1 is divisible
    %           by 3, then the condition is met

    %%      Condition 2
    %           Given y as the vector of x_(n+1) - x_n points (the
    %           difference), then if the max value on that vecor is equal
    %           to the min value, then the condition is met
    %           What this does is checking that the vector x contains
    %           equally spaced points

    %%      Condition 3
    %           This one is an extension of condition 2, and it checks that
    %           the max value in y is equal to the min value of y, or at
    %           least the error between these two values is less than
    %           10^-12
    
    %% Get length of subinterval
    n = length(x);

    % Uniform spacing
    y = diff(x);
    if mod(n-1, 3) == 0 && max(y) == min(y) && abs(max(y)-min(y)) < 10e-12 % Then, use Simpson's Rule
        %% Solve Using Simpson's 3/8 rule
    
        % Calculate time step
        h = x(2)-x(1);

        % Length of Path
        N = length(x);

        % First, calculate the terms that are multiple of 3
        sum3 = 0; % sum of multiple of 3 terms
        sum2 = 0; % sum of multiple of 2 terms

        for k = 2:N-1
            if rem(k,3) == 0 % multiple of 2
                sum2 = sum2 + F(k)*cos(theta(k));
            else % multiple of 3
                sum3 = sum3 + F(k)*cos(theta(k));
            end
        end

        % Now, calculate approx
        approx = F(1)*cos(theta(1)) + F(N)*cos(theta(N)) + 3*sum3 + 2*sum2;

        % Multiply by the step
        approx = approx*3*h/8;

        flag = 2; % Flag 2 for Simpson Rule
    else
        %% Solve using Trapezoidal Rule
        % Calculate time step
        h = x(2)-x(1);

        % Length of Path
        N = length(x);

        % Now, calculate approx
        approx = F(1)*cos(theta(1)) + F(N)*cos(theta(N));
        for k = 2:N-1
            approx = approx + 2*F(k)*cos(theta(k));
        end

        % Multiply by the step
        approx = approx*h/2;

        flag = 3; % Flag 3 for Trapezoidal Rule
    end
    
    
    
end