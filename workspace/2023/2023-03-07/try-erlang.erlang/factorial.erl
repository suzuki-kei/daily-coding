
main(_) ->
    demonstration(0),
    demonstration(1),
    demonstration(2),
    demonstration(3),
    demonstration(4),
    demonstration(5).

demonstration(N) ->
    io:format("factorial(~w) = ~w~n", [N, factorial(N)]).

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).

