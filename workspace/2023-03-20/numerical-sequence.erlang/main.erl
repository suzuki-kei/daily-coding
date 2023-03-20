
main(_) ->
    show_factorials(10),
    show_fibonacci(20).

factorial(0) ->
    1;
factorial(N) ->
    N * factorial(N - 1).

show_factorials(N) when N < 1 ->
    ok;
show_factorials(N) ->
    show_factorials(1, N).

show_factorials(Min, Max) when Min > Max ->
    io:format("~n");
show_factorials(Min, Max) ->
    io:format("~w ", [factorial(Min)]),
    show_factorials(Min + 1, Max).

fibonacci(0) ->
    0;
fibonacci(1) ->
    1;
fibonacci(N) ->
    fibonacci(N - 1) + fibonacci(N - 2).

show_fibonacci(N) when N < 0 ->
    ok;
show_fibonacci(N) ->
    show_fibonacci(0, N).

show_fibonacci(Min, Max) when Min > Max ->
    io:format("~n");
show_fibonacci(Min, Max) ->
    io:format("~w ", [fibonacci(Min)]),
    show_fibonacci(Min + 1, Max).

