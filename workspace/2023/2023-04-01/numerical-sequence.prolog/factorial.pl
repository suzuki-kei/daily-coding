
factorial(0, 1).

factorial(N, Fn) :-
    N > 0,
    is(M, N - 1),
    factorial(M, Fm),
    is(Fn, N * Fm).

factorials(N, Factorials) :-
    factorials(1, N, Factorials).

factorials(Min, Max, []) :-
    Min > Max.

factorials(Min, Max, [X|Xs]) :-
    factorial(Min, X),
    is(NextMin, Min + 1),
    factorials(NextMin, Max, Xs).

