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

%task12
sumDigs(X,Res):-sumDigs(X,Res,0),!.
sumDigs(0,Res,Res):-!.
sumDigs(X,Res,Cur):-
    X1 is X mod 10,
    (X1 > 5,NewRes is Cur+X1;NewRes is Cur),
    X2 is X div 10 , sumDigs(X2,Res,NewRes).

minDeldown(X,ResDel):-mindeldown(X,X,ResDel,9),!.
mindeldown(_,0,Res,Res):-!.
mindeldown(X,Del,Res,CurDel):-
    Del1 is Del mod 10,
    NextDel is Del div 10,
    (Del1\=1,non(Del1),0 is X mod Del1, Del1<CurDel, NewDel is Del1;NewDel is CurDel),
    mindeldown(X,NextDel,Res,NewDel).

maxdownN(X,Res,A):-maxDownN(X,X,Res,0,A),!.
maxDownN(_,0,Res,Res,_):-!.
maxDownN(X,D,Sum,CurDig,A):-D1 is D-1,
    (not(0 is D1 mod A) ,non(D1),D1>CurDig,g_c_d(D1,X,G),not(1 is G), NewCur is D1; NewCur is CurDig),
    maxDownN(X,D1,Sum,NewCur,A).
maxdeterm(X,Res):-minDeldown(X,G), maxdownN(X,Res,G).

res(X,Res):-sumDigs(X,Res1),maxdeterm(X,Res2), Res is Res1*Res2,!.

%task14 (1.9)
readL(0, []) :- !.
readL(I, [X|T]) :- write("input - "),read(X), I1 is I - 1, readL(I1, T).

writeL([]):-!.
writeL([X|T]):-write(X),nl, writeL(T).
listmin([H|T],Res):-listmin([H|T],Res,H).
listmin([],Res,Res):-!.
listmin([H|T],Res,Cur):-
    (H<Cur, NewH is H; NewH is Cur),
    listmin(T,Res,NewH).
count([H|T],Res,Marker):-count([H|T],Res,0,Marker).
count([],Res,Res,_):-!.
count([H|T],PreRes,Res,Marker):-
    (H==Marker, NewRes is Res+1;NewRes is Res),
    count(T,PreRes,NewRes,Marker).
countmin([H|T],Res):- listmin([H|T],Res1),count([H|T],Res,Res1).
newlist([H|T],X,Count,Numb):-newlist([H|T],X,0,Count,Numb).
add(E,[],[E]).
add(E,[H|T],[H|T1]):-add(E,T,T1).
newlist([],_,Count,Count,_):-!.
newlist([H|T],List,CurC,Count,Numb):-
   (H\=Numb, CurC\=Count,  add(H,List,NewList), NewCurc is CurC;(H==Numb, CurC\=Count, add(H,List,NewList),NewCurc is CurC+1 ;(CurC==Count,!))),
    newlist(T,NewList,NewCurc,Count,Numb).

reslist(X,Res):-countmin(X,Res1),listmin(X,Res2),newlist(X,Res,Res1,Res2).
