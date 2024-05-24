function [h,q,mag] = ScrewXiInv(varargin)

if nargin == 1
    Xi = varargin{1};
    v = Xi(1:3);
    w = Xi(4:6);
    nw = sqrt(sum(w.^2));

elseif nargin==3
    uw = varargin{1};
    uv = varargin{2};
    nw = varargin{3};
    w = uw * nw;
    v = uv * nw;
else
    error('wrong number of input')
end

if sum(w.^2)<=1e-10
    mag = sqrt(sum(v.^2));
else
    mag = nw;
end
h = transpose(w)*v/nw^2;
q = cross(w,v)/nw^2;


end