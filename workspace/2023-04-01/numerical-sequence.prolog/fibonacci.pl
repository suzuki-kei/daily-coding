
fibonacci(N, Fn) :-
    fibonacci(0, 1, N, Fn).

fibonacci(A, _, 0, A).

fibonacci(A, B, N, Fn) :-
    N > 0,
    is(NextA, B),
    is(NextB, B + A),
    is(NextN, N - 1),
    fibonacci(NextA, NextB, NextN, Fn).

fibonacci_numbers(N, Xs) :-
    fibonacci_numbers(0, N, Xs).

fibonacci_numbers(Min, Max, []) :-
    Min > Max.

fibonacci_numbers(Min, Max, [X|Xs]) :-
    Min =< Max,
    fibonacci(Min, X),
    is(NextMin, Min + 1),
    fibonacci_numbers(NextMin, Max, Xs).

