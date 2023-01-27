
minimum(X, Y, X) :- X =< Y, !.
minimum(X, Y, Y) :- X >= Y, !.

maximum(X, Y, X) :- X >= Y, !.
maximum(X, Y, Y) :- X =< Y, !.

abs(N, X) :- N >= 0, is(X, N), !.
abs(N, X) :- N =< 0, is(X, -N), !.

negate(N, X) :- is(X, -N), !.

square(N, X) :- is(X, N*N), !.

even(0) :- true, !.
even(N) :- N < 0, is(M, -N), even(M), !.
even(N) :- N > 1, is(M, N-2), even(M), !.

odd(1) :- true, !.
odd(N) :- N < 0, is(M, -N), odd(M), !.
odd(N) :- N > 2, is(M, N-2), odd(M), !.

