
fibonacci(0, 0) :-
    true,
    !.
fibonacci(1, 1) :-
    true,
    !.
fibonacci(N, Fn) :-
    N > 1,
    is(A, N - 2),
    is(B, N - 1),
    fibonacci(A, Fa),
    fibonacci(B, Fb),
    is(Fn, Fa + Fb).

