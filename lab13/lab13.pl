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

%task15

task15:-
    Color = [_,_,_],
    in_list(Color,[anya,_,_]),
    in_list(Color,[natasha,_,green]),
    in_list(Color,[valya,_,_]),
    in_list(Color,[_,blue,_]),
    in_list(Color,[_,white,_]),
    in_list(Color,[_,green,_]),
    in_list(Color,[_,_,blue]),
    in_list(Color,[_,_,white]),
    not(in_list(Color,[valya,_,white])),
    not(in_list(Color,[valya,white,_])),
    write(Color),!.

task16:-
    Zavod = [_,_,_],
    in_list(Zavod,[_,slesar,0,0]),
    in_list(Zavod,[_,tokar,1,_]),
    in_list(Zavod,[_,svarshik,_,_]),
    in_list(Zavod,[borisov,_,_,1]),
    in_list(Zavod,[ivanov,_,_,_]),
    in_list(Zavod,[semenov,_,2,_]),
    not(in_list(Zavod,[semenov,tokar,_,_])),
    in_list(Zavod,[Name1,slesar,_,_]),
    in_list(Zavod,[Name2,tokar,_,_]),
    in_list(Zavod,[Name3,svarshik,_,_]),
    write("result Name:"), nl, write("slesar - "), write(Name1),nl,
    write("tokar  - "), write(Name2), nl,
    write("svarshik - "),write(Name3),!.

%task17
between(List,X,Y,Z):-leftInList(List,X,Y),rightInList(List,Z,Y);
    leftInList(List,Z,Y),rightInList(List,X,Y).


leftInList([_],_,_):-fail.
leftInList([X,Y|_],X,Y).
leftInList([_|List],X,Y):- leftInList(List,X,Y).

rightInList([_],_,_):-fail.
rightInList([Y,X|_],X,Y).
rightInList([_|List],X,Y):- rightInList(List,X,Y).

near(List,X,Y):-rightInList(List,Y,X).
near(List,X,Y):-leftInList(List,Y,X).

task17:-
    Jar = [_,_,_,_],
    in_list(Jar,[bottle,_]),
    in_list(Jar,[cup,_]),
    in_list(Jar,[jug,_]),
    in_list(Jar,[banka,_]),
    in_list(Jar,[_,milk]),
    in_list(Jar,[_,water]),
    in_list(Jar,[_,limonad]),
    in_list(Jar,[_,kvas]),
    not(in_list(Jar,[bottle,milk])),
    not(in_list(Jar,[bottle,water])),
    between(Jar,[jug,_],[_,limonad],[_,kvas]),
    not(in_list(Jar,[banka,water])),
    not(in_list(Jar,[banka,limonad])),
    near(Jar,[cup,_],[banka,_]),
    near(Jar,[cup,_],[_,milk]),
    write(Jar),!.

%task18
task18:-
    Artist=[_,_,_,_],
    in_list(Artist,[voronov,_]),
    in_list(Artist,[levitskiy,_]),
    in_list(Artist,[pavlov,_]),
    in_list(Artist,[saharov,_]),
    in_list(Artist,[_,dancer]),
    in_list(Artist,[_,artist]),
    in_list(Artist,[_,singer]),
    in_list(Artist,[_,writer]),
    not(in_list(Artist,[voronov,singer])),
    not(in_list(Artist,[levitskiy,singer])),
    not(in_list(Artist,[pavlov,writer])),
    not(in_list(Artist,[pavlov,artist])),
    not(in_list(Artist,[voronov,writer])),
    not(in_list(Artist,[saharov,writer])),
    not(in_list(Artist,[voronov,artist])),
    (
    in_list(Artist,[voronov,artist]),
    not(in_list(Artist,[levitskit,writer]));
    not(in_list(Artist,[voronov,artist]),
    in_list(Artist,[levitskit,writer]);
    ),
    write(Artist),!.

%task19

task19:-
    Sportsman=[_,_,_],
    in_list(Sportsman,[michael,_,basketball,_]),
    in_list(Sportsman,[_,american,_,_]),
    in_list(Sportsman,[saimon,jew,_,_]),
    in_list(Sportsman,[_,_,cricket,1]),
    in_list(Sportsman,[_,australian,Name,_]),
    in_list(Sportsman,[richard,_,Sport,_]),
    in_list(Sportsman,[_,_,_,2]),
    in_list(Sportsman,[_,_,_,3]),
    in_list(Sportsman,[_,_,tennis,_]),
    write("Australian is "), write(Name), nl,
    write("Richard sport - "), write(Sport),!.

%task20

task20:-
    Students=[_,_,_,_],
    ( in_list(Students,[andey,dmitry,_]),
      not(in_list(Students,[boris,_,_]));
      in_list(boris,_,_),
      not(in_list(Students,[dmitry,victor,_]))
     ),
    (
        in_list(Students,[victor,_,_]),
        not(in_list(Students,[_,_,andrey]));
        in_list(Students,[_,_,andrey]),
        not(in_list(Students,[victor,_,_])
    ),
    (
        in_list(Students,[_,dmitry,_]),
        not(in_list(Students,[_,_,grigory]))
     ),
    (
       in_list(Students,[_,dmitry,_],
       not(in_list(Students,[boris,victor,_]));
       in_list(Students,[_,victor,grigory],
       not(in_list(Students,[_,dmitry,_]))

    ),

     write(Student),!.



