
main :-
    print_sequence("factorials", factorial, 1, 10),
    print_sequence("fibonacci numbers", fibonacci, 0, 20),
    print_sequence("fizz buzz values", fizz_buzz, 1, 100),
    halt.

print_sequence(Description, F, Min, Max) :-
    range(Min, Max, Xs),
    map(F, Xs, Ys),
    format("~s:~n~w~n", [Description, Ys]).

range(Min, Max, []) :-
    Min > Max.

range(Min, Max, [Min|Xs]) :-
    is(NextMin, Min + 1),
    range(NextMin, Max, Xs).

map(_, [], []).

map(F, [X|Xs], [Y|Ys]) :-
    call(F, X, Y),
    map(F, Xs, Ys).

