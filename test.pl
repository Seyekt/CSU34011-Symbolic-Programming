% Assignment 1

numeral(0).
numeral(succ(X)) :- numeral(X).

pterm(null).
pterm(f0(X)) :- pterm(X).
pterm(f1(X)) :- pterm(X).

% Q1

incr(null, f1(null)).
incr(f0(P1), f1(P1)).
incr(f1(P1), f0(P2)) :- incr(P1,P2).

% Q2

legal(f0(null)).
legal(f1(null)).
legal(P1) :- legal(P2), incr(P2,P1).
incrR(X, Y) :- legal(X), incr(X, Y).

% Q3

add(f0(null), P1, P1).
add(P1, P2, P3) :- incr(X, P1), add(X, P2, Y), incr(Y, P3).

% Q4

mult(null, _, f0(null)).								
mult(_, null, f0(null)).
mult(f0(X), Y, Z):- mult(X, f0(Y), Z).
mult(f1(X), Y, Z):- mult(X, f0(Y), P1), add(P1, Y, Z).

% Q5

revers(P, RevP) :- revers(P, null, RevP).
revers(null, P, P).
revers(f0(P), X, RevP) :- revers(P, f0(X), RevP).
revers(f1(P), Y, RevP) :- revers(P, f1(Y), RevP).

% Q6

normalize(null, f0(null)).
normalize(f0(null), f0(null)).
normalize(P1, P2) :- revers(P1, P3), normalize2(P3, X), revers(X, P2).
normalize2(f1(A), f1(A)).
normalize2(f0(A), X) :- normalize2(A, X).

% TESTS
% test add inputting numbers N1 and N2
testAdd(N1,N2,T1,T2,Sum,SumT) :- numb2pterm(N1,T1), numb2pterm(N2,T2),
add(T1,T2,SumT), pterm2numb(SumT,Sum).
% test mult inputting numbers N1 and N2
testMult(N1,N2,T1,T2,N1N2,T1T2) :- numb2pterm(N1,T1), numb2pterm(N2,T2),
mult(T1,T2,T1T2), pterm2numb(T1T2,N1N2).
% test revers inputting list L
testRev(L,Lr,T,Tr) :- ptermlist(T,L), revers(T,Tr), ptermlist(Tr,Lr).
% test normalize inputting list L
testNorm(L,T,Tn,Ln) :- ptermlist(T,L), normalize(T,Tn), ptermlist(Tn,Ln).
% make a pterm T from a number N numb2term(+N,?T)
numb2pterm(0,f0(null)).
numb2pterm(N,T) :- N>0, M is N-1, numb2pterm(M,Temp), incr(Temp,T).
% make a number N from a pterm T pterm2numb(+T,?N)
pterm2numb(null,0).
pterm2numb(f0(X),N) :- pterm2numb(X,M), N is 2*M.
pterm2numb(f1(X),N) :- pterm2numb(X,M), N is 2*M +1.
% reversible ptermlist(T,L)
ptermlist(null,[]).
ptermlist(f0(X),[0|L]) :- ptermlist(X,L).
ptermlist(f1(X),[1|L]) :- ptermlist(X,L).
