function [flag, b, r] = proga820474(x)
%   [flag, b,r]= proga820474(x)
%   Author: Amanda Lauen
%   Date: September 10, 2021
%   Calculate a binary string of length 12 that corresponds to the closest
%   binary bit string to a given decimal number.
%
%   Input
%       x = a decimal number (greater than or equal to 2^(-12) and less 
%           than or equal to the largest possible number that can be 
%           represented via a 12 bit string.
%
%   Outputs
%       flag = flag to signify program executed properly or not
%              flag = 0 --> output is fine
%              flag = 1 --> x is outside the interval
%       b = a column vector binary string with length 12
%       r = remainder term since it's possible that we cannot represent
%           x exactly with a binary string.

%   Sample 
%       [flag, b, r]= proga820474(4);
%       [flag, b, r]= proga820474(255);

n = 12; % Number of bits

% Calcualte the bounds of input
xmin = pow2(-12); %2^(-12)
xmax = sum(2.^(-1:-1:-n)); %Largest possible number that can be represented
                           %via a 12 bit string
                           
% Check if the provided input, x, is out of bounds
if (x < xmin) || (x > xmax)
    flag = 1;   
    b = -1; % Need to return values for output 
    r= -9;
    return;  % Return stops the program and returns to prompt
end

% If the provided input, x, is not out of bounds
flag = 0;
b = NaN(12,1);
r = x;
for k = 1:n
    x2 = r*2;
    b(k) = fix(x2);
    r = x2 - b(k);
end

% Calculate the decomal value of the found binary string
xc = 2 .^(-1:-1:-n)* b;
r = x - xc;
