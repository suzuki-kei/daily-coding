
main :-
    show_factorials(10),
    show_fibonacci_numbers(20),
    halt.

show_factorials(N) :-
    factorials(N, Xs),
    format("factorials:~n~w~n", [Xs]).

show_fibonacci_numbers(N) :-
    fibonacci_numbers(N, FibonacciNumbers),
    format("fibonacci numbers:~n~w~n", [FibonacciNumbers]).

