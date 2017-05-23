function [u,res] = amgFMGnew(A,F,vd, vu)

% ALGORYTM FULL ALGEBRAIC MULTIGRID WYKONUJACY NASTEPUJACA SCIEZKE
%
%                                                       
%                                               /\        / ... *        
%                                /\      / ... /  \      /            
%                  /\    / ...  /  \    /          \    /            
%        /\  / .../  \  /           \  /            \  /
%       *  \/         \/             \/              \/

% A - macierz ukladu
% F - wektor prawych stron
% lev - liczba poziomow, o ktore algorytm na rozrzedzic siatke
% vd - liczba iteracji metody iteracyjnej po restrykcji (down)
% vu - liczba iteracji metody iteracyjnej po interpolacji (up)
% u - rozwiazanie

Ps = cell(1,1);
As = cell(1,1);
Fs = cell(1,1);
Rs = cell(1,1);
As{1} = A;
Fs{1} = F;

%WYGENERUJ OPERATORY INTERPOLACJI I RESTRYKCJI
i=0;
crsngStopCond = 2000;
while crsngStopCond > 500
    i=i+1;
    epsilon = 0.08*(.5)^(i-1);
    % epsilon = 0.16;
    [P,R]=amgSmoothedAggOperators(As{i},epsilon);
    Ps{i}=P;
    Rs{i}=R;
    As{i+1} = R*As{i}*P;
    Fs{i+1} = R*Fs{i};
    
    disp(['Matrix size after aggregation no ', num2str(i),' : ',num2str(size(R,1))]);
    crsngStopCond = size(R,1);
end



% WYKONUJ ALGORYTM V AZ DO UZYSKANIA ZBIEZNOSCI
%disp('Nested algorithm finished. Proceeding to V algorithm')


% licznik iteracji
it=0;


% ustaw wymagany do zbieznosci poziom residuow
tol=10^(-log2(length(F))/2);
r=norm(F);
%tol=100;
res = r;
% wykonuj algorytm v, dopoki r>tol

%u = linspace(1000,100,length(F))';
u = zeros(length(F),1);
figure
hold on;

while r>tol
%for i = 1:10
    u=MG1DV(As, F, Ps, Rs, u, vd, vu);
    r = norm(F-A*u);
    res=[res,r];
    it=it+1;
    disp(['Finished V no ', num2str(it)])
    disp(['Res = ', num2str(r)]);
    %figure
    %displaySolution2D(p,t,u,'Interpolacja wygladzona na gesta siatke');
    plot(0:1/(length(u)-1):1,u);
 end
