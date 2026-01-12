
quick_sort(Sorted, []) :-
    Sorted = [],
    !.
quick_sort(Sorted, [X|Xs]) :-
    partition(Less, Equal, Greater, X, [X|Xs]),
    quick_sort(SortedLess, Less),
    quick_sort(SortedGreater, Greater),
    appends(Sorted, [SortedLess, Equal, SortedGreater]),
    !.

partition(Less, Equal, Greater, Pivot, Xs) :-
    partition(Less, Equal, Greater, [], [], [], Pivot, Xs),
    !.
partition(Less, Equal, Greater, CurrentLess, CurrentEqual, CurrentGreater, Pivot, []) :-
    Less = CurrentLess,
    Equal = CurrentEqual,
    Greater = CurrentGreater,
    !.
partition(Less, Equal, Greater, CurrentLess, CurrentEqual, CurrentGreater, Pivot, [X|Xs]) :-
    X < Pivot,
    partition(Less, Equal, Greater, [X|CurrentLess], CurrentEqual, CurrentGreater, Pivot, Xs),
    !.
partition(Less, Equal, Greater, CurrentLess, CurrentEqual, CurrentGreater, Pivot, [X|Xs]) :-
    X =:= Pivot,
    partition(Less, Equal, Greater, CurrentLess, [X|CurrentEqual], CurrentGreater, Pivot, Xs),
    !.
partition(Less, Equal, Greater, CurrentLess, CurrentEqual, CurrentGreater, Pivot, [X|Xs]) :-
    X > Pivot,
    partition(Less, Equal, Greater, CurrentLess, CurrentEqual, [X|CurrentGreater], Pivot, Xs),
    !.

appends(Appended, Lists) :-
    appends(Appended, [], Lists),
    !.
appends(Appended, CurrentAppended, []) :-
    Appended = CurrentAppended,
    !.
appends(Appended, CurrentAppended, [List|Lists]) :-
    append(CurrentAppended, List, NextAppended),
    appends(Appended, NextAppended, Lists),
    !.

