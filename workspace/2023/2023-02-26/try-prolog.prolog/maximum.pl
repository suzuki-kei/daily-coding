
maximum(Maximum, [X|Xs]) :-
    maximum(Maximum, X, Xs).
maximum(Maximum, CurrentMaximum, []) :-
    is(Maximum, CurrentMaximum),
    !.
maximum(Maximum, CurrentMaximum, [X|Xs]) :-
    X >= CurrentMaximum,
    maximum(Maximum, X, Xs),
    !.
maximum(Maximum, CurrentMaximum, [X|Xs]) :-
    X =< CurrentMaximum,
    maximum(Maximum, CurrentMaximum, Xs),
    !.

