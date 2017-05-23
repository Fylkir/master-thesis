function u = MG1DV(As, F, Ps, Rs, u0, vd, vu)

w=0.667;
fiter = @jacobi;
% FUNKCJA WYKONUJACA JEDNO PRZEJSCIE "V" DLA ALGORYTMU MULTIGRID
% Na poziomie "0" (najgestsza siatka) aplikuje algorytm iteracyjny do
% rownania Au=f, na poziomach wyzszych (siatki rzadsze), aplikuje ten sam
% algorytm do rownania Ae=r, przy r wzi�tym z siatki g�stszej i poddanym
% restrykcji

%figure
%hold on;

% f - funkcja generujaca macierz i wektor prawych stron rownania
% u0 - przyblizenie startowe
% h - krok siatki
% lev - liczba poziomow, o ktore algorytm ma rozrzedzic siatke
% xl - lewy warunek brzegowy
% xr - prawy warunek brzegowy
% vd - liczba iteracji metody iteracyjnej po restrykcji (down)
% vu - liczba iteracji metody iteracyjnej po interpolacji (up)
% u - nowy wektor rozwiazan

lev = length(Ps);
% zainicjalizuj macierze, w ktorych beda przechowywane kolejne przyblizenia
% rozwiazania i prawych stron
B=cell(lev+1);
U=cell(lev+1);
%figure
%hold on;

% POZIOM 0

% wygeneruj macierz i wektor prawych stron do pierwszego kroku
A = As{1};
b = F;

% dopisz wektor prawych stron do macierzy, dla zachowania porzadku
% numeracji
B{1}=b;



% iteruj na przyblizeniu poczatkowym 

u=u0;
u=fiter(A,b,u,w,vu);


% dopisz wektor rozwiazania do macierzy
U{1}=u;
% POZIOM 1 DO LEV-1
% WYKONAJ PETLE RESTRYKCJI

for i = 1:lev-1
    
    % wyznacz wektor residuow
    r = b-A*u;
    
    % wykonaj restrykcje wektora residuow
    b=Rs{i}*r;
    
    % dopisz tak powstala prawa strone do macierzy
    B{i+1}=b;
    
    % zainicjalizuj rozwiazanie rownania Ae=r, wektorem e=0, dla skrocenia 
    % zapisu e oznaczono jako u
    u = zeros(size(b));
    
    % wyznacz macierz rownania
    A = As{i+1};
    
    % iteruj
    u=fiter(A,b,u,w,vd);
    
    % dopisz przyblizone rozwiazanie do macierzy
    U{i+1}=u;

end

% POZIOM NAJGLEBSZY - LEV

% wyznacz wektor residuow
r = b-A*u;

% wykonaj restrykcje wektora residuow
b=Rs{lev}*r;

% wygeneruj macierz rownania
A = As{lev+1};

%full(A)
% rozwiaz rownanie metoda dokladna
u=A\b;

% dokonaj interpolacji otrzymanego rozwiazania i dodaj do wektora
% przyblizen gestszej siatki.
U{lev}= U{lev} + Ps{lev}*u;
%plot(0:1/(length(u)-1):1,u);
%plot(0:1/(length(U{lev})-1):1,U{lev});
% WYKONAJ PETLE INTERPOLACJI OD POZIOMU LEV-1 DO POZIOMU 1

for i = lev-1:-1:1
    
    % wyznacz macierz ukladu
    A=As{i+1};
    
    % iteruj
    U{i+1}=fiter(A,B{i+1},U{i+1},w,vu);
    % zaktualizuj przyblizenie poczatkowe na wyzszej siatce o
    % zinterpolowany blad
    U{i}= U{i} + Ps{i}*U{i+1};
    
end

% POZIOM 0
A = As{1};
u = U{1};
u = fiter(A,B{1},u,w,vu);
%u = SOR(A,B{1},u,1.85,20);
