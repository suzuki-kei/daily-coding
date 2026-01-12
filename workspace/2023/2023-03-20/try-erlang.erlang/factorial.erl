
main(_) ->
    show_factorials(1, 10).

show_factorials(Min, Max) when Min > Max ->
    ok;
show_factorials(Min, Max) ->
    io:format("factorial(~w) = ~w~n", [Min, factorial(Min)]),
    show_factorials(Min + 1, Max).

factorial(0) ->
    1;
factorial(N) ->
    N * factorial(N - 1).

