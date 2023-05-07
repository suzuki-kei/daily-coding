
fizzbuzz(N, Fn) :-
    (
        N mod 15 =:= 0 ->
            Fn = "FizzBuzz";
        N mod 5 =:= 0 ->
            Fn = "Buzz";
        N mod 3 =:= 0 ->
            Fn = "Fizz";
        otherwise ->
            number_string(N, Fn)
    ).

fizzbuzz_values(N, Xs) :-
    fizzbuzz_values(1, N, Xs).

fizzbuzz_values(Min, Max, []) :-
    Min > Max.

fizzbuzz_values(Min, Max, [X|Xs]) :-
    Min =< Max,
    fizzbuzz(Min, X),
    is(NextMin, Min + 1),
    fizzbuzz_values(NextMin, Max, Xs).

