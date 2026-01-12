
factorial(0, 1).

factorial(N, Fn) :-
    N > 0,
    is(M, N - 1),
    factorial(M, Fm),
    is(Fn, N * Fm).

factorials(N, Xs) :-
    is(Min, 1),
    is(Max, N),
    factorials(Min, Max, Xs).

factorials(Min, Max, []) :-
    Min > Max.

factorials(Min, Max, [X|Xs]) :-
    Min =< Max,
    factorial(Min, X),
    is(NextMin, Min + 1),
    factorials(NextMin, Max, Xs).

