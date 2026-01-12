
main :-
    factorials(1, 10, Factorials),
    write_ln('factorial:'),
    write_ln(Factorials),
    nl,

    fibonacci_numbers(1, 20, FibonacciNumbers),
    write_ln('fibonacci:'),
    write_ln(FibonacciNumbers),
    nl,

    fizz_buzz_values(1, 100, FizzBuzzValues),
    write_ln('FizzBuzz:'),
    write_ln(FizzBuzzValues),
    nl,

    halt.

