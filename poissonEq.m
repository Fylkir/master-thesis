function [A,f] = poissonEq(n,h, up, uk)
% FUNKCJA BUDUJACA MACIERZ I WEKTOR PRAWYCH STRON DLA ROWNANIA POISSONA 1D
% Z LICZBA PODZIALOW SIATKI ROWNA n, KROKIEM h ORAZ WARUNKAMI BRZEGOWYMI UP I UK
    


    % ZLOZENIE MACIERZY
    d=(1/h^2+1)*2*ones(1,n+1);
    d(1)=1;
    d(n+1)=1;
    D = sparse(1:n+1,1:n+1,d);
    du= -1/h^2*ones(1,n);
    du(1)=0;
    U = sparse(1:n,2:n+1,du,n+1,n+1);
    dl = -1/h^2*ones(1,n);
    dl(n)=0;
    L = sparse(2:n+1,1:n,dl,n+1,n+1);
    A = U+D+L;
    % WEKTOR PRAWYCH STRON
    % f=h^2*sin(linspace(-50,100,n+1))';
    f=ones(n+1,1);
    

    %f(1)=f(1)+up;
    %f(n+1)=f(n+1)+uk;
    f(1)=up;
    f(n+1)=uk;