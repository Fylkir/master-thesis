clc;
% Wczytaj siatke

%[D,F,p,t]=diffusion2D_ver2();
%[D,F]=poisson2D(100,100,1,1,1,1);
[D,F]=poissonEq(2^13,0.001,60,60);
[u,r]=amgFMGnew(D,F,5,5);
%u=bicg(D,F,1e-6,100);
%u=D\F;
figure;
semilogy(r);
%contourf(times);
%[u1,r1]=amgFMG(D,F,3,2,5);
% WYSWIETL ROZWIAZANIE
figure
%displaySolution2D(p,t,u,'Interpolacja wygladzona na gesta siatke');
%hold on;
%plot(u);
%plot(0:1/(length(u1)-1):1,u1);
%plot(D\F);
