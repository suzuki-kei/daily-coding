
main :-
    random_values(20, Xs),
    print_list(Xs),
    quick_sort(Xs, SortedXs),
    print_list(SortedXs),
    halt.

random_values(N, Xs) :-
    random_values(N, Xs, []).
random_values(0, Xs, Xs) :-
    true.
random_values(N, Xs, Accumulated) :-
    is(NextN, N - 1),
    random_between(10, 99, X),
    random_values(NextN, Xs, [X | Accumulated]).

print_list(Xs) :-
    sorted(Xs, Sorted),
    print_list(Xs, Sorted).
print_list(Xs, true) :-
    atomics_to_string(Xs, " ", FormattedXs),
    format("~s (sorted)~n", [FormattedXs]).
print_list(Xs, false) :-
    atomics_to_string(Xs, " ", FormattedXs),
    format("~s (not sorted)~n", [FormattedXs]).

sorted([], true) :-
    true.
sorted([_X | []], true) :-
    true.
sorted([X1, X2 | _Xs], false) :-
    X1 > X2.
sorted([X1, X2 | Xs], Sorted) :-
    X1 =< X2,
    sorted([X2 | Xs], Sorted).

quick_sort([], []) :-
    true.
quick_sort(Xs, SortedXs) :-
    head(Xs, Pivot),
    partition(Pivot, Xs, LessXs, EqualXs, GreaterXs),
    quick_sort(LessXs, SortedLessXs),
    quick_sort(GreaterXs, SortedGreaterXs),
    append_lists([SortedLessXs, EqualXs, SortedGreaterXs], SortedXs).

head([X | _Xs], X) :-
    true.

partition(Pivot, Xs, LessXs, EqualXs, GreaterXs) :-
    partition(Pivot, Xs, LessXs, EqualXs, GreaterXs, [], [], []).
partition(_Pivot, [], LessXs, EqualXs, GreaterXs, LessXs, EqualXs, GreaterXs) :-
    true.
partition(Pivot, [X | Xs], LessXs, EqualXs, GreaterXs, AccumulatedLessXs, AccumulatedEqualXs, AccumulatedGreaterXs) :-
    X < Pivot,
    partition(Pivot, Xs, LessXs, EqualXs, GreaterXs, [X | AccumulatedLessXs], AccumulatedEqualXs, AccumulatedGreaterXs).
partition(Pivot, [X | Xs], LessXs, EqualXs, GreaterXs, AccumulatedLessXs, AccumulatedEqualXs, AccumulatedGreaterXs) :-
    X == Pivot,
    partition(Pivot, Xs, LessXs, EqualXs, GreaterXs, AccumulatedLessXs, [X | AccumulatedEqualXs], AccumulatedGreaterXs).
partition(Pivot, [X | Xs], LessXs, EqualXs, GreaterXs, AccumulatedLessXs, AccumulatedEqualXs, AccumulatedGreaterXs) :-
    X > Pivot,
    partition(Pivot, Xs, LessXs, EqualXs, GreaterXs, AccumulatedLessXs, AccumulatedEqualXs, [X | AccumulatedGreaterXs]).

append_lists(Lists, AppendedList) :-
    append_lists(Lists, AppendedList, []).
append_lists([], AppendedList, AppendedList) :-
    true.
append_lists([List | Lists], AppendedList, AccumulatedList) :-
    append(AccumulatedList, List, NextAccumulatedList),
    append_lists(Lists, AppendedList, NextAccumulatedList).

