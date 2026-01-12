
reversed(Reversed, Xs) :-
    reversed(Reversed, [], Xs),
    !.
reversed(Reversed, CurrentReversed, []) :-
    Reversed = CurrentReversed,
    !.
reversed(Reversed, CurrentReversed, [X|Xs]) :-
    reversed(Reversed, [X|CurrentReversed], Xs),
    !.

