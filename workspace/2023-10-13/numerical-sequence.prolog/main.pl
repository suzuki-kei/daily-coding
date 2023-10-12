
main :-
    print_sequence("factorials", factorial, 1, 10),
    print_sequence("fibonacci numbers", fibonacci, 0, 20),
    print_sequence("fizz buzz values", fizz_buzz, 1, 100),
    halt.

print_sequence(Description, F, Min, Max) :-
    range(Min, Max, Ns),
    map(F, Ns, Values),
    atomics_to_string(Values, " ", String),
    format("~s:~n~s~n", [Description, String]).

range(Min, Max, []) :-
    Min > Max.

range(Min, Max, [Min|Xs]) :-
    is(NextMin, Min + 1),
    range(NextMin, Max, Xs).

map(_, [], []).

map(F, [X|Xs], [Y|Ys]) :-
    call(F, X, Y),
    map(F, Xs, Ys).

factorial(0, 1).

factorial(N, Fn) :-
    is(M, N - 1),
    factorial(M, Fm),
    is(Fn, N * Fm).

fibonacci(N, Fn) :-
    fibonacci(0, 1, N, Fn).

fibonacci(A, _, 0, A).

fibonacci(A, B, N, Fn) :-
    is(NextA, B),
    is(NextB, A + B),
    is(NextN, N - 1),
    fibonacci(NextA, NextB, NextN, Fn).

fizz_buzz(N, Fn) :-
    N mod 15 =:= 0 ->
        Fn = "FizzBuzz";
    N mod 5 =:= 0 ->
        Fn = "Buzz";
    N mod 3 =:= 0 ->
        Fn = "Fizz";
    otherwise ->
        number_string(N, Fn).

