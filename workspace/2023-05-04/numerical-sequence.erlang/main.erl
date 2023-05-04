
main(_) ->
    io:format("factorials:~n"),
    lists:foreach(fun(N) -> io:format("~p ", [factorial(N)]) end, lists:seq(1, 10)),
    io:format("~n"),

    io:format("fibonacci numbers:~n"),
    lists:foreach(fun(N) -> io:format("~p ", [fibonacci(N)]) end, lists:seq(0, 20)),
    io:format("~n"),

    io:format("FizzBuzz values:~n"),
    lists:foreach(fun(N) -> io:format("~p ", [fizzbuzz(N)]) end, lists:seq(1, 100)),
    io:format("~n"),

    ok.

factorial(0) ->
    1;
factorial(N) ->
    N * factorial(N - 1).

fibonacci(0) ->
    0;
fibonacci(1) ->
    1;
fibonacci(N) ->
    fibonacci(N - 1) + fibonacci(N - 2).

fizzbuzz(N) ->
    if
        N rem 15 == 0 -> "FizzBuzz";
        N rem  5 == 0 -> "Buzz";
        N rem  3 == 0 -> "Fizz";
        true          -> integer_to_list(N)
    end.

