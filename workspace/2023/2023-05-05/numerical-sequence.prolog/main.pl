
main :-
    factorials(10, Factorials),
    format("factorials:~n~w~n", [Factorials]),

    fibonacci_numbers(20, FibonacciNumbers),
    format("fibonacci numbers:~n~w~n", [FibonacciNumbers]),

    halt.

