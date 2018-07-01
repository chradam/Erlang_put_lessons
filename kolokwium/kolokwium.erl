-module(kolokwium).
-export([
    ac/1,
    bc/1,
    cc/1,
    zamianaR/3,
    zamianaI/3,
    zamianav2/3,
    roznicaR/2,
    roznicaI/2,
    r/2,
    s/2,
    sumaR/2,
    nalezy/2,
    ujemneR/1,
    ujemneI/1,
    maxE/1,
    indexI/2,
    odwrocR/1,
    odwrocI/1,
    palindrom/1,
    map_add/2,
    between/2,
    przed/3,
    absolut/1,
    polacz/2,
    dlugoscR/1,
    dlugoscI/1,
    zero/1,
    wprzedziale/1,
    ibezw/1,
    usun/2,
    remove/2,
    ostatnia/1,
    pierwsza/1,
    wstawK/2,
    wstawP/2

]).

%110(11|10)+00(10|110)*00 -> OK

ac([1,1,0 | T]) ->
    a1(T);
ac(_) -> false.

a1([1,1 | T]) ->
    a2(T);
a1([1,0 | T]) ->
    a2(T);
a1(_) -> false.

a2([1,1 | T]) ->
    a2(T);
a2([1,0 | T]) ->
    a2(T);
a2([0,0 | T]) ->
    a3(T);
a2(_) -> false.

a3([1,0 | T]) ->
    a3(T);
a3([1,1,0 | T]) ->
    a3(T);
a3([0,0]) -> true;
a3(_) -> false.

%zamiana w liście 2 na 3 (pierwszy podany element na drugi podanay element)
%(2,3,[1,2,3,4,2]) -> [1,3,3,4,3]

%rekurencyjnie -> OK

zamianaR(N1,N2,[]) -> [];
zamianaR(N1,N2,[H | T]) when H == N1 ->
    [N2 | zamianaR(N1,N2,T)];
zamianaR(N1,N2,[H | T]) ->
    [H | zamianaR(N1,N2,T)].


%iteracyjnie -> OK
zamianaI(N1,N2,Lista) ->
    zamianaI(N1,N2,Lista,[]).

zamianaI(N1,N2,[],Acc) -> Acc;
zamianaI(N1,N2,[H|T],Acc) when H == N1 ->
    zamianaI(N1,N2,T,Acc ++ [N2]);
zamianaI(N1,N2,[H|T],Acc) ->
    zamianaI(N1,N2,T, Acc ++ [H]).

%-------------------------
%OK
nalezy(E,[]) -> false;
nalezy(E,[E|T]) -> true;
nalezy(E,[H|T]) ->
    nalezy(E,T).
%-------------------------

%różnica mnogościowa
%[1,2,3,4,6] i [1,3,4,5,7] -> [2,6] -> zbiór A \ B

%OK
roznicaR([],L2) -> [];
roznicaR([H|T],L2) ->
    case nalezy(H,L2) of
        true ->  roznicaR(T,L2);
        false ->  [H | roznicaR(T -- [H],L2)]
    end.

%OK???, no ale dziala
roznicaI(L1,L2) ->
    roznicaI(L1,L2,[]).
roznicaI([],L2,Acc) -> Acc;
roznicaI([H|T],L2,Acc) ->
    case nalezy(H,L2) of
        true ->  roznicaI(T,L2,Acc);
        false ->  roznicaI(T -- [H],L2,Acc ++ [H])
    end.

%OK
ujemneR([]) -> 0;
ujemneR([H|T]) when H < 0 ->
    ujemneR(T) + 1;
ujemneR([H|T]) ->
    ujemneR(T).

%OK
ujemneI([]) -> false;
ujemneI(L) ->
    ujemneI(L,0).
ujemneI([],Acc) -> Acc;
ujemneI([H|T],Acc) when H < 0 ->
    ujemneI(T,Acc + 1);
ujemneI([H|T],Acc) ->
    ujemneI(T,Acc).

%------------------------------------------------------------------

%L3 jest sumą teoriomnogościową zbiorów L1 i L2. Porzadek nie ma znaczenia
%suma([1,2,3,4,5],[2,7],X)
%X=[1,2,3,4,5,7]
%[4,1,5] i [4,1,6,4] -> [4,1,5,6] -> A U B

%OK
sumaR([],[]) -> [];
sumaR([],[H|T]) -> 
    [H | sumaR([],T -- [H])];

sumaR([H|T],L2) ->
    case nalezy(H,L2) of
        true -> sumaR(T,L2);
        false -> sumaR(T,L2 ++ [H])
    end.

%max iteracyjnie

maxE([H|T]) -> 
    maxE([H|T],H). % zwraca element, gdy lista jest 1-elementowwa
maxE([],Max) -> Max;
maxE([H|T], Max) ->
    case H > Max of
        true -> maxE(T,H);
        false -> maxE(T,Max)
    end.

% Podać index elemntu na liście
indexI(E,L) ->
    indexI(E,L,0).
indexI(_,[],_) -> not_faund;
indexI(E,[E|_],Index) -> Index;
indexI(E,[_|T],Index) ->
    indexI(E,T,Index+1).

%001(00 | 01)+11(010 | 001)*11 -> OK

bc([0,0,1 | T]) ->
    b1(T);
bc(_) -> false.
b1([0,0 | T]) ->
    b2(T);
b1([0,1 | T]) ->
    b2(T);
b1(_) -> false.
b2([0,0 | T]) ->
    b2(T);
b2([0,1 | T]) ->
    b2(T);
b2([1,1 | T]) ->
    b3(T);
b2(_) -> false.
b3([0,1,0 | T]) ->
    b3(T);
b3([0,0,1 | T]) ->
    b3(T);
b3([1,1]) -> true;
b3(_) -> false.

%inne---------------------------------------------------

%OK
odwrocR([]) -> [];
odwrocR([H|T]) ->
    odwrocR(T) ++ [H].

%OK
odwrocI(L) ->
    odwrocI(L,[]).
odwrocI([], Odwrocona) -> Odwrocona;
odwrocI([H|T],Odwrocona) ->
    odwrocI(T,[H|Odwrocona]).

palindrom([]) -> false;
palindrom(L) ->
    L =:= odwrocR(L).


%nie wiem czy o to chodzi
map_add({},[]) -> [];
map_add({Key, Val},[]) -> [{Key,Val}];
map_add({Key,Val},Map) ->
    Map ++ [{Key,Val}].

%OK -> wstawia element pomiędzy dwa pozostałe
between(E,[]) -> [];
between(E,[H]) -> [H];
between(E,[H|T]) ->
    [H,E| between(E,T)].

%czy element A wystęuje przed B na liście L. Moga wcale nie występować


przed(A,B,[]) -> false;
przed(A,B,[H1,H2|T]) when H2 == B ->
    case H1 == A of
        true -> true;
        false -> przed(A,B,T)
    end;
przed(A,B,[_|T]) ->
    przed(A,B,T).

absolut(N) when N < 0 -> -1*N;
absolut(N) -> N.


polacz([],[])->[];
polacz([],L)->L;
polacz([H|T],L)->
    [H|polacz(T,L)].

dlugoscR([]) -> 0;
dlugoscR([H|T]) ->
    dlugoscR(T) + 1.

dlugoscI(L) ->
    dlugoscI(L,0).
dlugoscI([],Dl) -> Dl;
dlugoscI([_|T],Dl) ->
    dlugoscI(T,Dl+1).

%zero na koniec -> OK

zero([]) -> [];
zero([H|T]) when H == 0 ->
    zero(T) ++ [H];
zero([H|T]) ->
    [H | zero(T)].

%zlicza wystąpienia cyfr między 2 i 5

wprzedziale(L) ->
    wprzedziale(L,0).
wprzedziale([], Ile) -> Ile;
wprzedziale([H|T], Ile) when (H >=2) and (H =< 5) ->
    wprzedziale(T,Ile+1);
wprzedziale([_|T],Ile) ->
    wprzedziale(T,Ile).

zamianav2(E1,E2,[]) -> [];
zamianav2(E1,E2,[H|T]) ->
    case E1 == H of
        true -> [E2| zamianav2(E1,E2,T)];
        false -> [H| zamianav2(E1,E2,T)]
    end.

r([], L2) -> [];
r([H|T],L2) ->
case nalezy(H,L2) of
    true -> r(T,L2);
    false -> [H|r(T--[H],L2)]
end.

s([],[]) -> [];
s([],[H|T]) -> [H|s([],T -- [H])];
s([H|T], L2) ->
    case nalezy(H,L2) of
        true -> s(T -- [H],L2);
        false -> s(T,L2 ++ [H])
    end.

%01(00|10)*11(01|10)+ -> OK

cc([0,1|T]) ->
    c1(T);
cc(_) -> false.
c1([0,0|T]) ->
    c1(T);
c1([1,0|T]) ->
    c1(T);
c1([1,1|T]) ->
    c2(T);
c1(_) -> false.
c2([0,1|T]) ->
    c3(T);
c2([1,0|T]) ->
    c3(T);
c2(_) -> false.
c3([0,1|T]) ->
    c3(T);
c3([1,0|T]) ->
    c3(T);
c3([]) -> true;
c3(_) -> false.


%OK
ibezw(L) ->
    ibezw(L,[]).
ibezw([],Acc) -> Acc;
ibezw([H|T],Acc) when H < 0 ->
    ibezw(T, Acc ++ [H*(-1)]);
ibezw([H|T],Acc) ->
    ibezw(T, Acc ++ [H]).

%usuwa z listy wszystkie wskazane elementy -> OK
usun(E,[]) -> [];
usun(E,[E|T]) ->
    usun(E,T);
usun(E,[H|T]) ->
    [H|usun(E,T)].

%OK
remove(X,L) ->
    [Y || Y <- L, Y=/=X].

ostatnia([]) -> false;
ostatnia([E]) -> E;
ostatnia([H|T]) ->
    ostatnia(T).

pierwsza([]) -> false;
pierwsza([H|T]) -> H.

wstawK(E,[]) -> [E];
wstawK(E,L2) ->
    [H | wstawK(E,T)].

wstawP(E,[]) -> [E];
wstawP(E,L2) ->
    [E] ++ L2.