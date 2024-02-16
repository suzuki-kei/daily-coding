
main(_) ->
    print_sequence("factorials", fun factorial/1, 1, 10),
    print_sequence("fibonacci numbers", fun fibonacci/1, 0, 20),
    print_sequence("fizz buzz values", fun fizz_buzz/1, 1, 100).

print_sequence(Description, F, Min, Max) ->
    Values = lists:map(F, lists:seq(Min, Max)),
    String = lists:concat(lists:join(" ", Values)),
    io:format("~s:~n~s~n", [Description, String]).

factorial(N) ->
    factorial_tailrec(N, 1).

factorial_tailrec(0, Accumulated) ->
    Accumulated;
factorial_tailrec(N, Accumulated) ->
    factorial_tailrec(N - 1, Accumulated * N).

fibonacci(N) ->
    fibonacci_tailrec(N, 0, 1).

fibonacci_tailrec(0, A, _) ->
    A;
fibonacci_tailrec(N, A, B) ->
    fibonacci_tailrec(N - 1, B, A + B).

fizz_buzz(N) ->
    case [N rem 5, N rem 3] of
        [0, 0] -> "FizzBuzz";
        [0, _] -> "Buzz";
        [_, 0] -> "Fizz";
        [_, _] -> integer_to_list(N)
    end.

