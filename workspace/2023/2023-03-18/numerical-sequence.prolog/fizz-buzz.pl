
%
% N 番目の FizzBuzz.
%

fizz_buzz(N, 'FizzBuzz') :-
    N mod 15 =:= 0,
    !.

fizz_buzz(N, 'Buzz') :-
    N mod 5 =:= 0,
    !.

fizz_buzz(N, 'Fizz') :-
    N mod 3 =:= 0,
    !.

fizz_buzz(N, N).

%
% Min 番目から Max 番目までの FizzBuzz.
%

fizz_buzz_values(Min, Max, []) :-
    Min > Max.

fizz_buzz_values(Min, Max, [Fmin|Xs]) :-
    Min =< Max,
    fizz_buzz(Min, Fmin),
    is(NextMin, Min + 1),
    fizz_buzz_values(NextMin, Max, Xs).

