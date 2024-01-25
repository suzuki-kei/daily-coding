
main(_) ->
    print_sequence("factorials", fun factorial/1, 1, 10),
    print_sequence("fibonacci numbers", fun fibonacci/1, 0, 20),
    print_sequence("fizz buzz values", fun fizz_buzz/1, 1, 100).

print_sequence(Description, F, Min, Max) ->
    Values = lists:map(F, lists:seq(Min, Max)),
    String = lists:concat(lists:join(" ", Values)),
    io:format("~s:~n~s~n", [Description, String]).

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).

fibonacci(0) -> 0;
fibonacci(1) -> 1;
fibonacci(N) -> fibonacci(N - 1) + fibonacci(N - 2).

fizz_buzz(N) ->
    case [N rem 5, N rem 3] of
        [0, 0] -> "FizzBuzz";
        [0, _] -> "Buzz";
        [_, 0] -> "Fizz";
        [_, _] -> integer_to_list(N)
    end.

