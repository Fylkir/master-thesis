function v = amgStrongConnection(nonzeroVec, nonzerosOfDiag, cmpEl, epsilon)

v = find(abs(nonzeroVec)>=epsilon*sqrt(cmpEl*nonzerosOfDiag));

end