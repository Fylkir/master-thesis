function [neigh,neighOfNode] = amgFindNeigh(A,epsilon)
    n = size(A,1);
    neigh = cell(n,1);
    neighOfNode = cell(n,1);
    neighOfNodeCount = zeros(n,1);
    
    diagA=diag(A);
    [is,js,vals]=find(A);
    
    nonzerosInRow = cell(n,1);
    nonzeroCount = zeros(n,1);
    
    nonzerosInRow{1} = zeros(500);
    for i = 1:n
        nonzerosInRow{i} = zeros(30);
        neighOfNode{i} = zeros(20);
    end
    for k=1:length(is)
        i = is(k);
        nnzc = nonzeroCount(i) + 1;
        nonzeroCount(i) = nnzc;
        nonzerosInRow{i}(nnzc) = k;
    end
    for i = 1:n
        nonzerosInRow{i} = nonzerosInRow{i}(1:nonzeroCount(i));
    end  
    
    
    
    disp('Wyznaczam strongly coupled neighbourhoods...');
    for i = 1:n
        indices = nonzerosInRow{i};
        nonzeroJs=js(indices);
        nonzeroVec = vals(indices);
        nonzerosOfDiag=diagA(nonzeroJs);
        cmpEl=A(i,i);
        
        v = amgStrongConnection(nonzeroVec,nonzerosOfDiag, cmpEl, epsilon);
        
        ngh = nonzeroJs(v);
        neigh{i} = ngh;
        for j = ngh'
            nnoc = neighOfNodeCount(j) + 1;
            neighOfNodeCount(j) = nnoc;
            neighOfNode{j}(nnoc) = i;
        end
        
    end 
    for i = 1:n
        neighOfNode{i} = neighOfNode{i}(1:neighOfNodeCount(i));
    end
        
