
selection_sort(Sorted, Xs) :-
    selection_sort(Sorted, [], Xs),
    !.
selection_sort(Result, Sorted, []) :-
    Result = Sorted,
    !.
selection_sort(Result, Sorted, Xs) :-
    maximum_and_others(Maximum, Others, Xs),
    selection_sort(Result, [Maximum|Sorted], Others).

maximum_and_others(Maximum, Others, [X|Xs]) :-
    maximum_and_others(Maximum, Others, X, [], Xs),
    !.
maximum_and_others(Maximum, Others, CurrentMaximum, CurrentOthers, []) :-
    Maximum = CurrentMaximum,
    Others = CurrentOthers,
    !.
maximum_and_others(Maximum, Others, CurrentMaximum, CurrentOthers, [X|Xs]) :-
    CurrentMaximum >= X,
    maximum_and_others(Maximum, Others, CurrentMaximum, [X|CurrentOthers], Xs),
    !.
maximum_and_others(Maximum, Others, CurrentMaximum, CurrentOthers, [X|Xs]) :-
    CurrentMaximum =< X,
    maximum_and_others(Maximum, Others, X, [CurrentMaximum|CurrentOthers], Xs),
    !.

