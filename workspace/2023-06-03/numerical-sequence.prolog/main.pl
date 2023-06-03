
main :-
    print_sequence("factorials", factorial, 1, 10),
    print_sequence("fibonacci numbers", fibonacci, 0, 20),
    print_sequence("fizz buzz values", fizz_buzz, 1, 100),
    halt.

print_sequence(Description, F, Min, Max) :-
    numerical_sequence(F, Min, Max, Xs),
    format("~w:~n", [Description]),
    foreach(member(X, Xs), format("~w ", X)),
    nl.

numerical_sequence(F, Min, Max, Xs) :-
    range(Min, Max, Ns),
    maplist(F, Ns, Xs).

range(Min, Max, []) :-
    Min > Max.

range(Min, Max, [X|Xs]) :-
    Min =< Max,
    is(X, Min),
    is(NextMin, Min + 1),
    range(NextMin, Max, Xs).

