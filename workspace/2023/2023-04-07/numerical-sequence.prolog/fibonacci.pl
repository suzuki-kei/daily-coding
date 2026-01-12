
fibonacci(0, 0).

fibonacci(1, 1).

fibonacci(N, Fn) :-
    N > 1,
    is(A, N - 2),
    is(B, N - 1),
    fibonacci(A, Fa),
    fibonacci(B, Fb),
    is(Fn, Fa + Fb).

fibonacci_numbers(N, Xs) :-
    is(Min, 0),
    is(Max, N),
    fibonacci_numbers(Min, Max, Xs).

fibonacci_numbers(Min, Max, []) :-
    Min > Max.

fibonacci_numbers(Min, Max, [X|Xs]) :-
    Min =< Max,
    fibonacci(Min, X),
    is(NextMin, Min + 1),
    fibonacci_numbers(NextMin, Max, Xs).

