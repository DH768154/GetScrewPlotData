function pts_new = HomTran(T,pts)
% Homogeneous Transformation for points, align size
% T: 4*4*p SE3 Matrix
% pts: 3*n*p Column Vectors
% if pts is 3*n and T is 4*4*p, each page, T(:,:,i)*pts

p = size(T,3);

if p==1
    pts_new = T(1:3,1:3)*pts + T(1:3,4);
else
    pts_new = pagemtimes(T(1:3,1:3,:),pts) + T(1:3,4,:);
end
% pts = [pts;ones(1,size(pts,2))];
% pts_new = T*pts;
% pts_new = pts_new(1:3,:);
end