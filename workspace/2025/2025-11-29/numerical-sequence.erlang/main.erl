
main(_) ->
    print_sequence("factorials", fun factorial/1, 1, 10),
    print_sequence("fibonacci numbers", fun fibonacci/1, 0, 20),
    print_sequence("fizz buzz values", fun fizz_buzz/1, 1, 100).

print_sequence(Label, F, Min, Max) ->
    Values = lists:map(F, lists:seq(Min, Max)),
    Formatted = lists:concat(lists:join(" ", Values)),
    io:format("~s:~n~s~n", [Label, Formatted]).

factorial(N) ->
    factorial(N, 1).

factorial(0, Fm) ->
    Fm;
factorial(N, Fm) ->
    factorial(N - 1, Fm * N).

fibonacci(N) ->
    fibonacci(N, 0, 1).

fibonacci(0, A, _B) ->
    A;
fibonacci(N, A, B) ->
    fibonacci(N - 1, B, A + B).

fizz_buzz(N) ->
    case [N rem 5, N rem 3] of
        [0, 0] -> "FizzBuzz";
        [0, _] -> "Buzz";
        [_, 0] -> "Fizz";
        [_, _] -> integer_to_list(N)
    end.

