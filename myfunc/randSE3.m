function Rt = randSE3(rot,tran,varargin)
% Generate a random SE3 transformation
% v2: change randSO3 method, remove bias, also support vectorize
% calculation
%
% rot: +-rotation range [rad]
% tran: +-translation range [m]

if nargin == 3
    num = varargin{1};
else
    num = 1;
end


R = randSO3(rot,num);
t = (rand(3,num)*2-1);
t = t./sqrt(sum(t.^2))*tran;
Rt = R2T(R,t);

end