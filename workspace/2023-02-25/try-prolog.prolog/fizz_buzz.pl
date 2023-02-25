
query_example :-
    fizz_buzz(100).

fizz_buzz(N) :-
    fizz_buzz_range(1, N).

fizz_buzz_range(Min, Max) :-
    Min =< Max,
    fizz_buzz_value(Min),
    is(NextMin, Min + 1),
    fizz_buzz_range(NextMin, Max).

fizz_buzz_value(N) :-
    0 is N mod 15, write('FizzBuzz'), nl, !.
fizz_buzz_value(N) :-
    0 is N mod 5, write('Buzz'), nl, !.
fizz_buzz_value(N) :-
    0 is N mod 3, write('Fizz'), nl, !.
fizz_buzz_value(N) :-
    write(N), nl, !.

