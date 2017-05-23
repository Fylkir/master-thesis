function xk1=jacobi(A,f,xk,w,it)

%FUNKCJA WYKONUJACA JEDNA ITERACJE METODY JACOBIEGO
%A - MACIERZ UKLADU
%f - WEKTOR PRAWYCH STRON
%xk - PRZYBLIZENIE K
%w - WSPOLCZYNNIK PODRELAKSACJI
%xk1 - PRZYBLIZENIE K+1

%ROZDZIEL A NA DIAGONALE I POZOSTALOSC
diagA = diag(A);
ldiagA = length(diagA);
D=sparse(1:ldiagA,1:ldiagA,diagA);
R=A-D;

xk1=xk;
%WYKONAJ ITERACJE
for i = 1:it
    xk1=jacobiIteration(D,R,f,xk1,w);
end