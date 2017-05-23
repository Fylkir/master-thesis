function [A,b]=poisson2D(nx,ny,ux0,uxn,uy0,uyn)

a=1;
b=1;
hx=0.1;
hy=0.1;
Cy=-b/(hy^2);
Cx=-a/(hx^2);
Cc=-2*(Cx+Cy);


Bx0=diag(ones(nx,1));
By=Cy*ones(nx,1);
By(1)=0;
By(end)=0;
By=diag(By);
Bxd=Cc*ones(nx,1);
Bxl=Cx*ones(nx-1,1);
Bxu=Cx*ones(nx-1,1);


Bxd(1)=1;
Bxd(end)=1;
Bxu(1)=0;
Bxl(end)=0;

Bx =gallery('tridiag',Bxl,Bxd,Bxu);

A=zeros(nx*ny);
A(1:nx,1:nx)=Bx0;
A((ny-1)*nx+1:end,(ny-1)*nx+1:end)=Bx0;

for i=1:ny-2
    A(i*nx+1:(i+1)*nx,i*nx+1:(i+1)*nx )=Bx;
    A(i*nx+1:(i+1)*nx,(i-1)*nx+1:i*nx)=By;
    A(i*nx+1:(i+1)*nx,(i+1)*nx+1:(i+2)*nx)=By;
end

b=ones(nx*ny,1);
b(1:nx)=ux0*ones(nx,1);

b(end-nx+1:end)=uxn*ones(nx,1);



