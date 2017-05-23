function P = amgTentProlon(C, n)
m=length(C);
is = zeros(n,1);
js = zeros(n,1);
k=1;
for j=1:length(C)
   k_next = k+length(C{j})-1;
   is(k:k_next)=C{j};
   js(k:k_next)=j;
   k = k_next+1;
end

is=is(1:k-1);
js=js(1:k-1);
vs=ones(length(is),1);
P=sparse(is,js,vs,n,m);