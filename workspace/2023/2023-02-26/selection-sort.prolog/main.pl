
main :-
    randomize,
    random_values(Xs, 20),
    write(Xs), nl,
    selection_sort(Sorted, Xs),
    write(Sorted), nl,
    halt.

random_values(Xs, N) :-
    random_values(Xs, [], N),
    !.
random_values(Result, Xs, 0) :-
    Result = Xs,
    !.
random_values(Result, Xs, N) :-
    N > 0,
    random(10, 100, X),
    is(M, N - 1),
    random_values(Result, [X|Xs], M),
    !.

