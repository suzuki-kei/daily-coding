
main :-
    random_values(Xs, 20),
    print_list(Xs),
    quick_sort(Xs, SortedXs),
    print_list(SortedXs),
    halt.

random_values(Xs, N) :-
    random_values(Xs, [], N).

random_values(Xs, Xs, 0).

random_values(Xs, Accumulated, N) :-
    is(NextN, N - 1),
    random_between(10, 99, X),
    random_values(Xs, [X | Accumulated], NextN).

print_list(Xs) :-
    sorted(Xs, Sorted),
    print_list(Xs, Sorted).

print_list(Xs, true) :-
    atomics_to_string(Xs, " ", FormattedXs),
    format("~s (sorted)~n", [FormattedXs]).

print_list(Xs, false) :-
    atomics_to_string(Xs, " ", FormattedXs),
    format("~s (not sorted)~n", [FormattedXs]).

sorted([], true).

sorted([_ | []], true).

sorted([X1, X2 | _], false) :-
    X1 > X2.

sorted([X1, X2 | Xs], Sorted) :-
    X1 =< X2,
    sorted([X2 | Xs], Sorted).

quick_sort([], []).

quick_sort(Xs, SortedXs) :-
    head(Xs, Pivot),
    partition(Pivot, Xs, LessXs, EqualXs, GreaterXs),
    quick_sort(LessXs, SortedLessXs),
    quick_sort(GreaterXs, SortedGreaterXs),
    append_lists([SortedLessXs, EqualXs, SortedGreaterXs], SortedXs).

head([X | _Xs], X).

partition(Pivot, Xs, LessXs, EqualXs, GreaterXs) :-
    partition(Pivot, Xs, LessXs, EqualXs, GreaterXs, [], [], []).

partition(_Pivot, [], LessXs, EqualXs, GreaterXs, AccumulatedLessXs, AccumulatedEqualXs, AccumulatedGreaterXs) :-
    LessXs = AccumulatedLessXs,
    EqualXs = AccumulatedEqualXs,
    GreaterXs = AccumulatedGreaterXs.

partition(Pivot, [X | Xs], LessXs, EqualXs, GreaterXs, AccumulatedLessXs, AccumulatedEqualXs, AccumulatedGreaterXs) :-
    X < Pivot,
    partition(Pivot, Xs, LessXs, EqualXs, GreaterXs, [X | AccumulatedLessXs], AccumulatedEqualXs, AccumulatedGreaterXs).

partition(Pivot, [X | Xs], LessXs, EqualXs, GreaterXs, AccumulatedLessXs, AccumulatedEqualXs, AccumulatedGreaterXs) :-
    X == Pivot,
    partition(Pivot, Xs, LessXs, EqualXs, GreaterXs, AccumulatedLessXs, [X | AccumulatedEqualXs], AccumulatedGreaterXs).

partition(Pivot, [X | Xs], LessXs, EqualXs, GreaterXs, AccumulatedLessXs, AccumulatedEqualXs, AccumulatedGreaterXs) :-
    X > Pivot,
    partition(Pivot, Xs, LessXs, EqualXs, GreaterXs, AccumulatedLessXs, AccumulatedEqualXs, [X | AccumulatedGreaterXs]).

append_lists(Lists, Appended) :-
    append_lists(Lists, [], Appended).

append_lists([], Accumulated, Appended) :-
    Appended = Accumulated.

append_lists([Xs | []], Accumulated, Appended) :-
    append(Accumulated, Xs, Appended).

append_lists([Xs | Lists], Accumulated, Appended) :-
    append(Accumulated, Xs, NextAccumulated),
    append_lists(Lists, NextAccumulated, Appended).

