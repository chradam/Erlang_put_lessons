-module(elab10).
-export([bezw/1,bezw2/1,fact/1,ifact/1,parzysta/1, fib/1, nalezy/2, polacz/2,polacz2/2, dl/1,idl/1,len/1,isuma/1,iminn/2]).

fact(0) -> 1;
fact(N) when N > 0 ->
	N * fact(N-1).


ifact(N) ->
	ifact(N,1).
ifact(0,Acc) -> Acc;
ifact(N,Acc) when N > 0 ->
	ifact(N-1,N*Acc).	
	
	
parzysta(N) ->
	case N rem 2 of
		1 -> nieparzysta;
		0 -> parzysta	
	end.

fib(0) -> 1;
fib(1) -> 1;
fib(N) when N > 0 ->
	fib(N-1) + fib(N-2).


	
	
nalezy(E,L) ->
	case lists:member(E,L) of
		true -> nalezy;
		false -> nie_nalezy
	end.



polacz(L,[]) -> L;
polacz(L,[H|T]) ->
	polacz(L ++ [H],T).

polacz2([],L) -> L;
polacz2([H|T],L) -> [H|polacz2(T,L)].
	
	
dl([]) -> 0;
dl(L) ->
	dl(L,0).
dl([_|T],N) ->
	dl(T,N+1);
dl([],N) ->
	N.
	
len([]) -> 0;
len([_|T]) -> 1 + len(T).


idl(L) ->
	idl(L,0).
idl([],Acc) -> Acc;
idl([_|T],N) ->
	idl(T,N+1).

isuma(L) ->
	isuma(L,0).
isuma([],Acc) -> Acc;
isuma([H|T],Acc) ->
	isuma(T,Acc+H).
	

iminn(L,N) ->
	iminn(L,[],N).
iminn([],Acc,N) -> Acc;
iminn([H|T],L,N) ->
	iminn(T,L ++ [H-N],N).
	
bezw(L) ->
	bezw([],L).
bezw(Acc,[]) -> Acc;
bezw(L,[H|T]) when H < 0 ->
	bezw(L ++ [H*(-1)],T);
bezw(L,[H|T]) when H >= 0 ->
	bezw(L ++ [H],T).

	
	
bezw2([]) -> [];
bezw2([H|T]) when H < 0 ->
	[H*(-1)|bezw2(T)];
bezw2([H|T]) when H >= 0 ->
	[H|bezw2(T)].
	
	
	
	
	
	