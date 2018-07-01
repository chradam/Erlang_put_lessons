-module(elab12).
-export([
    pal/1,clean/1,clean/2,
    reverse/1,
    palindrome/1,
    ac/1,
    a1/1,
    a3/1,
    a5/1
]).


pal([]) -> [];

pal(L) ->
    CleanList = clean(L),
    RevL = lists:reverse(CleanList),
    CleanList == RevL.

clean(L) ->
    clean(L,[]).

clean([],Cleaned) -> Cleaned;
clean([X|Xs],Cleaned) when X >= $A, X =< $Z ->
    clean(Xs,[X + 32 | Cleaned]);
clean([X|Xs],Cleaned) when X >= $a, X =< $z ->
    clean(Xs, [ X | Cleaned ]);

clean([_X|Xs], Cleaned) ->
    clean(Xs, Cleaned).


palindrome([]) ->true;
palindrome(Xs) ->
    Xs == reverse(Xs).


reverse(Xs) -> reverse(Xs, []).
reverse([], Acc) -> Acc;
reverse([X|Xs], Acc) ->
	reverse(Xs, [X|Acc]).


%001(00 | 01)+11(010 | 001)*11


ac([0,0,1 | T]) ->
    a1(T);
ac(_) -> false.

a1([0,0 | T]) ->
    a5(T);
a1([0,1 | T]) ->
    a5(T);
a1(_) -> false.

a5([0,0 | T]) ->
    a5(T);
a5([0,1 | T]) ->
    a5(T);
a5([1,1 | T]) ->
    a3(T);
a5(_) -> false.


a3([0,1,0 | T]) ->
    a3(T);
a3([0,0,1 | T]) ->
    a3(T);
a3([1,1 | T]) ->
    true;
a3(_) -> false.