
main :-
    random_values(Xs, 20),
    writeln(Xs),
    halt.

random_values(Xs, N) :-
    random_values(Xs, [], N).

random_values(Xs, Xs, 0) :-
    true.
random_values(Xs, Accumulated, N) :-
    is(NextN, N - 1),
    random_between(10, 99, X),
    random_values(Xs, [X|Accumulated], NextN).

