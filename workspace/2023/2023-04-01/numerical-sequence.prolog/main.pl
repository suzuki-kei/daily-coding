
main :-
    format("factorials:~n"),
    factorials(10, Factorials),
    format("~w~n", [Factorials]),

    format("fibonacci numbers:~n"),
    fibonacci_numbers(20, FibonacciNumbers),
    format("~w~n", [FibonacciNumbers]),

    halt.

