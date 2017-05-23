function [P,R] = amgSmoothedAggOperators(M,epsilon)

C = amgAggregate2(M,epsilon);
Pt = amgTentProlon(C,size(M,1));
% Mf = amgFilter(M,size(M,1));
P = amgSmoothen(Pt,M);

R=P';