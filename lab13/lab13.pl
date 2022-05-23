readlist(X,Y):-readlist([],X,0,Y).
readlist(A,A,G,G):-!.
readlist(A,B,C,D):- C1 is C+1,read(X),append(A,[X],A1),readlist(A1,B,C1,D).

%task11 - Min Even
listmin([H|T],Res):-listmin([H|T],Res,H).
listmin([],Res,Res):-!.
listmin([H|T],Res,Cur):-
    (H<Cur, NewH is H; NewH is Cur),
    listmin(T,Res,NewH).

add([],[H|T],[H|T]):-!.
add(E,[],[E]).
add(E,[H|T],[H|T1]):-add(E,T,T1).

listEven([H|T],Res):-listEven([H|T],Res,[]).
listEven([],Res,Res):-!.
listEven([H|T],Res,CurList):-(0 is H mod 2,add(H,CurList,NewL);add([],CurList,NewL)), listEven(T,Res,NewL).

minEven(X,Min):-listEven(X,Res),listmin(Res,Min).

%
