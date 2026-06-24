
main :-
    print_sequence("factorials", factorial, 1, 10),
    print_sequence("fibonacci numbers", fibonacci, 0, 20),
    print_sequence("fizz buzz values", fizz_buzz, 1, 100),
    halt.

print_sequence(Label, F, Min, Max) :-
    range(Ns, Min, Max),
    map(Values, F, Ns),
    atomics_to_string(Values, " ", Formatted),
    format("~s:~n~s~n", [Label, Formatted]).

range([], Min, Max) :-
    Min > Max.

range([N|Ns], Min, Max) :-
    N is Min,
    NextMin is Min + 1,
    range(Ns, NextMin, Max).

map([], _F, []) :-
    true.

map([MappedX|MappedXs], F, [X|Xs]) :-
    call(F, MappedX, X),
    map(MappedXs, F, Xs).

factorial(Fn, N) :-
    factorial(Fn, N, 1).

factorial(Fn, 0, Fn) :-
    true.

factorial(Fn, N, Fm) :-
    NextN is N - 1,
    NextFm is Fm * N,
    factorial(Fn, NextN, NextFm).

fibonacci(Fn, N) :-
    fibonacci(Fn, N, 0, 1).

fibonacci(Fn, 0, Fn, _B) :-
    true.

fibonacci(Fn, N, A, B) :-
    NextN is N - 1,
    NextA is B,
    NextB is A + B,
    fibonacci(Fn, NextN, NextA, NextB).

fizz_buzz("FizzBuzz", N) :-
    N mod 15 =:= 0.

fizz_buzz("Buzz", N) :-
    N mod 5 =:= 0.

fizz_buzz("Fizz", N) :-
    N mod 3 =:= 0.

fizz_buzz(Fn, N) :-
    number_string(N, Fn).

