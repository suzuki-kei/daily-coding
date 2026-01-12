
main :-
    demonstration(0, 9),
    halt.

demonstration(Min, Max) :-
    Min > Max.

demonstration(Min, Max) :-
    Min =< Max,
    demonstration(Min),
    is(NextMin, Min + 1),
    demonstration(NextMin, Max).

demonstration(N) :-
    factorial(N, Fn),
    format('factorial(~w) = ~w~n', [N, Fn]).

