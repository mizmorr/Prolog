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