function [D,F,p,t] = diffusion2D()
% FUNKCJA SKLADAJACA MACIERZ ROWNANIA

clc;
clear;

[p,e,t] = importMeshGmsh('rozna_lambda.msh');
%hold on;
% Zloz macierz dyfuzji (z dyfuzyjnoscia 1)
D = assembleDiffusionMatrix2D(p,t,1e-2);
% Zloz wektor prawej strony ze zrodlem rownym 1
F = assembleScalarSourceTerm2D(p,t,-1);

% Narzuc zerowe warunki brzegowe
[D,F] = imposeScalarBoundaryCondition2D(p,e,D,F,[0 1 2 3],'value', 10);
%[D,F] = imposeScalarBoundaryCondition2D(p,e,D,F,[7 8 9 10],'robin',100,1);
%[D,F] = imposeScalarBoundaryCondition2D(p,e,D,F,[7 8 9 10],'value',10);
% Rozwiaz uklad rownan (w przyszlosci AMG :D)
%te=clock;
%u = D\F;

% Wyswietl rozwiazanie jako mape kolorow
% figure(2)
% displaySolution2D(p,t,u,'u');

% Wyswietl rozwiazanie w postaci 3-D (moze sie przydac nam pozniej do
% wizualizacji przebiegu bledu na roznych siatkach)
% figure(3)
% trisurf(t(1:3,:)',p(1,:)',p(2,:)',u)
% shading('interp')
% colormap('jet')
% colorbar
%axis equal
% zlim([0 0.1])