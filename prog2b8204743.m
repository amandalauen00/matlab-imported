function [flag, approx] = progb820474(f,a,b,tol)
%   [flag, b,r]= proga820474(x)
%   Author: Amanda Lauen
%   Date: October 1, 2021
%   Description: 
%
%   Input
%       f = an annonymous function supplied by the user
%       a = represents the x0 term respectfully, given by user
%       b = represents the x1 term, respectfully, given by user
%       tol = stoppong tolerance where the algorithm stops when the
%       function is less than the tolerance
%
%   Outputs
%       flag = flag to signify program executed properly or not
%              flag = 0 --> program runs without error
%              flag = 1 --> input is out of range
%              flag = 2 --> the algorithm fails to converge
%       approx = approximation calculated using the Secant Method

%   Sample 
%       [flag, approx]= progb820474();
%       [flag, approx]= progb820474();

% Check that the bounds of the problem are correct
if b <= a
    flag = 1;
    approx = -99;
    return;
end 
% Secant Method Code:
%       f = @(x) function
%       x = 1.1:0.1:5; --> Range
%       y = f(x);
%       plot(x,y);
%       x0 = ____;
%       x1 = x0+f(x0);
%       x2 = x1-f(x1*(x1-x0)/(f(x1-f(x0))
%       x0 = x1;
%       x1=x2; --> Update
%   Repeat this step over and over to see if it is converging or not
%       x2 = x1-f(x1*(x1-x0)/(f(x1-f(x0))
%       x0 = x1;
%       x1=x2; --> Update

% MAKE A MAX ITERATION (Choose 101) --> Check to see if it converges
%       To make it, count each iteration within a loop (for loop to make
%       sure it doesn't become an infinite loop)
%       If the algorithm diverges, then flag = 2;
%       Store the different variables to distinguish them; determine if
%       they are next to each other; if x1-x0 bounces around or oscillates 
%       between two values, then it diverges (flag 2)
%   Convergence/Divergence test on functions (Review from prev math
%   classes)
%       If x0 less than or equal to x1 and the summation of x1 is
%       convergence, then x0 is convergent (if greater than, they diverge)
%       

% Notes for Overleaf
%   How I validated that my program giving accurate calculation
%   Check to see if f(x) = 0 exists
%   Check to see if the function is a feasable solution
%   Program should only return the output variables and should not output or
%   print anything else

% Notes from Riley
%   Make judgement calls.
%   Don't have to check if letters are entered or not
%   All numbers are coming in, no tests
%   All functions are coming in, no tests
%   If a and b are bad guesses, it diverges/ don't worry about bad inputs
%   for a and b
%   How to detect it converges or not
%       Use while loop
%       Stop criteria: abs(b-a)/abs(b) < tol;
%       Not Converging: if you go 1000 iterations and it's greater than
%       tol, it diverges
%       What is a good cap for this? --> Have to defend it in the report
%       Counting approach is better than going off to infinity
%   a and b have to be close enough to the root
%   What to do if root is close or equal to zero: Have to discuss that in
%   the report.  Have a fail safe to stop the program.
%   Convergence: Superlinear or slightly off of linear
%   Note: The questions on existence of a root and checking of a solution
%   os feasible are discssion items for the report and they are not PROGRAM
%   SPECIFICATIONS: DO NOT CODE THIS. REPORT ON THIS ONLY!!!!!!
%       Where to get the root:  answer, how do you know it is feasible?


%% We define a maximum number of iterations, initial error and initial flag
max_iters = 500; % 500 iterations
error = Inf; % initial error

flag = 0; % runs without errors

approx =f(a);

%% Begin with Secant Method Algorithm

n = 1; % iterations counter
while error >= tol % execute algorithm while the error is higher than the tolerance

    x0 = a;
    x1 = b;
    x2 = x1 - (x1-x0)*f(x1) / (f(x1)-f(x0)); % calculate x2
    
    aold = a;
    bold = b;
    % Update
    a = x1;
    b = x2;
    
    error = abs(b-a)/abs(a);
	%% Enable the following line if you want to check the error per iteration
%     fprintf("Iter = %d, aold = %.4f, bold = %.4f, x2 = %.4f, anew = %.4f, bnew = %.4f, error = %.8f\n", n, aold, bold, x2, a, b, error);
%     fprintf("Iteration %d, error: %.8f\n", n, error);
    
    % Increment step
    n = n + 1;

    approx = b;
    
    % If the number if iterations reaches the max. number of iterations
    % allowed, it means that the problem did not find a solution
    if n >= max_iters 
        flag = 2;
        break;
    end
    
end

