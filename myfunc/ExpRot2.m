function R = ExpRot2(xi)
% xi is 3xn vector, return 3x3xn Rotation Matrix
% Replace ExpRot(w,theta), which only deal with single rotation
% Delete expm method, that can just written as expm(Hat3(xi))
% expm dose not support 3D Matrix

%%
theta = sqrt(sum(xi.^2));
w = xi./theta;
w(:,theta==0) = 0;
p = size(xi,2);
if size(xi,1)~=3
    error('xi need to be 3xn vector')
end

if isa(xi,'sym') && p>1
    error('Symbolic can only take 3*1 or 1*3 vector')
end
%%

if p==1

    if isa(xi,'sym')
        Imx = sym(eye(3));
    else
        Imx = eye(3);
    end

    if theta == 0
        R = Imx;
    else
        R = Imx + sin(theta)*Hat3(w) + ...
            (1-cos(theta))*Hat3(w)^2;
    end
%%
else

    R = NaN(3,3,p);
    ind = theta==0;
    if sum(ind)~=0
        R(:,:,ind) = eye(3).*ones(1,1,sum(ind));
    end

    ag = reshape(theta,1,1,p);
    ag = ag(~ind);
    
    R(:,:,~ind) = eye(3).*ones(1,1,sum(~ind))+sin(ag).*Hat3(w(:,~ind))+...
        (1-cos(ag)).*pagemtimes(Hat3(w(:,~ind)),Hat3(w(:,~ind)));
end

end