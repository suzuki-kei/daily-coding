
main(_) ->
    N = 5,
    io:format("factorial(~w) = ~w~n", [N, factorial(N)]).

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).

