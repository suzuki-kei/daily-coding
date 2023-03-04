
factorial(0, 1).
factorial(N, Fn) :-
    N > 0,
    is(M, N - 1),
    factorial(M, Fm),
    is(Fn, N * Fm).

