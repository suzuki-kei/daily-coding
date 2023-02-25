
minimum(Minimum, [X|Xs]) :-
    minimum(Minimum, X, Xs).
minimum(Minimum, CurrentMinimum, []) :-
    is(Minimum, CurrentMinimum),
    !.
minimum(Minimum, CurrentMinimum, [X|Xs]) :-
    X =< CurrentMinimum,
    minimum(Minimum, X, Xs),
    !.
minimum(Minimum, CurrentMinimum, [X|Xs]) :-
    X >= CurrentMinimum,
    minimum(Minimum, CurrentMinimum, Xs),
    !.

