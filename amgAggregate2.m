function C = amgAggregate(M,epsilon)


n = size(M,1);

[neighbourhoods, neighbourhoodsOfNode] = amgFindNeigh(M,epsilon);
availNeighbourhoods = 1:n;
R = 1:n;

C = cell(n,1);
aggsOfNode = zeros(n,1);

j = 1;
k=1;





disp('Agrregation step one...');
C{1}=[];
while(any(availNeighbourhoods))
    j = j+1;
    
    while availNeighbourhoods(k)<1
        k=k+1;
    end
    Cj = neighbourhoods{availNeighbourhoods(k)};
    if length(Cj)<2
        C{1}=[C{1},Cj];
        aggsOfNode(Cj)=1;
        availNeighbourhoods(Cj)=0;
        j=j-1;
    else
    
    
        aggsOfNode(Cj)=j;
        R(Cj)=0;
        C{j} = Cj;
        excludedNeighbourhoods = [];
        for m = 1:length(Cj)
            excludedNeighbourhoods = [excludedNeighbourhoods neighbourhoodsOfNode{Cj(m)}];
        end
        availNeighbourhoods(excludedNeighbourhoods) = 0;
    end
    %disp(['j = ' num2str(j) ', pozostalo: ' num2str(length(availNeighbourhoods)) ' sasiedztw']);
    %disp(Cj);
end
disp('Done!');

Ct = C;
R=find(R);
Rt = R;
disp('Agrregation step two...');

l=0;
for i = R
    l=l+1;
    v=neighbourhoodsOfNode{i};
    for k=v
        agg=aggsOfNode(k);
        if agg>0
            Ct{agg}(end+1)=i;
            Rt(l) = 0;
            break;
        end
    end
    
end
R = find(Rt);
disp('Done');

disp('Agrregation step three...');
while ~isempty(R)
    i=R(1);
    v=neighbourhoodsOfNode{i};
    j=j+1;
    Ct{j}=intersect(R,v);
    R = setdiff(R,Ct{j});
    
end
disp('Done');
if length(Ct{1})<1
    Ct{1}=Ct{j};
    C=Ct(1:j-1);
else
    C = Ct(1:j);
end



end