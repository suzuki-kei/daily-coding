
minimum(X, Y, X) :- X =< Y, !.
minimum(X, Y, Y) :- X >= Y, !.

maximum(X, Y, X) :- X >= Y, !.
maximum(X, Y, Y) :- X =< Y, !.

even(0) :- true, !.
even(X) :- X > 0, is(Y, X - 2), even(Y), !.

odd(1) :- true, !.
odd(X) :- X > 1, is(Y, X - 2), odd(Y), !.

