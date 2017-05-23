function [] = displayNeigh2D(p, t, C)

% displayMesh2D - Display computational mesh in 2-D.
%
% This QuickerSim CFD Toolbox function displays a 2-D computational mesh.
%
% displayMesh2D(p, t)
%
% Input arguments:
% p - array of nodal coordinates (see help of the importMeshGmsh function
%     for details).
% t - array of finite elements (see help of the importMeshGmsh function for
%     details).
%
% Visit www.quickersim.com/cfd-toolbox-for-matlab/index for more info, help
% and support. Contact us by cfdtoolbox@quickersim.com
%
% See also: DISPLAYSOLUTION2D, IMPORTMESHGMSH.


nPnodes = max(max(t(1:3,:)));
hold on;
trisurf(t(1:3,:)',p(1,1:nPnodes)',p(2,1:nPnodes)',zeros(nPnodes,1),zeros(nPnodes,1))
%trisurf(t(1:3,:)',p(1,1:nPnodes)',p(2,1:nPnodes)',zeros(nPnodes,1),t(end,:))
axis equal
view([0 90])
xlabel('x')
ylabel('y')



for i=1:length(C)
    Ci=C{i};
    x=p(1,Ci)';
    y=p(2,Ci)';
    color = [rand(1,1), rand(1,1), rand(1,1)];
    scatter(x,y,'MarkerFaceColor', color, 'MarkerEdgeColor', color);
    bnd = boundary(x,y,0.9);
    plot(x(bnd),y(bnd),'Color', color,'Linewidth',2);
end


end