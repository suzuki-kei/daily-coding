
main(_) ->
    show_factorials(10).

show_factorials(N) ->
    show_factorials(0, N).

show_factorials(Min, Max)
    when
        Min =< Max ->
    show_factorial(Min),
    show_factorials(Min + 1, Max);

show_factorials(_, _) ->
    ok.

show_factorial(N) ->
    io:format("factorial(~w) = ~w~n", [N, factorial(N)]).

factorial(0) ->
    1;

factorial(N) ->
    N * factorial(N - 1).

