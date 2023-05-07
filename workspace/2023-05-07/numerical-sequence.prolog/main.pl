
main :-
    format("factorials:~n"),
    factorials(10, Factorials),
    foreach(member(X, Factorials), format("~w ", X)), nl, nl,

    format("fibonacci numbers:~n"),
    fibonacci_numbers(20, FibonacciNumbers),
    foreach(member(X, FibonacciNumbers), format("~w ", X)), nl, nl,

    format("FizzBuzz values:~n"),
    fizzbuzz_values(100, FizzBuzzValues),
    foreach(member(X, FizzBuzzValues), format("~w ", X)), nl, nl,

    halt.

