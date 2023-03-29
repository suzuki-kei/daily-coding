
main(_) ->
    show_factorials(10),
    show_fibonacci_numbers(20),
    show_fizzbuzz_values(100).

factorial(0) ->
    1;
factorial(N) ->
    N * factorial(N - 1).

show_factorials(N) ->
    io:format("factorials:~n"),
    show_factorials(0, N),
    io:format("~n").

show_factorials(Min, Max) when Min > Max ->
    ok;
show_factorials(Min, Max) when Min =< Max ->
    io:format("~w ", [factorial(Min)]),
    show_factorials(Min + 1, Max).

fibonacci(0) ->
    0;
fibonacci(1) ->
    1;
fibonacci(N) ->
    fibonacci(N - 1) + fibonacci(N - 2).

show_fibonacci_numbers(N) ->
    io:format("fibonacci numbers:~n"),
    show_fibonacci_numbers(0, N),
    io:format("~n").

show_fibonacci_numbers(Min, Max) when Min > Max ->
    ok;
show_fibonacci_numbers(Min, Max) when Min =< Max ->
    io:format("~w ", [fibonacci(Min)]),
    show_fibonacci_numbers(Min + 1, Max).

fizzbuzz(N) ->
    if
        N rem 15 == 0 -> "FizzBuzz";
        N rem  5 == 0 -> "Buzz";
        N rem  3 == 0 -> "Fizz";
        true          -> integer_to_list(N)
    end.

show_fizzbuzz_values(N) ->
    io:format("fizzbuzz values:~n"),
    show_fizzbuzz_values(1, N),
    io:format("~n").

show_fizzbuzz_values(Min, Max) when Min > Max ->
    ok;
show_fizzbuzz_values(Min, Max) when Min =< Max ->
    io:format("~s ", [fizzbuzz(Min)]),
    show_fizzbuzz_values(Min + 1, Max).

