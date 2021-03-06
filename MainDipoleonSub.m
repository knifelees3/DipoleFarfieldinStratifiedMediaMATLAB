
% Run the structure set and Green Tensor program
BasicStructureSet;
ShowStructure(DinLayer);
ShowStructure(DinLayerRever)

%%  define the dipole moment
px=[1 0 0];
py=[0 1 0];
pz=[0 0 1];

%% Calculate the far field for dx,dy,zd dipole 
% objective=1 means the pattern in objective
% objective=0 means the pattern in far field sphere surface
objective=0;
patdxUp=Cal_Pattern_1DDipole(px,DinLayer,objective);
patdyUp=Cal_Pattern_1DDipole(py,DinLayer,objective);
patdzUp=Cal_Pattern_1DDipole(pz,DinLayer,objective);
patdxDn=Cal_Pattern_1DDipole(px,DinLayerRever,objective);
patdyDn=Cal_Pattern_1DDipole(py,DinLayerRever,objective);
patdzDn=Cal_Pattern_1DDipole(pz,DinLayerRever,objective);


ux_grid=DinLayer.ux_grid;
uy_grid=DinLayer.uy_grid;

figure()
subplot(231)
pcolor(ux_grid,uy_grid,patdxUp);shading interp;colormap('jet');xlabel('ux');ylabel('uy');title('Dx Up');
subplot(232)
pcolor(ux_grid,uy_grid,patdyUp);shading interp;colormap('jet');xlabel('ux');ylabel('uy');title('Dy Up');
subplot(233)
pcolor(ux_grid,uy_grid,patdzUp);shading interp;colormap('jet');xlabel('ux');ylabel('uy');title('Dz Up');
subplot(234)
pcolor(ux_grid,uy_grid,patdxDn);shading interp;colormap('jet');xlabel('ux');ylabel('uy');title('Dx Down');
subplot(235)
pcolor(ux_grid,uy_grid,patdyDn);shading interp;colormap('jet');xlabel('ux');ylabel('uy');title('Dy Down');
subplot(236)
pcolor(ux_grid,uy_grid,patdzDn);shading interp;colormap('jet');xlabel('ux');ylabel('uy');title('Dz Down');
sgtitle('Dipole on Sub');
set(gcf,'position',[100 100 1200 600]);
print('./PatternDipoleonSub.png','-dpng');

num_theta_in=100;
num_phi_in=100;
theta_in_mat=linspace(0,pi/2,num_theta_in);
phi_in_mat=linspace(0,pi/2,num_phi_in);
[theta_grid_in,phi_grid_in]=meshgrid(theta_in_mat,phi_in_mat);
kx_grid_in=sin(theta_in_grid).*cos(phi_grid_in);
ky_grid_in=sin(theta_in_grid).*sin(phi_grid_in);
krho=DinLayer.krho_grid;
[nPrhodxUp,nPphidxUp]=Transform_RhoPhi_Interp(ux_grid,uy_grid,kx_grid_in,ky_grid_in,patdxUp,krho);
[nPrhodyUp,nPphidyUp]=Transform_RhoPhi_Interp(ux_grid,uy_grid,kx_grid_in,ky_grid_in,patdyUp,krho);
[nPrhodzUp,nPphidzUp]=Transform_RhoPhi_Interp(ux_grid,uy_grid,kx_grid_in,ky_grid_in,patdzUp,krho);
[nPrhodxDn,nPphidxDn]=Transform_RhoPhi_Interp(ux_grid,uy_grid,kx_grid_in,ky_grid_in,patdxDn,krho);
[nPrhodyDn,nPphidyDn]=Transform_RhoPhi_Interp(ux_grid,uy_grid,kx_grid_in,ky_grid_in,patdyDn,krho);
[nPrhodzDn,nPphidzDn]=Transform_RhoPhi_Interp(ux_grid,uy_grid,kx_grid_in,ky_grid_in,patdzDn,krho);

figure()
subplot(231)
plot(theta_in_mat,nPrhodxUp);hold on;plot(phi_in_mat,nPphidxUp);legend('\theta distribution','\phi distribution');
title('Dx Up');xlabel('\theta or \phi');ylabel('distribution');
subplot(232)
plot(theta_in_mat,nPrhodyUp);hold on;plot(phi_in_mat,nPphidyUp);legend('\theta distribution','\phi distribution');
title('Dy Up');xlabel('\theta or \phi');ylabel('distribution');
subplot(233)
plot(theta_in_mat,nPrhodzUp);hold on;plot(phi_in_mat,nPphidzUp);legend('\theta distribution','\phi distribution');
title('Dz Up');xlabel('\theta or \phi');ylabel('distribution');
subplot(234)
plot(theta_in_mat,nPrhodxDn);hold on;plot(phi_in_mat,nPphidxDn);legend('\theta distribution','\phi distribution');
title('Dx Dn');xlabel('\theta or \phi');ylabel('distribution');
subplot(235)
plot(theta_in_mat,nPrhodyDn);hold on;plot(phi_in_mat,nPphidyDn);legend('\theta distribution','\phi distribution');
title('Dy Dn');xlabel('\theta or \phi');ylabel('distribution');
subplot(236)
plot(theta_in_mat,nPrhodzDn);hold on;plot(phi_in_mat,nPphidzDn);legend('\theta distribution','\phi distribution');
title('Dz Dn');xlabel('\theta or \phi');ylabel('distribution');
set(gcf,'position',[100 100 1200 600]);
print('./PatternDipoleonSubRhoPhiDistribution.png','-dpng');