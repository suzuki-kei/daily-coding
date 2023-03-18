
%
% N 番目の階乗数.
%

factorial(0, 1).

factorial(N, Fn) :-
    N > 0,
    is(M, N - 1),
    factorial(M, Fm),
    is(Fn, N * Fm).

%
% Min 番目から Max 番目までの階乗数.
%

factorials(Min, Max, []) :-
    Min > Max.

factorials(Min, Max, [Fmin|Xs]) :-
    Min =< Max,
    factorial(Min, Fmin),
    is(NextMin, Min + 1),
    factorials(NextMin, Max, Xs).

