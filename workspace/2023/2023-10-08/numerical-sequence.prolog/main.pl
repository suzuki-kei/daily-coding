
main :-
    print_sequence("factorials", factorial, 1, 10),
    print_sequence("fibonacci numbers", fibonacci, 0, 20),
    print_sequence("fizz buzz values", fizz_buzz, 1, 100),
    halt.

print_sequence(Description, F, Min, Max) :-
    range(Min, Max, Ns),
    map(F, Ns, Values),
    format("~s:~n~w~n", [Description, Values]).

range(Min, Max, []) :-
    Min > Max.

range(Min, Max, [Min|Values]) :-
    is(NextMin, Min + 1),
    range(NextMin, Max, Values).

map(_, [], []).

map(F, [N|Ns], [Value|Values]) :-
    call(F, N, Value),
    map(F, Ns, Values).

factorial(0, 1).

factorial(N, Fn) :-
    is(M, N - 1),
    factorial(M, Fm),
    is(Fn, N * Fm).

fibonacci(0, 0).

fibonacci(1, 1).

fibonacci(N, Fn) :-
    is(A, N - 2),
    is(B, N - 1),
    fibonacci(A, Fa),
    fibonacci(B, Fb),
    is(Fn, Fa + Fb).

fizz_buzz(N, Fn) :-
    N mod 15 =:= 0 ->
        Fn = "FizzBuzz";
    N mod 5 =:= 0 ->
        Fn = "Buzz";
    N mod 3 =:= 0 ->
        Fn = "Fizz";
    otherwise ->
        number_string(N, Fn).

