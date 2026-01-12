
main :-
    print_sequence("factorials", factorial, 1, 10),
    print_sequence("fibonacci numbers", fibonacci, 0, 20),
    print_sequence("fizz buzz values", fizz_buzz, 1, 100),
    halt.

print_sequence(Description, F, Min, Max) :-
    range(Min, Max, Xs),
    map(F, Xs, Ys),
    atomics_to_string(Ys, " ", String),
    format("~s:~n~s~n", [Description, String]).

range(Min, Max, []) :-
    Min > Max.
range(Min, Max, [X|Xs]) :-
    is(X, Min),
    is(NextMin, Min + 1),
    range(NextMin, Max, Xs).

map(_, [], []) :-
    true.
map(F, [X|Xs], [Y|Ys]) :-
    call(F, X, Y),
    map(F, Xs, Ys).

factorial(N, Fn) :-
    factorial(N, 1, Fn).
factorial(0, Accumulated, Fn) :-
    is(Fn, Accumulated).
factorial(N, Accumulated, Fn) :-
    is(NextN, N - 1),
    is(NextAccumulated, Accumulated * N),
    factorial(NextN, NextAccumulated, Fn).

fibonacci(N, Fn) :-
    fibonacci(N, 0, 1, Fn).
fibonacci(0, A, _, Fn) :-
    is(Fn, A).
fibonacci(N, A, B, Fn) :-
    is(NextN, N - 1),
    is(NextA, B),
    is(NextB, A + B),
    fibonacci(NextN, NextA, NextB, Fn).

fizz_buzz(N, "FizzBuzz") :-
    N mod 15 =:= 0.
fizz_buzz(N, "Buzz") :-
    N mod 5 =:= 0.
fizz_buzz(N, "Fizz") :-
    N mod 3 =:= 0.
fizz_buzz(N, Fn) :-
    number_string(N, Fn).

