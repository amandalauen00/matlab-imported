function [flag, H] = progd820474(h0, T, d)
%   [flag, H]= progd820474(h0,T,d)
%   Author: Amanda Lauen
%   Date: November 5th 2021
%   Calculate the height of water left in the tank at the given time T with
%   a given initial height h0 and a initial diameter of the hole d.
%
%   Input
%       h0 = the initial height of the water given in meters
%       T = the length of time the tank is allowed to drain (measured in minutes)
%       d = the diameter of the hole in the bottom of the tank measured in centimeters
%
%   Outputs
%       flag = flag to signify program executed properly or not
%              flag = 0 --> the program runs without an issue
%              flag = 1 --> the values of h0 and d are not feasible and T
%              is less than 0
%              flag = 2 --> the T value is beyond the length of time it
%              takes to empty the tank
%
%       H = the height of water left in the tank at time T
%
%   Sample 
%       [flag, H]= progd820474(5,-100, 4.95);
%       [flag, H]= progd820474(5,200,4.95);
 
% Fixed Values
D = 6; % Diameter of the tank (m)
g = 9.81; % Acceleration due to gravity (m/s^2)
d = d/100; % changing given units (centimeters) to meters

%% Evaluation of time T0 taken to empty the tank
% This time T0 can be used to check if given time T is too large.

% Differential Equation
%     dh/dt = ((-d.^2*sqrt(2*g*h)/(4*(h*D)-h.^2))

%  d is the diameter of the hole in the bottom of the tank, g is the 
%  acceleration due to gravity, h is the height of the water in the
%  tank, and D is the diameter of the tank.

% Solving differential equation, we get following relation: 
%     8/5*(h^2.5-h0^2.5)-8*D/3*(h^1.5-h0^1.5) = d^2*sqrt(2*g)*t
% From the above relation, we can find the time T taken to empty the tank

T0 = ((8/3*D*h0^1.5 - 8/5*h0^2.5)/(d*d*sqrt(2*g)))/60; % T0 is in minutes

% Check that the values of h0 and d are feasible
%   If these values are not feasible then flag = 1 and H = -99. 
%   In addition, T must be greater than zero and if T is not greater than 
%   zero then flag = 1 and H = -99
if T < 0 || h0 > D || d > D
    flag = 1;
    H = -99;
    %fprintf('Please check the inputs');
    
% If T is a time that is beyond the length of time it takes to empty the tank 
% then flag = 2 and H = 0.   
elseif T > T0
    flag = 2;
    H = 0;
    %fprintf('The tank will be empty before the given time');
    
% Otherwise height can be calculated at every step of minutes.
else
    flag = 0;
    [t, h] = ode45(@(t,h) -(d*d*sqrt(2*g*h))/(4*(h*D-h*h)),(0:T*60), h0);
    H = h(T*60);
    plot(t, h, 'b'); % Plot the results if feasible
    title('height of water left in the tank with time')
    xlabel('time in seconds')
    ylabel('height of water in the tank in meters')
    msg = sprintf('it will take %d minutes to empty the tank.', T0);
    fprintf(msg);
    % disp(msg);
    
end
%% Validation of Programm
% The solution of the differential equation as mentioned above 
% can be used to validate the program.
% Error value E can be defined as 
%          E = 8/5*(h^2.5-h0^2.5)-8*D/3*(h^1.5-h0^1.5) - d^2*sqrt(2*g)*t;
% which can evaluated at any time value.
% So at time  = T minute and h = H, error E is 
%          E = 8/5*(H^2.5-h0^2.5)-8*D/3*(H^1.5-h0^1.5) -
%          d^2*sqrt(2*g)*T*60;
end