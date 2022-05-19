%task11
even(X):-X1 is X mod 2, X1==0.
non(X):-X\=0.
g_c_d(X,Y,Res):-
    X1 is X mod Y,
    Y1 is Y mod X,
    (X1 == 0 ,!, Res is Y;
    Y1 ==0,!,Res is X;
    X>Y, g_c_d(X1,Y,Res);
    g_c_d(X,Y1,Res)).
sumUp(X,Sum):-sumUp(X,X,Sum),!.
sumUp(_,0,0):-!.
sumUp(X,Del,Sum):-D1 is Del-1, sumUp(X,D1,NewSum),
    (non(D1),even(D1),g_c_d(D1,X,Res),1 is Res, Sum is NewSum+1; Sum is NewSum).

sumdown(X,Res):-sumDown(X,X,Res,0),!.
sumDown(_,0,Res,Res):-!.
sumDown(X,D,Sum,CurSum):-D1 is D-1,
    (non(D1),even(D1),g_c_d(D1,X,G),1 is G, NewSum is CurSum+1; NewSum is CurSum),
    sumDown(X,D1,Sum,NewSum).
