function R = randSO3(rot,varargin)
% Generate a random SO3 transformation

if nargin == 2
    num = varargin{1};
else
    num = 1;
end

%% Random Dirction

theta = acos(rand(1,num)*2-1);
phi = rand(1,num)*2*pi;

dirc = [sin(theta).*cos(phi);...
        sin(theta).*sin(phi);...
        cos(theta)];

%% Angle

ag = rot*(rand(1,num)*2-1);

%%

%% Axis Angle

R = ExpRot2(dirc.*ag);

end