
main :-
    print_values("values", 0, 9, true),
    print_values("odd values", 0, 9, odd),
    print_values("even values", 0, 9, even),
    halt.

print_values(Description, Min, Max, F) :-
    range(Min, Max, Xs),
    format("~s:~n", [Description]),
    foreach(find(X, Xs, F), format("~d ", [X])),
    nl.

true(_).

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

find(X, [X|_], Predicate) :-
    call(Predicate, X).

find(X, [_|Ys], Predicate) :-
    find(X, Ys, Predicate).

