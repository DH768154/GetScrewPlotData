function varargout = ExpHomInv(T)

R = T(1:3,1:3);
[W,RotMag] = ExpRotInv(R);

if isa(W,'sym')
    I3 = sym(eye(3));
else
    I3 = eye(3);
end

if RotMag==0
    Mag = norm(T(1:3,4));
    if Mag == 0
        V = [0,0,0]';
    else
        V = T(1:3,4)/Mag;
    end
else
    M = (I3-R)*Hat3(W)+W*transpose(W)*RotMag;
    V = M\T(1:3,4);
    Mag = RotMag;
end

if nargout ==1 || nargout ==0
    varargout{1} = [V;W]*Mag;
elseif nargout ==3
    varargout{1} = W;
    varargout{2} = V;
    varargout{3} = Mag;
end

end