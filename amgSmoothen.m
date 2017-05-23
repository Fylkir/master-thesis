function Ps = amgSmoothen(P, Af)
n = size(Af,1);
invDiagA=sparse(1:n,1:n,1./diag(Af));
S=speye(n)-2/3*invDiagA*Af;
%Ps = (speye(n)-2/3*invDiagA*Af)*P;

Ps = S*P(:,2:end);
Ps=[P(:,1),Ps];