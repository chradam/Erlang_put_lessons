-module(elab11).
-export([del/2,remove/2,perm/1,minE/1,qsort/1,insert/2,isort/1,select_sort/1,select_max/3]).

del(_,[]) -> [];
del(E,[E|T]) ->
	del(E,T);
del(X,[H|T]) ->
	[H | del(X,T)].

remove(X,L) ->
	[Y || Y <- L, Y=/=X]. %list comprehensions


perm([]) -> [[]];
perm(L) ->
	[[H|T] || H <- L, T <- perm(L--[H])].

%quick sort
qsort([]) -> [];
qsort([H|T]) ->
	qsort([X || X <- T, X < H]) ++ [H] ++ qsort([X || X <- T, X >= H]).

%insertion sort
insert(E,[]) -> [E];

insert(E,[H|T]) when E > H ->	%E na koniec
	[H|insert(E,T)];
insert(E,[H|T]) when E =< H -> %E na początek
	[E,H|T].

isort(L) ->
	isort(L,[]).
isort([],Sorted) -> Sorted;
isort([H|T],Sorted) ->
	isort(T,insert(H,Sorted)).

%sorted

%selection sort
select_sort([]) -> [];
select_sort(L) ->
	select_sort(L,[]).

select_sort([],Sorted) -> Sorted;
select_sort([H|T],Sorted) ->
	{Max,Rest} = select_max(T,H,[]),
	select_sort(Rest,[Max|Sorted]).

select_max([],Max,Rest) -> {Max,Rest};
select_max([H|T],Max,Rest) when H < Max ->
	select_max(T,Max,[H|Rest]);
select_max([H|T],Max,Rest) ->
	select_max(T,H,[Max|Rest]).

%slow sort
%ssort(L) ->
%	ssort(L,[]).

%ssort([],Sorted) -> Sorted.

%min element on list
minE([H|T]) ->
	minE([H|T],H).
minE([],Min) -> Min;
minE([H|T],Min) when H < Min ->
	minE(T,H);
minE([H|T],Min) when H >= Min ->
	minE(T,Min).