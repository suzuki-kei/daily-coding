
main :-
    write_fibonacci_numbers(20),
    halt.

write_fibonacci_numbers(N) :-
    write_fibonacci_numbers(0, N).
write_fibonacci_numbers(Min, Max) :-
    Min > Max.
write_fibonacci_numbers(Min, Max) :-
    Min =< Max,
    write_fibonacci_number(Min),
    is(NextMin, Min + 1),
    write_fibonacci_numbers(NextMin, Max).
    
write_fibonacci_number(N) :-
    fibonacci(N, Fn),
    write('fibonacci('), write(N), write(') = '), write(Fn), nl.

fibonacci(0, 0) :-
    true,
    !.
fibonacci(1, 1) :-
    true,
    !.
fibonacci(N, Fn) :-
    N > 1,
    is(A, N - 2),
    is(B, N - 1),
    fibonacci(A, Fa),
    fibonacci(B, Fb),
    is(Fn, Fa + Fb).

