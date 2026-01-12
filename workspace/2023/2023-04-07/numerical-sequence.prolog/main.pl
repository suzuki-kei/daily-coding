
main :-
    show_factorials(10),
    show_fibonacci_numbers(20),
    halt.

show_factorials(N) :-
    format("factorials:~n"),
    factorials(N, Xs),
    format("~w~n", [Xs]).

show_fibonacci_numbers(N) :-
    format("fibonacci numbers:~n"),
    fibonacci_numbers(N, Xs),
    format("~w~n", [Xs]).

