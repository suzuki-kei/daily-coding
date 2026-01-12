
main :-
    demonstration(0, 9),
    halt.

demonstration(Min, Max) :-
    Min > Max.

demonstration(Min, Max) :-
    Min =< Max,
    factorial(Min, Fmin),
    format('factorial(~w) = ~w~n', [Min, Fmin]),
    is(NextMin, Min + 1),
    demonstration(NextMin, Max).

