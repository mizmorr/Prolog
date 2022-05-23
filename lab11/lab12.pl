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

countminAndMin([H|T],Res,Min):- listmin([H|T],Min),count([H|T],Res,Min).
newlist(X,Res,Count,Numb):-newlist(X,Res,0,Count,Numb,[]).
add([],[H|T],[H|T]):-!.
add(E,[],[E]).
add(E,[H|T],[H|T1]):-add(E,T,T1).
newlist(_,Res,Count,Count,_,Res):-!.
newlist([H|T],Res,CurC,Count,Numb,List):-
(H\=Numb, CurC\=Count, add(H,List,NewList), NewCurc is CurC;(H==Numb, CurC\=Count, add(H,List,NewList),NewCurc is CurC+1 ;(CurC==Count,!))),
newlist(T,Res,NewCurc,Count,Numb,NewList).
wouthead(X,Res):-wouthead(X,Res,[]),!.
wouthead([],Res,Res):-!.
wouthead([_|T],Res,Preres):-!,add(Preres,T,Resl), wouthead([],Res,Resl).
reverse2(L,X):-reverse2(L,X,[]),!.
reverse2([],Z,Z):-!.
reverse2([H|T],X,Acc):-reverse2(T,X,[H|Acc]).
reslist(List,Res):-countminAndMin(List,Count,Min),newlist(List,NewL,Count,Min),reverse2(NewL,RevL),wouthead(RevL,WheadL),reverse2(WheadL,Res).

%task15 (1.12)
listmax([H|T],Res):-listmax([H|T],Res,H).
listmax([],Res,Res):-!.
listmax([H|T],Res,CurMax):-
( H>CurMax, NewMax is H; NewMax is CurMax),
listmax(T,Res,NewMax).
head(X,Res):-head(X,Res,0).
head([],Head,Head):-!.
head([H|_],Res,PreRes):-PreRes is 0,NewRes is H, head([],Res,NewRes).
mid(L,I1,I2,R):-mid(L,I1,I2,R,0,[]).
mid([],_,_,Res,2,Res):-!.
mid([H|T],I1,I2,R,Ci,Lis):- Ci==0,(H==I1,NewFlag is 1;NewFlag is 0), !,mid(T,I1,I2,R,NewFlag,Lis).
mid([H|_],I1,I2,R,Ci,Lis):- H==I2,Ci=1,NewFlag is 2 ,!,mid([],I1,Ci,R,NewFlag,Lis).
mid([H|T],I1,I2,R,Ci,Lis):- Ci ==1, append(Lis,[H],List),!,mid(T,I1,I2,R,Ci,List).
until([H|T],Res,Val):-until([H|T],Res,Val,[]).
until([],Res,_,Res):-!.
until([H|_],Res,Value,CurList):- H==Value, until([],Res,Value,CurList).
until([H|T],Res,Value,CurList):-add(H,CurList,NewList), until(T,Res,Value,NewList).
untilmin(X,Res):-listmin(X,Min), until(X,PreRes,Min),add(Min,PreRes,Res).
after([H|T],Value,Res):-after([H|T],Value,Res,[],0).
after([],_,Res,Res,1):-!.
after([H|T],Value,Res,CurList,Marker):-Marker==0,(H==Value,NewM is 1;NewM is 0),after(T,Value,Res,CurList,NewM).
after([H|T],Value,Res,CurList,Marker):- Marker==1, add(H,CurList,NewL), after(T,Value,Res,NewL,Marker).
aftermax(X,Res):-listmax(X,Max), after(X,Max,PPPreRes),reverse2(PPPreRes,PPreRes),add(Max,PPreRes,PreRes),reverse2(PreRes,Res).
mid(X,Res):-listmax(X,Max),listmin(X,Min),mid(X,Min,Max,Res).
reslist12(X,Res):-untilmin(X,Unt), mid(X,PreMid),reverse2(PreMid,Mid), append(Unt,Mid,Preres), aftermax(X,Aft), append(Preres,Aft,Res).

%task16 (1.22)

countSmth([H|T],A,B,Res,Value):-countSmth([H|T],A,B,Res,0,0,Value).
countSmth([],_,B,Count,B,Count,_):-!.
countSmth([_|_],A,B,Res,N,CurCnt,Value):-N==B, countSmth([],A,B,Res,B,CurCnt,Value).
countSmth([_|T],A,B,Res,N,CurCnt,Value):- N<A, N1 is N+1,countSmth(T,A,B,Res,N1,CurCnt,Value).
countSmth([H|T],A,B,Res,N,CurCnt,Value):- N1 is N+1, (H==Value,NewCnt is CurCnt+1;NewCnt is CurCnt), countSmth(T,A,B,Res,N1,NewCnt,Value).
countMin(X,A,B,Res):-listmin(X,Min),countSmth(X,A,B,Res,Min).

