
main :-
    Xs = [2, 1, 5, 3, 4],
    write('Xs = '), write(Xs), nl,
    minimum(Minimum, Xs), write('Minimum = '), write(Minimum), nl,
    maximum(Maximum, Xs), write('Maximum = '), write(Maximum), nl,
    reversed(Reversed, Xs), write('Reversed = '), write(Reversed), nl,
    halt.

