
main :-
    range(0, 10, Xs),

    format("values:~n"),
    foreach(member(X, Xs), format("~d ", [X])),
    nl,

    format("odd values:~n"),
    foreach(find(X, Xs, odd), format("~d ", [X])),
    nl,

    format("even values:~n"),
    foreach(find(X, Xs, even), format("~d ", [X])),
    nl,

    halt.

odd(X) :-
    X mod 2 =:= 1.

even(X) :-
    X mod 2 =:= 0.

range(Min, Max, []) :-
    Min > Max.

range(Min, Max, [Min|Xs]) :-
    Min =< Max,
    is(NextMin, Min + 1),
    range(NextMin, Max, Xs).

find(X, [Head|Tail], Predicate) :-
    find(X, Head, Tail, Predicate).

find(X, X, _, Predicate) :-
    call(Predicate, X).

find(X, _, [Head|Tail], Predicate) :-
    find(X, Head, Tail, Predicate).

