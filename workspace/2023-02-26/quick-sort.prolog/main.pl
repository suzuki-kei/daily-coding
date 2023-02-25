
main :-
    random_values(Xs, 20),
    write_values(Xs),
    quick_sort(Sorted, Xs),
    write_values(Sorted),
    halt.

random_values(Xs, N) :-
    randomize,
    random_values(Xs, [], N),
    !.
random_values(Xs, CurrentXs, 0) :-
    Xs = CurrentXs,
    !.
random_values(Xs, CurrentXs, N) :-
    N > 0,
    random(10, 100, X),
    is(NextN, N - 1),
    random_values(Xs, [X|CurrentXs], NextN),
    !.

write_values(Xs) :-
    sorted_string(SortedString, Xs),
    write(Xs), write(' '), write(SortedString), nl,
    !.

sorted(Sorted, []) :-
    Sorted = true,
    !.
sorted(Sorted, [_|[]]) :-
    Sorted = true,
    !.
sorted(Sorted, [X1,X2|_]) :-
    X1 > X2,
    Sorted = false,
    !.
sorted(Sorted, [X1,X2|Xs]) :-
    X1 =< X2,
    sorted(Sorted, [X2|Xs]),
    !.

sorted_string(SortedString, Xs) :-
    sorted(Sorted, Xs),
    (Sorted ->
        SortedString = '(sorted)';
        SortedString = '(not sorted)'
    ).

