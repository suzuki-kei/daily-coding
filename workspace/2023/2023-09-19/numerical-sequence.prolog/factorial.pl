
factorial(0, 1).

factorial(N, Fn) :-
    is(M, N - 1),
    factorial(M, Fm),
    is(Fn, N * Fm).

