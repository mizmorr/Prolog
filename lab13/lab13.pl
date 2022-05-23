readlist(X,Y):-readlist([],X,0,Y).
readlist(A,A,G,G):-!.
readlist(A,B,C,D):- C1 is C+1,read(X),append(A,[X],A1),readlist(A1,B,C1,D).

write_list([]) :- !.
write_list([X|T]) :- write(X), nl, write_list(T).

in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

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

%task12
listNegat(X,Res):-listNegat(X,Res,[]).
listNegat([],Res,Res):-!.
listNegat([H|T],Res,CurL):-(H<0,add(H,CurL,NewL);append([],CurL,NewL)),listNegat(T,Res,NewL).
listPos(X,Res):-listPos(X,Res,[]).
listPos([],Res,Res):-!.
listPos([H|T],Res,CurL):-(H>=0,add(H,CurL,NewL);add([],CurL,NewL)),listPos(T,Res,NewL).
listPosNeg(X,Res):- listPos(X,Pos), listNegat(X,Neg), append(Pos,Neg,Res).

%task13
listwout([H|T],Value,Res):-listwout([H|T],Value,Res,[]).
listwout([],_,Res,Res):-!.
listwout([H|T],Value,Res,CurList):-(H\=Value,add(H,CurList,NewL);add([],CurList,NewL)), listwout(T,Value,Res,NewL).

listAllPairs(Value,X,Res):-listAllPairs(Value,X,Res,[]).
listAllPairs(_,[],Res,Res):-!.
listAllPairs(Value,[H|T],Res,CurL):- Sum is Value+H, add(Sum,CurL,NewL),listAllPairs(Value,T,Res,NewL).
listAP(X,Res):-listAP(X,Res,[]).
listAP([],Res,Res):-!.
listAP([H|T],Res,CurList):-listAllPairs(H,T,Preres), append(Preres,CurList,NextL),listAP(T,Res,NextL).

contains([], _):- !, fail.
contains([H|_], H):- !.
contains([_|T], N):- contains(T, N).

countSmth(X,Res,List):-countSmth(X,Res,List,0).
countSmth([],Res,_,Res):-!.
countSmth([H|T],Res,List,CurN):- (contains(List,H),NewN is CurN+1;NewN is CurN), countSmth(T,Res,List,NewN).
countDet(X,Res):- listAP(X,AP), countSmth(X,Res,AP).

%task14

task14:-
    Color = [_,_,_],
    in_list(Color,[belokurov,_]),
    in_list(Color,[chernov,_]),
    in_list(Color,[ryzhov,_]),
    in_list(Color,[_,blond]),
    in_list(Color,[_,black]),
    in_list(Color,[_,redhead]),
    not(in_list(Color,[belokurov,blond])),
    not(in_list(Color,[chernov,black])),
    not(in_list(Color,[ryzhov,redhead])),
    write(Color),!.
