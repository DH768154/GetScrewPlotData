function plotdata = GetScrewPlotData(T1,T2,min_ag,axis_length)
% From T1 to T2, Screw Motion
% 
% Input:
% T1, T2: 4*4 SE3 Matrix
% min_ag: 1*2 array, min_ag(1) is min step from T1 to T2; min_ag(2) is min
% step for 360 deg path
% axis_length: axis length scale, 1 is the same length as the screw pitch
%
% Output: 
% plotdata.ProjPt: screw motion path head and tail project on screw axis
% plotdata.Center: screw center
% plotdata.Frames: intermediate frames from T1 to T2
% plotdata.Path: path from T1 to T2
% plotdata.FPath: full 360 deg revolution path
% plotdata.Axis: screw axis
% plotdata.Pitch: pitch, 1/rad
% plotdata.Angle: screw rotate angle

%% Transform to World Frame
T12 = HomInv(T1) * T2;

%% SE3 to se3 
[W,V,mag] = ExpHomInv(T12);
uXi = [V;W];

%% se3 to screw parameter
pt = T12(1:3,4);
[h,q,mag] = ScrewXiInv(W,V,mag);

%% screw center and screw head and tail
HeadTail =  W*(W'*([zeros(3,1),pt]-q))+q;
HeadTail = HomTran(T1,HeadTail);
screwC = mean(HeadTail,2);

%% path and intermediate frames from T1 to T2
numag = ceil(mag/min_ag(1));
ag = linspace(0,mag,numag);
frames = pagemtimes(T1,ExpHom2(uXi*ag));
path = reshape(frames(1:3,4,:),3,[]);

%% full 360 deg revolution path
numag = ceil(mag/min_ag(2));
ag2pi = linspace(-pi,pi,numag)+mag/2;
frames_full = ExpHom2(uXi*ag2pi);
path_full = HomTran(T1,reshape(frames_full(1:3,4,:),3,[]));

%% screw axis line
w1 = HomTran(T1,[[0;0;0],W]);
w1 = w1(:,2)-w1(:,1);
L_axis = screwC+w1*[-1,1]*axis_length*abs(h)*pi;

%%
plotdata.ProjPt = HeadTail;
plotdata.Center = screwC;
plotdata.Frames = frames;
plotdata.Path = path;
plotdata.FPath = path_full;
plotdata.Axis = L_axis;
plotdata.Pitch = h;
plotdata.Angle = mag;
end