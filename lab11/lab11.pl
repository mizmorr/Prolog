man(voeneg).
man(ratibor).
man(boguslav).
man(velerad).
man(duhovlad).
man(svyatoslav).
man(dobrozhir).
man(bogomil).
man(zlatomir).

woman(goluba).
woman(lubomila).
woman(bratislava).
woman(veslava).
woman(zhdana).
woman(bozhedara).
woman(broneslava).
woman(veselina).
woman(zdislava).

parent(voeneg,ratibor).
parent(voeneg,bratislava).
parent(voeneg,velerad).
parent(voeneg,zhdana).

parent(goluba,ratibor).
parent(goluba,bratislava).
parent(goluba,velerad).
parent(goluba,zhdana).

parent(ratibor,svyatoslav).
parent(ratibor,dobrozhir).
parent(lubomila,svyatoslav).
parent(lubomila,dobrozhir).

parent(boguslav,bogomil).
parent(boguslav,bozhedara).
parent(bratislava,bogomil).
parent(bratislava,bozhedara).

parent(velerad,broneslava).
parent(velerad,veselina).
parent(veslava,broneslava).
parent(veslava,veselina).

parent(duhovlad,zdislava).
parent(duhovlad,zlatomir).
parent(zhdana,zdislava).
parent(zhdana,zlatomir).
father(X,Y):- parent(X,Y),man(X).
father(X):- father(Z,X), print(Z).

wife(X,Y):- man(Y), woman(X), (parent(X,Y);parent(Y,X)).
wife(X):- wife(Z,X), print(Z).

grand_da(X,Y):- father(Y,Z),parent(Z,X), woman(X).
grand_dats(X):-grand_da(Z,X),print(Z),nl,fail.

mother(X,Y):- woman(X),parent(X,Y).
grandma(X,Y):- mother(X,Z),(parent(Z,Y);parent(Y,Z)).
grandma_and_son(X,Y):- (grandma(X,Y), man(Y));(man(X),grandma(Y,X)).
multup(0, 1):-!.
multup(Num, Res):- Digit is Num mod 10, NextNum is Num div 10,
  multup(NextNum, Z),
  Res is Z * Digit.
multvniz(X,ResMult):-multvniz(X,ResMult,1).
multvniz(0,Res,Res):-!.
multvniz(X,ResMult,PrevMult):- X1 is X mod 10, CurMult is PrevMult*X1,
X2 is X div 10, multvniz(X2,ResMult,CurMult).

fibup(1,1):-!.
fibup(2,1):-!.
fibup(N,X):-N1 is N-1, fibup(N1,X1), N2 is N-2, fibup(N2,X2), X is X1+X2.

thdel(X):-X1 is X mod 3, X1\=0.
maxdigUp(0,1):-!.
maxdigUp(N,CurDig):-
    X1 is N div 10,
    maxdigUp(X1,M1),
    M2 is N mod 10,
    (M2 > M1, thdel(M2), CurDig is M2; CurDig is M1).

maxDigDown(N,Res):-maxDigDown(N,Res,0).
maxDigDown(0,R,R):-!.
maxDigDown(N,Res,Prev):- N1 is N mod 10,
    (thdel(N1), N1 > Prev, NewC is N1; NewC is Prev),
    N2 is N div 10, maxDigDown(N2,Res,NewC).

fibDown(1,1):-!.
fibDown(2,1):-!.
fibDown(N,X):-fibDown(N,X,1,1,2).
fibDown(A,B,_,B,A):-!.
fibDown(A,B,C,D,E):- T is C+D, E1 is E+1, fibDown(A,B,D,T,E1).
