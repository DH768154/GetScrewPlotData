function T = ExpHom2(Xi)
% se3 to SE3, screw motion to 

if size(Xi,1)~=6
    error('6*n column vector required')
end

%%
W = Xi(4:6,:); % Axis * Mag
mag = sqrt(sum(W.^2));
w = W./mag; % Unit Vector for Axis
v = Xi(1:3,:)./mag;
w(:,mag==0) = 0;
v(:,mag==0) = 0;

p = size(Xi,2);
if isa(w,'sym') && p>1
    error('Symbolic can only take 6*1 vector')
end

%%
R = ExpRot2(W);
%%
% SE(3)


if isa(Xi,'sym')
    I3 = sym(eye(3));
    T = sym(eye(4));
else
    I3 = eye(3);
    T = eye(4);
end
%%
if p~=1
    T = eye(4).*ones(1,1,p);
    pt1 = pagemtimes((I3-R),pagemtimes(Hat3(w),reshape(v,3,1,p)));
    pt2 = pagemtimes(reshape(w,3,1,p),pagetranspose(reshape(w,3,1,p)));
    pt3 = reshape(v,3,1,p);
    Trans = pt1 + pagemtimes(pt2,pt3).*reshape(mag,1,1,p);
    T(1:3,1:3,:) = R;
    T(1:3,4,:) = Trans;

else
    
    mag = reshape(mag,1,1,p);
    Trans = (I3-R)*cross(w,v)+w*transpose(w)*v*mag;
    T(1:3,1:3) = R;
    T(1:3,4) = Trans;

end