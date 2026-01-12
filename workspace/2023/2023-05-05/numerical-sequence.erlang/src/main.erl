-module(main).
-export([main/0, factorial/1, fibonacci/1, fizzbuzz/1]).

main() ->
    show_numerical_sequence("factorials", fun main:factorial/1, 1, 10),
    show_numerical_sequence("fibonacci numbers", fun main:fibonacci/1, 0, 20),
    show_numerical_sequence("FizzBuzz values", fun main:fizzbuzz/1, 1, 100),
    ok.

show_numerical_sequence(Description, F, Lower, Upper) ->
    Xs = lists:map(F, lists:seq(Lower, Upper)),
    io:format("~s:~n~p~n", [Description, Xs]).

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

