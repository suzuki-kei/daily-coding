
%
% N 番目のフィボナッチ数.
%

fibonacci(0, 0).

fibonacci(1, 1).

fibonacci(N, Fn) :-
    N > 1,
    is(A, N - 1),
    fibonacci(A, Fa),
    is(B, N - 2),
    fibonacci(B, Fb),
    is(Fn, Fa + Fb).

%
% Min 番目から Max 番目までのフィボナッチ数.
%

fibonacci_numbers(Min, Max, []) :-
    Min > Max.

fibonacci_numbers(Min, Max, [Fmin|Xs]) :-
    Min =< Max,
    fibonacci(Min, Fmin),
    is(NextMin, Min + 1),
    fibonacci_numbers(NextMin, Max, Xs).

