
main :-
    print_sequence("factorials", factorial, 1, 10),
    print_sequence("fibonacci numbers", fibonacci, 0, 20),
    print_sequence("fizz buzz values", fizz_buzz, 1, 100),
    halt.

print_sequence(Description, F, Min, Max) :-
    range(Min, Max, Ns),
    map(F, Ns, Values),
    atomic_list_concat(Values, " ", String),
    format("~s:~n~s~n", [Description, String]).

range(Min, Max, []) :-
    Min > Max.

range(Min, Max, [Min|Xs]) :-
    is(NextMin, Min + 1),
    range(NextMin, Max, Xs).

map(_, [], []).

map(F, [X|Xs], [Y|Ys]) :-
    call(F, X, Y),
    map(F, Xs, Ys).

