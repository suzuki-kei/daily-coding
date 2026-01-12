
fibonacci(0, 0).

fibonacci(1, 1).

fibonacci(N, Fn) :-
    N > 1,
    is(A, N - 2),
    is(B, N - 1),
    fibonacci(A, Fa),
    fibonacci(B, Fb),
    is(Fn, Fa + Fb).

